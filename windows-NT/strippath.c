/* strippath.c -- remove unnecessary components from a path specifier
   Copyright (C) 1992 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

#include <string.h>

static void remove_component (char *beginc, char *endc);
void strip_trailing_slashes (char *path);

/* Remove unnecessary components from PATH. */

void
strip_path (path)
     char *path;
{
    int stripped = 0;
    char *cp, *slash;

    cp = path;
    /* A leading "\\" means that it is a UNC name, and we must not smash
       it into a single "\" or "/".  In my test on NT 3.51, "\\", "\/",
       and "/\" seemed to imply UNC and "//" seemed to be the same as
       a leading "/".  But we just leave them all unmolested--let the system
       sort it out.  */
    if (ISDIRSEP (cp[0]) && ISDIRSEP (cp[1]))
	cp += 2;

    for (; *(slash = cp + strcspn (cp, "/\\")) != '\0'; cp = slash)
    {
	*slash = '\0';
	if ((!*cp && (cp != path || stripped))
	    || strcmp(cp, ".") == 0
	    || strcmp(cp, "/") == 0)
	{
	    stripped = 1;
	    remove_component (cp, slash);
	    slash = cp;
	}
	else
	{
	    *slash++ = '/';
	}
    }
    strip_trailing_slashes (path);
}

/* Remove the component delimited by BEGINC and ENDC from the path */

static void
remove_component (beginc, endc)
     char *beginc;
     char *endc;
{
    for (endc++; *endc; endc++)
	*beginc++ = *endc;
    *beginc = '\0';
}
