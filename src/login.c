/*
 * Copyright (c) 1995, Cyclic Software, Bloomington, IN, USA
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with CVS.
 * 
 * Allow user to log in for an authenticating server.
 */

#include "cvs.h"

#ifdef CVS_LOGIN   /* This covers the rest of the file. */

#include <pwd.h>   /* todo: autoconfify? */

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)login.c 1.1 95/10/01 $";
USE(rcsid);
#endif

#ifndef CVS_PASSWORD_FILE 
#define CVS_PASSWORD_FILE ".cvspass"
#endif

/* Prompt for a password, and store it in ~/.cvspass.
 *
 * Because the user might be accessing multiple repositories, with
 * different passwords for each one, the format of ~/.cvspass is:
 *
 * user@host:/path cleartext_password
 * user@host:/path cleartext_password
 * ...
 *
 * Of course, the "user@" might be left off -- it's just based on the
 * value of CVSroot.
 *
 * Like .netrc, the file's permissions are the only thing preventing
 * it from being read by others.  Unlike .netrc, we will not be
 * fascist about it, at most issuing a warning and never refusing to
 * work.
 */
int
login (argc, argv)
    int argc;
    char **argv;
{
  int i;
  char *homedir;
  char *passfile;
  FILE *fp;
  char *typed_password, *found_password;
  char linebuf[MAXLINELEN];
  int root_len, already_entered = 0;

  /* Construct absolute pathname to user's password file. */
  /* todo: does this work under Win-NT and OS/2 ? */
  homedir = getenv ("HOME");
  if (! homedir)
    {
      error (1, errno, "could not find out home directory");
      return 1;
    }

  /* todo: free this */
  passfile =
    (char *) xmalloc (strlen (homedir) + strlen (CVS_PASSWORD_FILE) + 3);
  strcpy (passfile, homedir);
  strcat (passfile, "/");
  strcat (passfile, CVS_PASSWORD_FILE);

  /* Safety first and last. */
  if (isfile (passfile))
    xchmod (passfile, 0600);

  typed_password = getpass ("CVS password: ");
  printf ("filepath: %s\n", passfile);
  printf ("typed_password: %s\n", typed_password);
  printf ("CVSroot: %s\n", CVSroot);

  if ((fp = fopen (passfile, "r")) == NULL)
    {
      error (1, errno, "could not open %s", passfile);
      free (passfile);
      return 1;
    }

  /* IF we have a password for this "[user@]host:/path" already
   *  THEN
   *    IF it's the same as the password we read from the prompt
   *     THEN 
   *       do nothing
   *     ELSE
   *       replace the old password with the new one
   *  ELSE
   *    append new entry to the end of the file.
   */
  root_len = strlen (CVSroot);
  while (fgets (linebuf, MAXLINELEN, fp) != NULL)
    {
      printf ("  %s", linebuf);
      if (! strncmp (CVSroot, linebuf, root_len))
        already_entered = 1;
    }
  fclose (fp);
  printf ("\n");

  if (already_entered)
    {
      strtok (linebuf, " ");
      found_password = strtok (NULL, " \n");
      
      printf ("found_password: %s\n", found_password);

      if (! strcmp (found_password, typed_password))
        printf ("Whew, they are the same.\n");
      else
        printf ("Eeek, we don't handle replacement yet.\n");
    }
  else
    {
      if ((fp = fopen (passfile, "a")) == NULL)
        {
          error (1, errno, "could not open %s", passfile);
          free (passfile);
          return 1;
        }

      /* todo: Blank lines in the file are ok, right?. */
      fprintf (fp, "\n%s %s\n", CVSroot, typed_password);
      fclose (fp);
    }

  /* Paranoia. */
  xchmod (passfile, 0600);
  memset (typed_password, 0, strlen (typed_password));

  free (passfile);
  return 0;
}

/* todo: "cvs logout" could erase an entry from the file.
 * But to what purpose?
 */

#endif /* CVS_LOGIN from beginning of file. */

