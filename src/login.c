/*
 * Copyright (c) 1995, Cyclic Software, Bloomington, IN, USA
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with CVS.
 * 
 * Allow user to log in for an authenticating server.
 */

#ifdef CVS_LOGIN   /* This covers the whole file. */

#include "cvs.h"

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)login.c 1.1 95/10/01 $";
USE(rcsid);
#endif


int
login (argc, argv)
    int argc;
    char **argv;
{
  int i;

  printf ("\"%s %s\" not yet supported.\n",
          program_name, command_name);
  
  for (i = 0, i < argc; i++)
    {
      printf ("\"%s %s\" arg %d: %s\n",
              program_name, command_name, i, argv[i]);
    }

  return 0;
}


#endif /* CVS_LOGIN from beginning of file. */

