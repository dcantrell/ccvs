/*
 * Copyright (C) 2005 The Free Software Foundation, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

/* Verify interface.  */
#include "sign.h"

/* Standard headers.  */
#include <assert.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* GNULIB headers.  */
#include "error.h"
#include "xalloc.h"

/* CVS headers.  */
#include "filesubr.h"
#include "root.h"
#include "run.h"
#include "stack.h"
#include "stack.h"
#include "subr.h"



extern int noexec;



/*
 * Globals set via the command line parser in main.c.
 */

/* If a program capable of generating OpenPGP signatures couldn't be found at
 * configure time, default the sign state to off, otherwise, depend on the
 * server support.
 */
#ifdef HAVE_OPENPGP
static sign_state sign_commits = SIGN_DEFAULT;
#else
static sign_state sign_commits = SIGN_NEVER;
#endif

static char *sign_template;
static char *sign_textmode;
static List *sign_args;



void
set_sign_commits (sign_state sign)
{
    sign_commits = sign;
}



void
set_sign_template (const char *template)
{
    assert (template);
    if (sign_template) free (sign_template);
    sign_template = xstrdup (template);
}



void
set_sign_textmode (const char *textmode)
{
    assert (textmode);
    if (sign_textmode) free (sign_textmode);
    sign_textmode = xstrdup (textmode);
}



void
add_sign_arg (const char *arg)
{
    if (!sign_args) sign_args = getlist ();
    push_string (sign_args, xstrdup (arg));
}



/* Return true if the client should attempt to sign files sent to the server
 * as part of a commit.
 *
 * INPUTS
 *   server_support	Whether the server supports signed files.
 */
bool
get_sign_commits (bool server_active, bool server_support)
{
    sign_state tmp;

    /* Only sign commits from the client (and in local mode).  */
    if (server_active) return false;

    if (sign_commits == SIGN_DEFAULT)
	tmp = current_parsed_root->sign;
    else
	tmp = sign_commits;

    return tmp == SIGN_ALWAYS || (tmp == SIGN_DEFAULT && server_support);
}



/* Return SIGN_TEMPLATE from the command line if it exists, else return the
 * SIGN_TEMPLATE from CURRENT_PARSED_ROOT.
 */
static inline const char *
get_sign_template (void)
{
    if (sign_template) return sign_template;
    return current_parsed_root->sign_template;
}



/* Return SIGN_TEXTMODE from the command line if it exists, else return the
 * SIGN_TEXTMODE from CURRENT_PARSED_ROOT.
 */
static inline const char *
get_sign_textmode (void)
{
    if (sign_textmode) return sign_textmode;
    return current_parsed_root->sign_textmode;
}



/* Return SIGN_ARGS from the command line if it exists, else return the
 * SIGN_ARGS from CURRENT_PARSED_ROOT.
 */
static inline List *
get_sign_args (void)
{
    if (sign_args && !list_isempty (sign_args)) return sign_args;
    return current_parsed_root->sign_args;
}



/* This function is intended to be passed into walklist() with a list of args
 * to be substituted into the sign template.
 *
 * closure will be a struct format_cmdline_walklist_closure
 * where closure is undefined.
 */
static int
sign_args_list_to_args_proc (Node *p, void *closure)
{
    struct format_cmdline_walklist_closure *c = closure;
    char *arg = NULL;
    const char *f;
    char *d;
    size_t doff;

    if (p->data == NULL) return 1;

    f = c->format;
    d = *c->d;
    /* foreach requested attribute */
    while (*f)
    {
	switch (*f++)
	{
	    case 'a':
		arg = p->key;
		break;
	    default:
		error (1, 0,
		       "Unknown format character or not a list attribute: %c",
		       f[-1]);
		/* NOTREACHED */
		break;
	}
	/* copy the attribute into an argument */
	if (c->quotes)
	{
	    arg = cmdlineescape (c->quotes, arg);
	}
	else
	{
	    arg = cmdlinequote ('"', arg);
	}

	doff = d - *c->buf;
	expand_string (c->buf, c->length, doff + strlen (arg));
	d = *c->buf + doff;
	strncpy (d, arg, strlen (arg));
	d += strlen (arg);
	free (arg);

	/* Always put the extra space on.  we'll have to back up a char
	 * when we're done, but that seems most efficient.
	 */
	doff = d - *c->buf;
	expand_string (c->buf, c->length, doff + 1);
	d = *c->buf + doff;
	*d++ = ' ';
    }
    /* correct our original pointer into the buff */
    *c->d = d;
    return 0;
}



char *
get_sigfile_name (const char *fn)
{
    return Xasprintf ("%s%s%s", BAKPREFIX, fn, ".sig");
}



bool
have_sigfile (bool server_active, const char *fn)
{
    char *sfn;
    bool retval;

    /* Sig files are only created on the server.  Optimize.  */
    if (!server_active) return false;

    sfn = get_sigfile_name (fn);
    if (isreadable (sfn)) retval = true;
    else retval = false;

    free (sfn);
    return retval;
}



/* Generate a signature and return it in allocated memory.  */
char *
gen_signature (const char *srepos, const char *filename, bool bin, size_t *len)
{
    char *cmdline;
    FILE *pipefp;
    bool save_noexec = noexec;
    char *sigbuf = NULL;
    size_t sigoff = 0, sigsize = 64;
    int pipestatus;

    /*
     * %p = shortrepos
     * %r = repository
     * %{a} = user defined sign args
     * %t = textmode flag
     * %s = file name
     */
    /*
     * Cast any NULL arguments as appropriate pointers as this is an
     * stdarg function and we need to be certain the caller gets what
     * is expected.
     */
    cmdline = format_cmdline (
#ifdef SUPPORT_OLD_INFO_FMT_STRINGS
	                      false, srepos,
#endif /* SUPPORT_OLD_INFO_FMT_STRINGS */
	                      get_sign_template (),
	                      "a", ",", get_sign_args (),
			      sign_args_list_to_args_proc, (void *) NULL,
	                      "r", "s", current_parsed_root->directory,
	                      "p", "s", srepos,
	                      "t", "s", bin ? NULL : get_sign_textmode (),
	                      "s", "s", filename,
	                      (char *) NULL);

    if (!cmdline || !strlen (cmdline))
	error (1, 0, "sign template resolved to the empty string!");

    noexec = false;
    if (!(pipefp = run_popen (cmdline, "r")))
	error (1, errno, "failed to execute signature generator");
    noexec = save_noexec;

    do
    {
	size_t len;

	sigsize *= 2;
	sigbuf = xrealloc (sigbuf, sigsize);
	len = fread (sigbuf + sigoff, sizeof *sigbuf, sigsize - sigoff,
		     pipefp);
	sigoff += len;
	/* Fewer bytes than requested means EOF or error.  */
    } while (sigsize == sigoff);

    if (ferror (pipefp))
	error (1, ferror (pipefp), "Error reading from sign program.");

    pipestatus = pclose (pipefp);
    if (pipestatus == -1)
	error (1, errno,
	       "failed to obtain exit status from signature program");
    else if (pipestatus)
    {
	if (WIFEXITED (pipestatus))
	    error (1, 0, "sign program exited with error code %d",
		   WEXITSTATUS (pipestatus));
	else
	    error (1, 0, "sign program exited via signal %d",
		   WTERMSIG (pipestatus));
    }

    *len = sigoff;
    return sigbuf;
}



/* Read a signature from a file and return it in allocated memory.  */
static char *
read_signature (const char *fn, bool bin, size_t *len)
{
    char *sfn = get_sigfile_name (fn);
    char *data = NULL;
    size_t datasize;

    get_file (sfn, sfn, bin ? "rb" : "r", &data, &datasize, len);

    free (sfn);
    return data;
}



/* Generate a signature or read one from the sigfile and return it in
 * allocated memory.
 */
char *
get_signature (bool server_active, const char *srepos, const char *filename,
	       bool bin, size_t *len)
{
    if (server_active) return read_signature (filename, bin, len);
    /* else */ return gen_signature (srepos, filename, bin, len);
}
