/* run.c --- routines for executing subprocesses.
   
   This file is part of GNU CVS.

   GNU CVS is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.  */

#include "cvs.h"
#include "vasnprintf.h"

/* Get wint_t.  */
#ifdef HAVE_WINT_T
# include <wchar.h>
#endif

#ifndef HAVE_UNISTD_H
extern int execvp (char *file, char **argv);
#endif

static void run_add_arg (const char *s);
static void cmdline_bindings_hash_node_delete (Node *p);

extern char *strtok (char *, const char *);

typedef int (*CONVPROC_t) (Node *, void *);

/*
 * To exec a program under CVS, first call run_setup() to setup initial
 * arguments.  The argument to run_setup will be parsed into whitespace 
 * separated words and added to the global run_argv list.
 * 
 * Then, optionally call run_arg() for each additional argument that you'd like
 * to pass to the executed program.
 * 
 * Finally, call run_exec() to execute the program with the specified arguments.
 * The execvp() syscall will be used, so that the PATH is searched correctly.
 * File redirections can be performed in the call to run_exec().
 */
static char **run_argv;
static int run_argc;
static int run_argc_allocated;

/* VARARGS */
void 
run_setup( const char *prog )
{
    int i;
    char *run_prog;
    char *buf, *d, *s;
    size_t length;
    size_t doff;
    char inquotes;
    int dolastarg;

    /* clean out any malloc'ed values from run_argv */
    for (i = 0; i < run_argc; i++)
    {
	if (run_argv[i])
	{
	    free (run_argv[i]);
	    run_argv[i] = (char *) 0;
	}
    }
    run_argc = 0;

    run_prog = xstrdup (prog);

    s = run_prog;
    d = buf = NULL;
    length = 0;
    dolastarg = 1;
    inquotes = '\0';
    doff = d - buf;
    expand_string(&buf, &length, doff + 1);
    d = buf + doff;
    while ((*d = *s++) != '\0')
    {
	switch (*d)
	{
	    case '\\':
		if (*s) *d = *s++;
		d++;
		break;
	    case '"':
	    case '\'':
		if (inquotes == *d) inquotes = '\0';
		else inquotes = *d;
		break;
	    case ' ':
	    case '\t':
		if (inquotes) d++;
		else
		{
		    *d = '\0';
		    run_add_arg (buf);
		    d = buf;
		    while (isspace(*s)) s++;
		    if (!*s) dolastarg = 0;
		}
		break;
	    default:
		d++;
		break;
	}
	doff = d - buf;
	expand_string(&buf, &length, doff + 1);
	d = buf + doff;
    }
    if (dolastarg) run_add_arg (buf);
    /* put each word into run_argv, allocating it as we go */
    if (buf) free (buf);
    free (run_prog);
}

void
run_arg (const char *s)
{
    run_add_arg (s);
}

static void
run_add_arg (const char *s)
{
    /* allocate more argv entries if we've run out */
    if (run_argc >= run_argc_allocated)
    {
	run_argc_allocated += 50;
	run_argv = (char **) xrealloc ((char *) run_argv,
				     run_argc_allocated * sizeof (char **));
    }

    if (s)
	run_argv[run_argc++] = xstrdup (s);
    else
	run_argv[run_argc] = (char *) 0;	/* not post-incremented on purpose! */
}

int
run_exec (const char *stin, const char *stout, const char *sterr, int flags)
{
    int shin, shout, sherr;
    int mode_out, mode_err;
    int status;
    int rc = -1;
    int rerrno = 0;
    int pid, w;

#ifdef POSIX_SIGNALS
    sigset_t sigset_mask, sigset_omask;
    struct sigaction act, iact, qact;

#else
#ifdef BSD_SIGNALS
    int mask;
    struct sigvec vec, ivec, qvec;

#else
    RETSIGTYPE (*istat) (), (*qstat) ();
#endif
#endif

    if (trace)
    {
#ifdef SERVER_SUPPORT
	cvs_outerr (server_active ? "S" : " ", 1);
#endif
	cvs_outerr ("-> system(", 0);
	run_print (stderr);
	cvs_outerr (")\n", 0);
    }
    if (noexec && (flags & RUN_REALLY) == 0)
	return (0);

    /* make sure that we are null terminated, since we didn't calloc */
    run_add_arg ((char *) 0);

    /* setup default file descriptor numbers */
    shin = 0;
    shout = 1;
    sherr = 2;

    /* set the file modes for stdout and stderr */
    mode_out = mode_err = O_WRONLY | O_CREAT;
    mode_out |= ((flags & RUN_STDOUT_APPEND) ? O_APPEND : O_TRUNC);
    mode_err |= ((flags & RUN_STDERR_APPEND) ? O_APPEND : O_TRUNC);

    if (stin && (shin = open (stin, O_RDONLY)) == -1)
    {
	rerrno = errno;
	error (0, errno, "cannot open %s for reading (prog %s)",
	       stin, run_argv[0]);
	goto out0;
    }
    if (stout && (shout = open (stout, mode_out, 0666)) == -1)
    {
	rerrno = errno;
	error (0, errno, "cannot open %s for writing (prog %s)",
	       stout, run_argv[0]);
	goto out1;
    }
    if (sterr && (flags & RUN_COMBINED) == 0)
    {
	if ((sherr = open (sterr, mode_err, 0666)) == -1)
	{
	    rerrno = errno;
	    error (0, errno, "cannot open %s for writing (prog %s)",
		   sterr, run_argv[0]);
	    goto out2;
	}
    }

    /* Make sure we don't flush this twice, once in the subprocess.  */
    fflush (stdout);
    fflush (stderr);

    /* The output files, if any, are now created.  Do the fork and dups.

       We use vfork not so much for a performance boost (the
       performance boost, if any, is modest on most modern unices),
       but for the sake of systems without a memory management unit,
       which find it difficult or impossible to implement fork at all
       (e.g. Amiga).  The other solution is spawn (see
       windows-NT/run.c).  */

#ifdef HAVE_VFORK
    pid = vfork ();
#else
    pid = fork ();
#endif
    if (pid == 0)
    {
	if (shin != 0)
	{
	    (void) dup2 (shin, 0);
	    (void) close (shin);
	}
	if (shout != 1)
	{
	    (void) dup2 (shout, 1);
	    (void) close (shout);
	}
	if (flags & RUN_COMBINED)
	    (void) dup2 (1, 2);
	else if (sherr != 2)
	{
	    (void) dup2 (sherr, 2);
	    (void) close (sherr);
	}

#ifdef SETXID_SUPPORT
	/*
	** This prevents a user from creating a privileged shell
	** from the text editor when the SETXID_SUPPORT option is selected.
	*/
	if (!strcmp (run_argv[0], Editor) && setegid (getgid ()))
	{
	    error (0, errno, "cannot set egid to gid");
	    _exit (127);
	}
#endif

	/* dup'ing is done.  try to run it now */
	(void) execvp (run_argv[0], run_argv);
	error (0, errno, "cannot exec %s", run_argv[0]);
	_exit (127);
    }
    else if (pid == -1)
    {
	rerrno = errno;
	goto out;
    }

    /* the parent.  Ignore some signals for now */
#ifdef POSIX_SIGNALS
    if (flags & RUN_SIGIGNORE)
    {
	act.sa_handler = SIG_IGN;
	(void) sigemptyset (&act.sa_mask);
	act.sa_flags = 0;
	(void) sigaction (SIGINT, &act, &iact);
	(void) sigaction (SIGQUIT, &act, &qact);
    }
    else
    {
	(void) sigemptyset (&sigset_mask);
	(void) sigaddset (&sigset_mask, SIGINT);
	(void) sigaddset (&sigset_mask, SIGQUIT);
	(void) sigprocmask (SIG_SETMASK, &sigset_mask, &sigset_omask);
    }
#else
#ifdef BSD_SIGNALS
    if (flags & RUN_SIGIGNORE)
    {
	memset ((char *) &vec, 0, sizeof (vec));
	vec.sv_handler = SIG_IGN;
	(void) sigvec (SIGINT, &vec, &ivec);
	(void) sigvec (SIGQUIT, &vec, &qvec);
    }
    else
	mask = sigblock (sigmask (SIGINT) | sigmask (SIGQUIT));
#else
    istat = signal (SIGINT, SIG_IGN);
    qstat = signal (SIGQUIT, SIG_IGN);
#endif
#endif

    /* wait for our process to die and munge return status */
#ifdef POSIX_SIGNALS
    while ((w = waitpid (pid, &status, 0)) == -1 && errno == EINTR)
	;
#else
    while ((w = wait (&status)) != pid)
    {
	if (w == -1 && errno != EINTR)
	    break;
    }
#endif

    if (w == -1)
    {
	rc = -1;
	rerrno = errno;
    }
#ifndef VMS /* status is return status */
    else if (WIFEXITED (status))
	rc = WEXITSTATUS (status);
    else if (WIFSIGNALED (status))
    {
	if (WTERMSIG (status) == SIGPIPE)
	    error (1, 0, "broken pipe");
	rc = 2;
    }
    else
	rc = 1;
#else /* VMS */
    rc = WEXITSTATUS (status);
#endif /* VMS */

    /* restore the signals */
#ifdef POSIX_SIGNALS
    if (flags & RUN_SIGIGNORE)
    {
	(void) sigaction (SIGINT, &iact, (struct sigaction *) NULL);
	(void) sigaction (SIGQUIT, &qact, (struct sigaction *) NULL);
    }
    else
	(void) sigprocmask (SIG_SETMASK, &sigset_omask, (sigset_t *) NULL);
#else
#ifdef BSD_SIGNALS
    if (flags & RUN_SIGIGNORE)
    {
	(void) sigvec (SIGINT, &ivec, (struct sigvec *) NULL);
	(void) sigvec (SIGQUIT, &qvec, (struct sigvec *) NULL);
    }
    else
	(void) sigsetmask (mask);
#else
    (void) signal (SIGINT, istat);
    (void) signal (SIGQUIT, qstat);
#endif
#endif

    /* cleanup the open file descriptors */
  out:
    if (sterr)
	(void) close (sherr);
    else
	/* ensure things are received by the parent in the correct order
	 * relative to the protocol pipe
	 */
	cvs_flusherr();
  out2:
    if (stout)
	(void) close (shout);
    else
	/* ensure things are received by the parent in the correct order
	 * relative to the protocol pipe
	 */
	cvs_flushout();
  out1:
    if (stin)
	(void) close (shin);

  out0:
    if (rerrno)
	errno = rerrno;
    return (rc);
}

void
run_print (FILE *fp)
{
    int i;
    void (*outfn) (const char *, size_t);

    if (fp == stderr)
	outfn = cvs_outerr;
    else if (fp == stdout)
	outfn = cvs_output;
    else
    {
	error (1, 0, "internal error: bad argument to run_print");
	/* Solely to placate gcc -Wall.
	   FIXME: it'd be better to use a function named `fatal' that
	   is known never to return.  Then kludges wouldn't be necessary.  */
	outfn = NULL;
    }

    for (i = 0; i < run_argc; i++)
    {
	(*outfn) ("'", 1);
	(*outfn) (run_argv[i], 0);
	(*outfn) ("'", 1);
	if (i != run_argc - 1)
	    (*outfn) (" ", 1);
    }
}

/* Return value is NULL for error, or if noexec was set.  If there was an
   error, return NULL and I'm not sure whether errno was set (the Red Hat
   Linux 4.1 popen manpage was kind of vague but discouraging; and the noexec
   case complicates this even aside from popen behavior).  */

FILE *
run_popen (const char *cmd, const char *mode)
{
    TRACE ( 1, "run_popen(%s,%s)", cmd, mode );
    if (noexec)
	return (NULL);

    return (popen (cmd, mode));
}

int
piped_child (char **command, int *tofdp, int *fromfdp)
{
    int pid;
    int to_child_pipe[2];
    int from_child_pipe[2];

    if (pipe (to_child_pipe) < 0)
	error (1, errno, "cannot create pipe");
    if (pipe (from_child_pipe) < 0)
	error (1, errno, "cannot create pipe");

#ifdef USE_SETMODE_BINARY
    setmode (to_child_pipe[0], O_BINARY);
    setmode (to_child_pipe[1], O_BINARY);
    setmode (from_child_pipe[0], O_BINARY);
    setmode (from_child_pipe[1], O_BINARY);
#endif

#ifdef HAVE_VFORK
    pid = vfork ();
#else
    pid = fork ();
#endif
    if (pid < 0)
	error (1, errno, "cannot fork");
    if (pid == 0)
    {
	if (dup2 (to_child_pipe[0], STDIN_FILENO) < 0)
	    error (1, errno, "cannot dup2 pipe");
	if (close (to_child_pipe[1]) < 0)
	    error (1, errno, "cannot close pipe");
	if (close (from_child_pipe[0]) < 0)
	    error (1, errno, "cannot close pipe");
	if (dup2 (from_child_pipe[1], STDOUT_FILENO) < 0)
	    error (1, errno, "cannot dup2 pipe");

	execvp (command[0], command);
	error (1, errno, "cannot exec %s", command[0]);
    }
    if (close (to_child_pipe[0]) < 0)
	error (1, errno, "cannot close pipe");
    if (close (from_child_pipe[1]) < 0)
	error (1, errno, "cannot close pipe");

    *tofdp = to_child_pipe[1];
    *fromfdp = from_child_pipe[0];
    return pid;
}


void
close_on_exec (int fd)
{
#ifdef F_SETFD
    if (fcntl (fd, F_SETFD, 1) == -1)
	error (1, errno, "can't set close-on-exec flag on %d", fd);
#endif
}



/* used to store callback data in a list indexed by the user format string
 */
struct cmdline_bindings
{
    char conversion;
    void *data;
    int (*convproc) (Node *, void *);
    void *closure;
};
/* since we store the above in a list, we need to dispose of the data field.
 * we don't have to worry about convproc or closure since pointers are stuck
 * in there directly and format_cmdline's caller is responsible for disposing
 * of those if necessary.
 */
static void
cmdline_bindings_hash_node_delete (p)
    Node *p;
{
    struct cmdline_bindings *b = p->data;

    if (b->conversion != ',')
    {
	free (b->data);
    }
    free (b);
}

/*
 * assume s is a literal argument and put it between quotes,
 * escaping as appropriate for a shell command line
 *
 * the caller is responsible for disposing of the new string
 */
char *
cmdlinequote (char quotes, char *s)
{
    char *quoted = cmdlineescape (quotes, s);
    char *buf = xmalloc(strlen(quoted)+3);

    buf[0] = quotes;
    buf[1] = '\0';
    strcat (buf, quoted);
    free (quoted);
    buf[strlen(buf)+1] = '\0';
    buf[strlen(buf)] = quotes;
    return buf;
}

/* read quotes as the type of quotes we are between (if any) and then make our
 * argument so it could make it past a cmdline parser (using sh as a model)
 * inside the quotes (if any).
 *
 * if you were planning on expanding any paths, it should be done before
 * calling this function, as it escapes shell metacharacters.
 *
 * the caller is responsible for disposing of the new string
 *
 * FIXME: See about removing/combining this functionality with shell_escape()
 * in subr.c.
 */
char *
cmdlineescape (char quotes, char *s)
{
    char *buf = NULL;
    size_t length = 0;
    char *d = NULL;
    size_t doff;
    char *lastspace;

    lastspace = s - 1;
    do
    {
	/* FIXME: Single quotes only require other single quotes to be escaped
	 * for Bourne Shell.
	 */
	if ( isspace( *s ) ) lastspace = s;
	if( quotes
	    ? ( *s == quotes
	        || ( quotes == '"'
	             && ( *s == '$' || *s == '`' || *s == '\\' ) ) )
	    : ( strchr( "\\$`'\"*?", *s )
	        || isspace( *s )
	        || ( lastspace == ( s - 1 )
	             && *s == '~' ) ) )
	{
	    doff = d - buf;
	    expand_string (&buf, &length, doff + 1);
	    d = buf + doff;
	    *d++ = '\\';
	}	
	doff = d - buf;
	expand_string (&buf, &length, doff + 1);
	d = buf + doff;
    } while ((*d++ = *s++) != '\0');
    return (buf);
}



/* expand format strings in a command line.  modeled roughly after printf
 *
 * this function's arg list must be NULL terminated
 *
 * assume a space delimited list of args is the desired final output,
 * but args can be quoted (" or ').
 *
 * the best usage examples are in tag.c & logmsg.c, but here goes:
 *
 * INPUTS
 *    int oldway	to support old format strings
 *    char *srepos	you guessed it
 *    char *format	the format string to parse
 *    ...		NULL terminated data list in the following format:
 *    			char *userformat, char *printfformat, <type> data
 *    			    where
 *    				char *userformat	a list of possible
 *    							format characters the
 *    							end user might pass us
 *    							in the format string
 *    							(e.g. those found in
 *    							taginfo or loginfo)
 *    							multiple characters in
 *    							this strings will be
 *    							aliases for each other
 *    				char *printfformat	the same list of args
 *    							printf uses to
 *    							determine what kind of
 *    							data the next arg will
 *    							be
 *    				<type> data		a piece of data to be
 *    							formatted into the user
 *    							string, <type>
 *    							determined by the
 *    							printfformat string.
 *    		or	
 *    			char *userformat, char *printfformat, List *data,
 *    				int (*convproc) (Node *, void *), void *closure
 *    			    where
 *    				char *userformat	same as above, except
 *    							multiple characters in
 *    							this string represent
 *    							different node
 *    							attributes which can be
 *    							retrieved from data by
 *    							convproc
 *    				char *printfformat	= ","
 *				List *data		the list to be walked
 *							with walklist &
 *							convproc to retrieve
 *							data for each of the
 *							possible format
 *							characters in
 *							userformat
 *				int (*convproc)()	see data
 *				void *closure		arg to be passed into
 *							walklist as closure
 *							data for convproc
 *
 * EXAMPLE
 *    (ignoring oldway variable and srepos since those are only around while we
 *    SUPPORT_OLD_INFO_FMT_STRINGS)
 *    format_cmdline( "/cvsroot/CVSROOT/mytaginfoproc %t %o %{sVv}",
 *                    "t", "s", "newtag",
 *                    "o", "s", "mov",
 *                    "xG", "ld", longintwhichwontbeusedthispass,
 *                    "sVv", ",", tlist, pretag_list_to_args_proc,
 *                      (void *) mydata,
 *                    (char *)NULL);
 *
 *    would generate the following command line, assuming two files in tlist,
 *    file1 & file2, each with old versions 1.1 and new version 1.1.2.3:
 *
 *    	  /cvsroot/CVSROOT/mytaginfoproc "newtag" "mov" "file1" "1.1" "1.1.2.3" "file2" "1.1" "1.1.2.3"
 *
 * RETURNS
 *    pointer to newly allocated string.  the caller is responsible for
 *    disposing of this string.
 */
char *
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
format_cmdline (int oldway, char *srepos, char *format, ...)
#else /* SUPPORT_OLD_INFO_FMT_STRINGS */
format_cmdline (char *format, ...)
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
{
    va_list args;	/* our input function args */
    char *buf;		/* where we store our output string */
    size_t length;	/* the allocated length of our output string in bytes.
			 * used as a temporary storage for the length of the
			 * next function argument during function
			 * initialization
			 */
    char *pfmt;		/* initially the list of fmt keys passed in,
			 * but used as a temporary key buffer later
			 */
    char *fmt;		/* buffer for format string which we are processing */
    size_t flen;	/* length of fmt buffer */
    char *d, *q, *r,
         *s;		/* for walking strings */
    size_t doff, qoff;
    char inquotes;

    List *pflist = getlist();	/* our list of input data indexed by format
				 * "strings"
				 */
    Node *p;
    struct cmdline_bindings *b;
    static int warned_of_deprecation = 0;
    char key[] = "?";		/* Used as temporary storage for a single
				 * character search string used to locate a
				 * hash key.
				 */
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
    /* state varialbes in the while loop which parses the actual
     * format string in the final parsing pass*/
    int onearg;
    int subbedsomething;
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */

#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
    if (oldway && !warned_of_deprecation)
    {
	/* warn the user that we don't like his kind 'round these parts */
	warned_of_deprecation = 1;
	error (0, 0,
"warning:  Set to use deprecated info format strings.  Establish\n"
"compatibility with the new info file format strings (add a temporary '1' in\n"
"all info files after each '%%' which doesn't represent a literal percent)\n"
"and set UseNewInfoFmtStrings=yes in CVSROOT/config.  After that, convert\n"
"individual command lines and scripts to handle the new format at your\n"
"leisure.");
    }
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */

    va_start (args, format);

    /* read our possible format strings
     * expect a certain number of arguments by type and a NULL format
     * string to terminate the list.
     */
    while ((pfmt = va_arg (args, char *)) != NULL)
    {
	char *conversion = va_arg (args, char *);

	char conversion_error = 0;
	char char_conversion = 0;
	char decimal_conversion = 0;
	char integer_conversion = 0;
	char string_conversion = 0;

	/* allocate space to save our data */
	b = xmalloc(sizeof(struct cmdline_bindings));

	/* where did you think we were going to store all this data??? */
	b->convproc = NULL;
	b->closure = NULL;

	/* read a length from the conversion string */
	s = conversion;
	length = 0;
	while (!length && *s)
	{
	    switch (*s)
	    {
		case 'h':
		    integer_conversion = 1;
		    if (s[1] == 'h')
		    {
			length = sizeof (char);
			s += 2;
		    }
		    else
		    {
			char_conversion = 1;
			length = sizeof (short);
			s++;
		    }
		    break;
#ifdef HAVE_INTMAX_T
		case 'j':
		    integer_conversion = 1;
		    length = sizeof (intmax_t);
		    s++;
		    break;
#endif /* HAVE_INTMAX_T */
		case 'l':
		    integer_conversion = 1;
		    if (s[1] == 'l')
		    {
#ifdef HAVE_LONG_LONG
			length = sizeof (long long);
#endif
			s += 2;
		    }
		    else
		    {
			char_conversion = 2;
			string_conversion = 2;
			length = sizeof (long);
			s++;
		    }
		    break;
		case 't':
		    integer_conversion = 1;
		    length = sizeof (ptrdiff_t);
		    s++;
		    break;
		case 'z':
		    integer_conversion = 1;
		    length = sizeof (size_t);
		    s++;
		    break;
#ifdef HAVE_LONG_DOUBLE
		case 'L':
		    decimal_conversion = 1;
		    length = sizeof (long double);
		    s++;
		    break;
#endif
		default:
		    char_conversion = 1;
		    decimal_conversion = 1;
		    integer_conversion = 1;
		    string_conversion = 1;
		    /* take care of it when we find out what we're looking for */
		    length = -1;
		    break;
	    }
	}
	/* if we don't have a valid conversion left, that is an error */
	/* read an argument conversion */
	buf = xmalloc (strlen(conversion) + 2);
	*buf = '%';
	strcpy (buf+1, conversion);
	switch (*s)
	{
	    size_t dummy;
	    case 'c':
		/* chars (an integer conversion) */
		if (!char_conversion)
		{
		    conversion_error = 1;
		    break;
		}
		if (char_conversion == 2)
		{
#ifdef HAVE_WINT_T
		    length = sizeof (wint_t);
#else
		    conversion_error = 1;
		    break;
#endif
		}
		else
		    length = sizeof (char);
		/* fall through... */
	    case 'd':
	    case 'i':
	    case 'o':
	    case 'u':
	    case 'x':
	    case 'X':
		/* integer conversions */
		if (!integer_conversion)
		{
		    conversion_error = 1;
		    break;
		}
		if (length == -1)
		{
		    length = sizeof (int);
		}
		switch (length)
		{
		    case sizeof(char):
		    {
		    	char arg_char = (char) va_arg (args, int);
			b->data = asnprintf(NULL, &dummy, buf, arg_char);
			break;
		    }
#ifdef UNIQUE_INT_TYPE_WINT_T		/* implies HAVE_WINT_T */
		    case sizeof(wint_t):
		    {
		    	wint_t arg_wint_t = va_arg (args, wint_t);
			b->data = asnprintf(NULL, &dummy, buf, arg_wint_t);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_WINT_T */
#ifdef UNIQUE_INT_TYPE_SHORT
		    case sizeof(short):
		    {
		    	short arg_short = (short) va_arg (args, int);
			b->data = asnprintf(NULL, &dummy, buf, arg_short);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_SHORT */
#ifdef UNIQUE_INT_TYPE_INT
		    case sizeof(int):
		    {
		    	int arg_int = va_arg (args, int);
			b->data = asnprintf(NULL, &dummy, buf, arg_int);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_INT */
#ifdef UNIQUE_INT_TYPE_LONG
		    case sizeof(long):
		    {
		    	long arg_long = va_arg (args, long);
			b->data = asnprintf(NULL, &dummy, buf, arg_long);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_LONG */
#ifdef UNIQUE_INT_TYPE_LONG_LONG	/* implies HAVE_LONG_LONG */
		    case sizeof(long long):
		    {
		    	long long arg_long_long = va_arg (args, long long);
			b->data = asnprintf(NULL, &dummy, buf, arg_long_long);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_LONG_LONG */
#ifdef UNIQUE_INT_TYPE_INTMAX_T		/* implies HAVE_INTMAX_T */
		    case sizeof(intmax_t):
		    {
		    	intmax_t arg_intmax_t = va_arg (args, intmax_t);
			b->data = asnprintf(NULL, &dummy, buf, arg_intmax_t);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_INTMAX_T */
#ifdef UNIQUE_INT_TYPE_SIZE_T
		    case sizeof(size_t):
		    {
		    	size_t arg_size_t = va_arg (args, size_t);
			b->data = asnprintf(NULL, &dummy, buf, arg_size_t);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_SIZE_T */
#ifdef UNIQUE_INT_TYPE_PTRDIFF_T
		    case sizeof(ptrdiff_t):
		    {
		    	ptrdiff_t arg_ptrdiff_t = va_arg (args, ptrdiff_t);
			b->data = asnprintf(NULL, &dummy, buf, arg_ptrdiff_t);
			break;
		    }
#endif /* UNIQUE_INT_TYPE_PTRDIFF_T */
		    default:
	    		dellist(&pflist);
	    		free(b);
			error (1, 0,
"internal error:  unknown integer arg size (%d)",
                               length);
			break;
		}
		break;
	    case 'a':
	    case 'A':
	    case 'e':
	    case 'E':
	    case 'f':
	    case 'F':
	    case 'g':
	    case 'G':
		/* decimal conversions */
		if (!decimal_conversion)
		{
		    conversion_error = 1;
		    break;
		}
		if (length == -1)
		{
		    length = sizeof (double);
		}
		switch (length)
		{
		    case sizeof(double):
		    {
		    	double arg_double = va_arg (args, double);
			b->data = asnprintf(NULL, &dummy, buf, arg_double);
			break;
		    }
#ifdef UNIQUE_FLOAT_TYPE_LONG_DOUBLE	/* implies HAVE_LONG_DOUBLE */
		    case sizeof(long double):
		    {
		    	long double arg_long_double = va_arg (args, long double);
			b->data = asnprintf(NULL, &dummy, buf, arg_long_double);
			break;
		    }
#endif /* UNIQUE_FLOAT_TYPE_LONG_DOUBLE */
		    default:
	    		dellist(&pflist);
	    		free(b);
			error (1, 0,
"internal error:  unknown floating point arg size (%d)",
                               length);
			break;
		}
		break;
	    case 's':
		switch (string_conversion)
		{
		    case 1:
			b->data = xstrdup (va_arg (args, char *));
			break;
#ifdef HAVE_WCHAR_T
		    case 2:
		    {
		    	wchar_t *arg_wchar_t_string = va_arg (args, wchar_t *);
			b->data = asnprintf (NULL, &dummy, buf,
			                     arg_wchar_t_string);
			break;
		    }
#endif /* HAVE_WCHAR_T */
		    default:
			conversion_error = 1;
			break;
		}
		break;
	    case ',':
		if (length != -1)
		{
		    conversion_error = 1;
		    break;
		}
		b->data = va_arg (args, List *);
		b->convproc = va_arg (args, CONVPROC_t);
		b->closure = va_arg (args, void *);
		break;
	    default:
		conversion_error = 1;
		break;
	}
	free (buf);
	/* fail if we found an error or haven't found the end of the string */
	if (conversion_error || s[1])
	{
	    error (1, 0,
"internal error (format_cmdline): '%s' is not a valid conversion!!!",
                   conversion);
	}


	/* save our type  - we really only care wheter it's a list type (',')
	 * or not from now on, but what the hell...
	 */
	b->conversion = *s;

	/* separate the user format string into parts and stuff our data into
	 * the pflist (once for each possible string - diverse keys can have
	 * duplicate data).
	 */
	q = pfmt;
	while (*q)
	{
    	    struct cmdline_bindings *tb;
	    if (*q == '{')
	    {
		s = q + 1;
		while (*++q && *q != '}');
		r = q + 1;
	    }
	    else
	    {
		s = q++;
		r = q;
	    }
	    if (*r)
	    {
		/* copy the data since we'll need it again */
    	    	tb = xmalloc(sizeof(struct cmdline_bindings));
		if (b->conversion == ',')
		{
		    tb->data = b->data;
		}
		else
		{
		    tb->data = xstrdup(b->data);
		}
		tb->conversion = b->conversion;
		tb->convproc = b->convproc;
		tb->closure = b->closure;
	    }
	    else
	    {
		/* we're done after this, so we don't need to copy the data */
		tb = b;
	    }
	    p = getnode();
	    p->key = xmalloc((q - s) + 1);
	    strncpy (p->key, s, q - s);
	    p->key[q-s] = '\0';
	    p->data = tb;
	    p->delproc = cmdline_bindings_hash_node_delete;
	    addnode(pflist,p);
	}
    }

    /* we're done with va_list */
    va_end(args);

    /* All formatted strings include a format character that resolves to the
     * empty string by default, so put it in pflist.
     */
    /* allocate space to save our data */
    b = xmalloc(sizeof(struct cmdline_bindings));
    b->conversion = 's';
    b->convproc = NULL;
    b->closure = NULL;
    b->data = xstrdup( "" );
    p = getnode();
    p->key = xstrdup( "n" );
    p->data = b;
    p->delproc = cmdline_bindings_hash_node_delete;
    addnode( pflist,p );

    /* finally, read the user string and copy it into rargv as appropriate */
    /* user format strings look as follows:
     *
     * %% is a literal %
     * \X, where X is any character = \X, (this is the escape you'd expect, but
     *        we are leaving the \ for an expected final pass which splits our
     *        output string into separate arguments
     *
     * %X means sub var "X" into location
     * %{VWXYZ} means sub V,W,X,Y,Z into location as a single arg.  The shell
     *        || would be to quote the comma separated arguments.  Each list
     *        that V, W, X, Y, and Z represent attributes of will cause a new
     *        tuple to be inserted for each list item with a space between
     *        items.
     *        e.g."V W1,X1,Z1 W2,X2,Z2 W3,X3,Z3 Y1 Y2" where V is not a list
     *        variable, W,X,&Z are atributes of a list with 3 items and Y is an
     *        attribute of a second list with 2 items.
     * %,{VWXYZ} means to separate the args.  The previous example would produce
     *        V W1 X1 Z1 W2 X2 Z2 W3 X3 Z3 Y1 Y2, where each variable is now a
     *        separate, space delimited, arguments within a single argument.
     * a%{XY}, where 'a' is a literal, still produces a single arg (a"X Y", in
     *        shell)
     * a%1{XY}, where 'a' is a literal, splits the literal as it produces
     *        multiple args (a X Y).  The rule is that each sub will produce a
     *        separate arg.  Without a comma, attributes will still be grouped
     *        together & comma separated in what could be a single argument,
     *        but internal quotes, commas, and spaces are not excaped.
     *
     * clearing the variable oldway, passed into this function, causes the
     * behavior of '1' and "," in the format string to reverse.
     */

    /* for convenience, use fmt as a temporary key buffer.
     * for speed, attempt to realloc it as little as possible
     */
    fmt = NULL;
    flen = 0;
    
    /* buf = current argv entry being built
     * length = current length of buf
     * s = next char in source buffer to read
     * d = next char location to write (in buf)
     * inquotes = current quote char or NUL
     */
    s = format;
    d = buf = NULL;
    length = 0;
    doff = d - buf;
    expand_string (&buf, &length, doff + 1);
    d = buf + doff;

    inquotes = '\0';
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
    subbedsomething = 0;
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
    while ((*d++ = *s) != '\0')
    {
	int list = 0;
	switch (*s++)
	{
	    case '\\':
		/* the character after a \ goes unprocessed but leave the \ in
		 * the string so the function that splits this string into a
		 * command line later can deal with quotes properly
		 *
		 * ignore a NUL
		 */
		if (*s)
		{
    		    doff = d - buf;
		    expand_string (&buf, &length, doff + 1);
		    d = buf + doff;
		    *d++ = *s++;
		}
		break;
	    case '\'':
	    case '"':
		/* keep track of quotes so we can escape quote chars we sub in
		 * - the API is that a quoted format string will guarantee that
		 * it gets passed into the command as a single arg
		 */
		if (!inquotes) inquotes = s[-1];
		else if (s[-1] == inquotes) inquotes = '\0';
		break;
	    case '%':
		if (*s == '%')
		{
		    /* "%%" is a literal "%" */
		    s++;
		    break;
		}
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
		if (oldway && subbedsomething)
		{
		    /* the old method was to sub only the first format string */
		    break;
		}
		/* initialize onearg each time we get a new format string */
		onearg = oldway ? 1 : 0;
		subbedsomething = 1;
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
		d--;	/* we're going to overwrite the '%' regardless
			 * of other factors... */
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
		/* detect '1' && ',' in the fmt string. */
		if (*s == '1')
		{
		    onearg = 1;
		    s++;
		    if (!oldway)
		    {
			/* FIXME - add FILE && LINE */
			error (0, 0,
"Using deprecated info format strings.  Convert your scripts to use\n"
"the new argument format and remove '1's from your info file format strings.");
		    }
		}
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
		    
		/* parse the format string and sub in... */
		if (*s == '{')
		{
		    list = 1;
		    s++;
		}
		/* q = fmt start
		 * r = fmt end + 1
		 */
		q = fmt;
		do
		{
		    qoff = q - fmt;
		    expand_string (&fmt, &flen, qoff + 1);
		    q = fmt + qoff;
		} while ((*q = *s++) && list && *q++ != '}');
		/* we will always copy one character, so, whether in list mode
		 * or not, if we just copied a '\0', then we hit the end of the
		 * string before we should have
		 */
		if (!s[-1])
		{
		    /* if we copied a NUL while processing a list, fail
		     * - we had an empty fmt string or didn't find a list
		     * terminator ('}')
		     */
		    /* FIXME - this wants a file name and line number in a bad
		     * way.
		     */
		    error(1, 0,
"unterminated format string encountered in command spec.\n"
"This error is likely to have been caused by an invalid line in a hook script\n"
"spec (see taginfo, loginfo, verifymsginfo, etc. in the Cederqvist).  Most\n"
"likely the offending line would end with a '%%' character or contain a string\n"
"beginning \"%%{\" and no closing '}' before the end of the line.");
		}
		if (list)
		{
		    q[-1] = '\0';
		}
		else
		{
		    /* We're not in a list, so we must have just copied a
		     * single character.  Terminate the string.
		     */
		    q++;
		    qoff = q - fmt;
		    expand_string (&fmt, &flen, qoff + 1);
		    q = fmt + qoff;
		    *q = '\0';
		}
		/* fmt is now a pointer to a list of fmt chars, though the list
		 * could be a single element one
		 */
		q = fmt;
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
		/* always add quotes in the deprecated onearg case - for
		 * backwards compatibility
		 */
		if (onearg)
		{
		    doff = d - buf;
		    expand_string (&buf, &length, doff + 1);
		    d = buf + doff;
		    *d++ = '"';
		}
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
		/*
		 * for each character in the fmt string,
		 *
		 * all output will be separate quoted arguments (with
		 * internal quotes escaped) if the argument is in quotes
		 * unless the oldway variable is set, in which case the fmt
		 * statment will correspond to a single argument with
		 * internal space or comma delimited arguments
		 *
		 * see the "user format strings" section above for more info
		 */
		key[0] = *q;
		if ((p = findnode (pflist, key)) != NULL)
		{
		    b = p->data;
		    if (b->conversion == ',')
		    {
			/* process the rest of the format string as a list */
			struct format_cmdline_walklist_closure c;
			c.format = q;
			c.buf = &buf;
			c.length = &length;
			c.d = &d;
			c.quotes = inquotes;
			c.closure = b->closure;
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
			c.onearg = onearg;
			c.firstpass = 1;
			c.srepos = srepos;
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
			walklist(b->data, b->convproc, &c);
			d--;	/* back up one space.  we know that ^
				   always adds 1 extra */
			q += strlen(q);
		    }
		    else
		    {
			/* got a flat item */
			char *outstr;
			if (strlen(q) > 1)
			{
			    error (1, 0,
"Multiple non-list variables are not allowed in a single format string.");
			}
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
			if (onearg)
			{
			    outstr = b->data;
			}
			else /* !onearg */
			{
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
			    /* the *only* case possible without
			     * SUPPORT_OLD_INFO_FORMAT_STRINGS
			     * - !onearg */
			    if (!inquotes)
			    {
				doff = d - buf;
				expand_string (&buf, &length, doff + 1);
				d = buf + doff;
				*d++ = '"';
			    }
			    outstr = cmdlineescape (inquotes ? inquotes : '"', b->data);
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
			} /* onearg */
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
			doff = d - buf;
			expand_string (&buf, &length, doff + strlen(outstr));
			d = buf + doff;
			strncpy(d, outstr, strlen(outstr));
			d += strlen(outstr);
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
			if (!onearg)
			{
			    free(outstr);
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
			    if (!inquotes)
			    {
				doff = d - buf;
				expand_string (&buf, &length, doff + 1);
				d = buf + doff;
				*d++ = '"';
			    }
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
			}
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
			q++;
		    }
		}
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
		else if (onearg)
		{
		    /* the old standard was to ignore unknown format
		     * characters (print the empty string), but also that
		     * any format character meant print srepos first
		     */
		    q++;
		    doff = d - buf;
		    expand_string (&buf, &length, doff + strlen(srepos));
		    d = buf + doff;
		    strncpy(d, srepos, strlen(srepos));
		    d += strlen(srepos);
		}
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
		else /* no key */
		{
		    /* print an error message to the user
		     * FIXME - this should have a file and line number!!! */
		    error (1, 0,
"Unknown format character in info file ('%s').\n"
"Info files are the hook files, verifymsg, taginfo, commitinfo, etc.",
                           q);
		}
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
		/* always add quotes in the deprecated onearg case - for
		 * backwards compatibility
		 */
		if (onearg)
		{
		    doff = d - buf;
		    expand_string (&buf, &length, doff + 1);
		    d = buf + doff;
		    *d++ = '"';
		}
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
		break;
	}
	doff = d - buf;
	expand_string (&buf, &length, doff + 1);
	d = buf + doff;
    } /* while (*d++ = *s) */
    if (fmt) free (fmt);
    if (inquotes)
    {
	/* FIXME - we shouldn't need this - Parse_Info should be handling
	 * multiple lines...
	 */
	error (1, 0, "unterminated quote in format string: %s", format);
    }

    dellist (&pflist);
    return buf;
}
