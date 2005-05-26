/*  pwd.c - Try to approximate UN*X's getuser...() functions under MS-DOS.
    Copyright (C) 1990 by Thorsten Ohl, td12@ddagsi3.bitnet

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 1, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.  */

/* This 'implementation' is conjectured from the use of this functions in
   the RCS and BASH distributions.  Of course these functions don't do too
   much useful things under MS-DOS, but using them avoids many "#ifdef
   MSDOS" in ported UN*X code ...  */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pwd.h>
#include "xalloc.h"

char* win32getlogin();
static char *lookup_env (char **);

/* where people might scribble their name into the environment ... */

static char *login_strings[] =
{
  "LOGIN", "USER", "MAILNAME", NULL
};

static char *group_strings[] =
{
  "GROUP", NULL
};


static char *anonymous = "anonymous";	/* if all else fails ... */

static char *home_dir = ".";	/* we feel (no|every)where at home */
static char *login_shell = "not command.com!";

static char *login = NULL;/* cache the names here	*/
static char *group = NULL;

static struct passwd pw;	/* should we return a malloc()'d structure   */
static struct group gr;		/* instead of pointers to static structures? */

/* return something like a username in a (butchered!) passwd structure. */
struct passwd *
getpwuid (int uid)
{
  pw.pw_name = getlogin ();
  pw.pw_dir = home_dir;
  pw.pw_shell = login_shell;
  pw.pw_uid = 0;

  return &pw;
}

struct passwd *
getpwnam (const char *name)
{
  return NULL;
}

/* return something like a groupname in a (butchered!) group structure. */
struct group *
getgrgid (int uid)
{
  gr.gr_name = getgr_name ();
  gr.gr_gid = 0;

  return &gr;
}

struct group *
getgrnam (const char *name)
{
  return NULL;
}

/* return something like a username. */
char *
getlogin (void)
{
  /* This is how a windows user would override their login name. */
  if (!login)
    login = lookup_env (login_strings);

  /* In the absence of user override, ask the operating system. */
  if (!login)
     login = win32getlogin();

  /* If all else fails, fall back on Old Faithful. */
  if (!login)
    login = anonymous;

  return login;
}

/* return something like a group.  */
char *
getgr_name (void)
{
  if (!group)			/* have we been called before? */
    group = lookup_env (group_strings);

  if (!group)			/* have we been successful? */
    group = anonymous;

  return group;
}

/* return something like a uid.  */
int
getuid (void)
{
  return 0;			/* every user is a super user ... */
}

int
getgid (void)
{
  return 0;
}

int
geteuid (void)
{
  return 0;
}

int
getegid (void)
{
  return 0;
}

struct passwd *
getpwent (void)
{
  return NULL;
}

void
setpwent (void)
{
}

void
endpwent (void)
{
}

void
endgrent (void)
{
}

/* return groups.  */
int
getgroups (int ngroups, int *groups)
{
  *groups = 0;
  return 1;
}

/* lookup environment.  */
static char *
lookup_env (char *table[])
{
  char *ptr;
  char *entry;
  size_t len;

  while (*table && !(ptr = getenv (*table++))) ;	/* scan table */

  if (!ptr) return NULL;

  len = strcspn (ptr, " \n\t\n\r");	/* any WS? 	  */
  if (!(entry = xmalloc (len + 1)))
    {
      fprintf (stderr, "Out of memory.\nStop.");
      exit (-1);
    }

  strncpy (entry, ptr, len);
  entry[len] = '\0';

  return entry;

}

/*
 * Local Variables:
 * mode:C
 * ChangeLog:ChangeLog
 * compile-command:make
 * End:
 */
