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

#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)login.c 1.1 95/10/01 $";
USE(rcsid);
#endif

#ifndef CVS_PASSWORD_FILE 
#define CVS_PASSWORD_FILE ".cvspass"
#endif

/* Prompt for a password, and store it in the file "CVS/.cvspass".
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

  passfile =
    (char *) xmalloc (strlen (homedir) + strlen (CVS_PASSWORD_FILE) + 3);
  strcpy (passfile, homedir);
  strcat (passfile, "/");
  strcat (passfile, CVS_PASSWORD_FILE);

  /* Safety first and last, Scouts.
   * (And don't use xchmod(), it's too polite.)
   */
  if (isfile (passfile))
    chmod (passfile, 0600);

  typed_password = getpass ("CVS password: ");

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

  /* If it doesn't exist, then we don't have much thinking to do. */
  if ((fp = fopen (passfile, "r")) != NULL)
    {
      while (fgets (linebuf, MAXLINELEN, fp) != NULL)
        {
          if (! strncmp (CVSroot, linebuf, root_len))
            {
              already_entered = 1;
              break;
            }
        }
      fclose (fp);
    }
      
  /* This user/host has a password in the file already. */
  if (already_entered)
    {
      strtok (linebuf, " \n");
      found_password = strtok (NULL, " \n");
      if (strcmp (found_password, typed_password))
        {
          /* typed_password and found_password don't match, so we'll
           * have to update passfile.  We replace the old password
           * with the new one by writing a tmp file whose contents are
           * exactly the same as passfile except that this one entry
           * gets typed_password instead of found_password.  Then we
           * rename the tmp file on top of passfile.
           */
          char *tmp_name;
          FILE *tmp_fp;

          tmp_name = tmpnam (NULL);
          if ((tmp_fp = fopen (tmp_name, "w")) == NULL)
            {
              error (1, errno, "unable to open temp file %s", tmp_name);
              return 1;
            }
          chmod (tmp_name, 0600); /* total paranoia */
          if ((fp = fopen (passfile, "r")) == NULL)
            {
              error (1, errno, "unable to open %s", passfile);
              return 1;
            }
          chmod (passfile, 0600); /* they're out to get me */

          while (fgets (linebuf, MAXLINELEN, fp) != NULL)
            {
              if (strncmp (CVSroot, linebuf, root_len))
                fprintf (tmp_fp, "%s", linebuf);
              else
                fprintf (tmp_fp, "%s %s\n", CVSroot, typed_password);
            }
          fclose (tmp_fp);
          fclose (fp);
          rename_file (tmp_name, passfile);
          chmod (passfile, 0600); /* you never know */
        }
    }
  else
    {
      if ((fp = fopen (passfile, "a")) == NULL)
        {
          error (1, errno, "could not open %s", passfile);
          free (passfile);
          return 1;
        }

      /* It's safer this way, and blank lines in the file are OK. */
      fprintf (fp, "\n%s %s\n", CVSroot, typed_password);
      fclose (fp);
    }

  /* Paranoia. */
  chmod (passfile, 0600);
  memset (typed_password, 0, strlen (typed_password));

  free (passfile);
  return 0;
}

/* todo: "cvs logout" could erase an entry from the file.
 * But to what purpose?
 */

#endif /* AUTH_CLIENT_SUPPORT from beginning of file. */

