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

#ifndef GETNLINE_H_
# define GETNLINE_H_ 1

# include <stddef.h>
# include <stdio.h>

# define GETNDELIM_NO_LIMIT -1

int getnline( char **_lineptr, size_t *_n, int limit, FILE *_stream );

int getndelim( char **_lineptr, size_t *_n, int limit, int _delimiter,
               FILE *_stream );

#endif /* not GETNLINE_H_ */
