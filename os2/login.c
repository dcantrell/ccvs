/*
 * Copyright (c) 1995, Cyclic Software, Bloomington, IN, USA
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with CVS.
 * 
 * Allow user to log in for an authenticating server.
 */

#include "cvs.h"

#ifdef AUTH_CLIENT_SUPPORT   /* This covers the rest of the file. */

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)login.c 1.1 95/10/01 $";
USE(rcsid);
#endif

#define INCL_DOSQUEUES
#define INCL_DOSMEMMGR
#define INCL_DOSPROCESS
#define INCL_DOSSESMGR

#include <os2.h>
#include <bsememf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *
getpass (char *prompt)
{
    static char passbuf[30];
    int i;
    char *p;
    int ch;
    
    printf ("%s", prompt);
    fflush (stdout);
    
    p = passbuf, i = 0;
    while (((ch = getchar ()) != '\n') && (ch != EOF))
    {
        if (i++ < 24)
            *p++ = ch;
    }
    *p = '\0';

    return passbuf;
}


/* Prompt for a password, and have a subprocess store it in a shared
   memory block.  This seemed the safest way to go under OS/2.  */
int
login (argc, argv)
    int argc;
    char **argv;
{
  char *typed_password;
  char *argv[3];
  int pid;

  typed_password = getpass ();
  argv[0] = "cvslogin";
  argv[1] = typed_passwd;
  argv[2] = (char *) NULL;
  
  /* Spawn we now our hoary brood. */
  pid = spawnvp (P_NOWAIT, argv[0], argv);

  if (pid < 0)
    error (1, errno, "spawnvp() failed");

  memset (typed_password, 0, strlen (typed_password));

  return 0;
}


char *
get_cvs_password ()
{
  char *passwd;
  char *addr = NULL;
  char *name = "\\SHAREMEM\\CVSPASS.WRD";
  int rc, len;

  rc = DosGetNamedSharedMem (&addr, name, PAG_READ | PAG_WRITE);
  if (rc != 0)
    error (1, 0, "use \"cvs login\" to log in first");
  
  len = strlen (addr);
  passwd = xmalloc (len + 1);
  strcpy (passwd, addr);
  return passwd;
}

#if 0       /* TESTING */
void
main ()
{
  char *passwd;

  printf ("Type \"stop\" as the password when you're done testing.\n");
  fflush (stdout);

  while (1)
    {
      login ();
      passwd = get_cvs_passwd ();

      if (strcmp (passwd, "stop") == 0)
        break;

      printf ("Password was: %s\n", password);
      fflush (stdout);
    }

  printf ("Done.\n");
  fflush (stdout);
}

#endif /* 0/1 (TESTING) */


#endif /* AUTH_CLIENT_SUPPORT from beginning of file. */

