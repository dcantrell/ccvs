/****************************************************************
**
**  POPEN.C     Popen substitute for OS/2
**
****************************************************************/

/* Undef this for distribution. */
#define DIAGNOSTIC 1

/* todo: Local include file you might not have */
/* #include    <portable.h> */

#define INCL_DOSQUEUES
#define INCL_DOSPROCESS
#define INCL_DOSSESMGR
#include    <os2.h>
#include    <process.h>

#include    <stdio.h>
#include    <stdlib.h>
#include    <sys/types.h>
#include    <sys/stat.h>
#include    <ctype.h>
#include    <string.h>

#define LL_VAL ULONG
#define LL_KEY PID    /* also ULONG, really */


#define STDIN       0
#define STDOUT      1
#define STDERR      2

/* Map integer PID's onto integer termination codes. */

struct pid_list
{
  unsigned long pid;        /* key */
  unsigned long term_code;  /* val */
  struct pid_list *next;    /* duh */ 
};

static struct pid_list *pid_ll = (struct pid_list *) NULL;

/* The ll_*() functions all make use of the global `pid_ll'. */

void               /* HFILE */     /* RESULTCODES.codeTerminate */
ll_insert (unsigned long int key, unsigned long int val)
{
  struct pid_list *new;
  new = (struct pid_list *) malloc (sizeof (*new));

  new->pid       = key;
  new->term_code = val;
  new->next      = pid_ll;

  pid_ll = new;
}


void       /* int fileno(Pipe) ??? */
ll_delete (int key)
{
  struct pid_list *this, *last;

  this = pid_ll;
  last = (struct pid_list *) NULL;

  while (this)
    {
      if (this->pid == key)
        {
          /* Delete this node and leave. */
          if (last)
            last->next = this->next;
          else
            pid_ll = this->next;
          free (this);
          return;
        }

      /* Else no match, so try the next one. */
      last = this;
      this = this->next;
    }
}

unsigned long int /* int fileno(Pipe) ??? */
ll_lookup (unsigned long int key)
{
  struct pid_list *this = pid_ll;

  while (this)
    {
      if (this->pid == key)
        return this->term_code;

      /* Else no match, so try the next one. */
      this = this->next;
    }

  /* Zero is special in this context anyway. */
  return 0;
}

#if DIAGNOSTIC
unsigned long int
ll_length ()
{
  struct pid_list *this = pid_ll;
  unsigned long int len;

  for (len = 0; this; len++)
    this = this->next;

  return len;
}

unsigned long int
ll_print ()
{
  struct pid_list *this = pid_ll;
  unsigned long int i;

  for (i = 0; this; i++)
    {
      printf ("pid_ll[%d] == (%5d --> %5d)\n",
			  i, this->pid, this->term_code);
      this = this->next;
    }

  if (i == 0)
	  printf ("No entries.\n");

  return i;
}
#endif /* DIAGNOSTIC */


/****************************************************************
**  Routine: popen
**  Returns: FILE pointer to pipe.
**  Action : Exec program connected via pipe, connect a FILE * to the
**           pipe and return it.
**  Params : Command - Program to run
**           Mode    - Mode to open pipe.  "r" implies pipe is connected
**                     to the programs stdout, "w" connects to stdin.
****************************************************************/

FILE *popen (const char *Command, const char *Mode)
{
    HFILE   End1,
            End2,
            Std,
            Old1,
            Old2,
            Tmp;

    FILE    *File;

    char    Fail[256],
            *Args,
            CmdLine[256],
            *CmdExe;

    RESULTCODES
            Result;

    int     Rc;

    if (DosCreatePipe (&End1, &End2, 4096))
        return NULL;

    Std = (*Mode == 'w') ? STDIN : STDOUT ;
    if (Std == STDIN)
    {
        Tmp = End1; End1 = End2; End2 = Tmp;
    }

    Old1 = -1; /* save stdin or stdout */
    DosDupHandle (Std, &Old1);
    DosSetFHState (Old1, OPEN_FLAGS_NOINHERIT);
    Tmp = Std; /* redirect stdin or stdout */
    DosDupHandle (End2, &Tmp);

    if (Std == 1) 
    {
        Old2 = -1; /* save stderr */
        DosDupHandle (STDERR, &Old2);
        DosSetFHState (Old2, OPEN_FLAGS_NOINHERIT);
        Tmp = STDERR;
        DosDupHandle (End2, &Tmp);
    }

    DosClose (End2);
    DosSetFHState (End1, OPEN_FLAGS_NOINHERIT);

    if ((CmdExe = getenv ("COMSPEC")) == NULL )
        CmdExe = "cmd.exe";

    strcpy (CmdLine, CmdExe);
    Args = CmdLine + strlen (CmdLine) + 1; /* skip zero */
    strcpy (Args, "/c ");
    strcat (Args, Command);
    Args[strlen (Args) + 1] = '\0'; /* two zeroes */
    Rc = DosExecPgm (Fail, sizeof (Fail), EXEC_ASYNCRESULT, 
                     (unsigned char *) CmdLine, 0, &Result,
                     (unsigned char *) CmdExe);

    Tmp = Std; /* restore stdin or stdout */
    DosDupHandle (Old1, &Tmp);
    DosClose (Old1);

    if (Std == STDOUT) 
    {
        Tmp = STDERR;   /* restore stderr */
        DosDupHandle (Old2, &Tmp);
        DosClose (Old2);
    }

    if (Rc)
    {
        DosClose (End1);
        return NULL;
    }
  
    File = fdopen (End1, Mode);
    ll_insert ((LL_KEY) End1, (LL_VAL) Result.codeTerminate);

    return File;
}
        


/****************************************************************
**  Routine: popenRW
**  Returns: TRUE on success
**  Action : Exec program connected via pipe, connect FILE *'s to 
**           both the stdin and stdout of the process.
**  Params : Command - Program to run
**           Pipes   - Array of FILE * to store the pipe descriptors
**                     Pipe[0] is attached to the child's stdin,
**                     Pipe[1] is attached to its stdout/err
****************************************************************/

int
popenRW (const char  *Command, FILE **Pipes)
{
    HFILE   Out1,
            Out2,
            In1,
            In2,
            Old0 = -1,
            Old1 = -1,
            Old2 = -1,
            Tmp;

    char    Fail[256],
            *Args,
            CmdLine[256],
            *CmdExe;

    RESULTCODES
            Result;

    int     Rc;

    if (DosCreatePipe (&Out2, &Out1, 4096))
        return FALSE;

    if (DosCreatePipe (&In1, &In2, 4096))
    {
        DosClose (Out1);
        DosClose (Out2);
        return FALSE;
    }

    /* Save stdin/out/err */
    DosDupHandle (STDIN, &Old0);
    DosSetFHState (Old1, OPEN_FLAGS_NOINHERIT);
    DosDupHandle (STDOUT, &Old1);
    DosSetFHState (Old2, OPEN_FLAGS_NOINHERIT);
    DosDupHandle (STDERR, &Old2);
    DosSetFHState (Old2, OPEN_FLAGS_NOINHERIT);

    /* Redirect stdin/out/err */
    Tmp = STDIN;
    DosDupHandle (In1, &Tmp);
    Tmp = STDOUT;
    DosDupHandle (Out1, &Tmp);
    Tmp = STDERR;
    DosDupHandle (Out1, &Tmp);

    /* Close file handles not needed in child */
    
    DosClose (In1);
    DosClose (Out1);
    DosSetFHState (In2, OPEN_FLAGS_NOINHERIT);
    DosSetFHState (Out2, OPEN_FLAGS_NOINHERIT);

    /* Spawn child */
    if ((CmdExe = getenv("COMSPEC")) == NULL)
        CmdExe = "cmd.exe";

    strcpy (CmdLine, CmdExe);
    Args = CmdLine + strlen (CmdLine) + 1; /* skip zero */
    strcpy (Args, "/c ");
    strcat (Args, Command);
    Args[ strlen (Args) + 1] = '\0'; /* two zeroes */
    Rc = DosExecPgm (Fail, sizeof(Fail), EXEC_ASYNCRESULT, 
                     (unsigned char *) CmdLine, 0, &Result,
                     (unsigned char *) CmdExe);

    /* Restore stdin/out/err */
    Tmp = STDIN;
    DosDupHandle (Old0, &Tmp);
    DosClose (Old0);
    Tmp = STDOUT;
    DosDupHandle (Old1, &Tmp);
    DosClose (Old1);
    Tmp = STDERR;
    DosDupHandle (Old2, &Tmp);
    DosClose (Old2);

    if( Rc ) 
    {
        DosClose (In2);
        DosClose (Out2);
        return FALSE;
    }
  
    if ((Pipes[0] = fdopen (In2, "w")) == NULL)
    {
        fprintf (stderr, "popenRW(): Errno %d: %s\n",
             errno, strerror (errno));
        return FALSE;
    }
    else if ((Pipes[1] = fdopen (Out2, "r")) == NULL)
    {
        fclose (Pipes[0]);
        fprintf (stderr, "popenRW(): Errno %d: %s\n",
             errno, strerror(errno));
        return FALSE;
    }
    
    /* Save ID of read pipe for pclose() */
    ll_insert ((LL_KEY) In2, (LL_VAL) Result.codeTerminate);

    return TRUE;
}



/****************************************************************
**  Routine: pclose
**  Returns: TRUE on success
**  Action : Close a pipe opened with Popen();
**  Params : Pipe - pIpe to close
****************************************************************/

int
pclose (FILE *Pipe) 
{
    RESULTCODES rc;
    PID pid, pid1;
    int Handle = fileno (Pipe);

    fclose (Pipe);

    rc.codeTerminate = -1;

    pid1 = (PID) ll_lookup ((LL_KEY) Handle);
    /* if pid1 is zero, something's seriously wrong */
    if (pid1 != 0)
      {
        DosWaitChild (DCWA_PROCESSTREE, DCWW_WAIT, &rc, &pid, pid1);
        ll_delete ((LL_KEY) Handle);
      }
    return rc.codeTerminate == 0 ? rc.codeResult : -1;
}


#if DIAGNOSTIC
void
main ()
{
  FILE *fp1, *fp2, *fp3;
  int c;

  ll_print ();
  fp1 = popen ("gcc --version", "r");
  ll_print ();
  fp2 = popen ("link386 /?", "r");
  ll_print ();
  fp3 = popen ("dir", "r");
  ll_print ();

  while ((c = getc (fp1)) != EOF)
    printf ("%c", c);

  while ((c = getc (fp2)) != EOF)
    printf ("%c", c);

  while ((c = getc (fp3)) != EOF)
    printf ("%c", c);

  pclose (fp1);
  ll_print ();
  pclose (fp2);
  ll_print ();
  pclose (fp3);
  ll_print ();

  return;
}

#endif /* DIAGNOSTIC */
