/* Implementation of getnline function, a version of the GNU C library
   function getline which allows a maximum number of characters retrieved
   to be set.

   Copyright (C) 1995, 1997, 1999, 2000, 2001, 2002, 2003 Free
   Software Foundation, Inc.

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
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

#ifndef GETNDELIM2_H_
# define GETNDELIM2_H_ 1

# include <stddef.h>
# include <stdio.h>
# include <sys/types.h> /* Included for ssize_t. */

# define GETNDELIM_NO_LIMIT -1

ssize_t getndelim2( char **lineptr, size_t *n, size_t offset, int limit,
                    int delim1, int delim2, FILE *stream );

#endif /* not GETNDELIM2_H */
