/* getnline.c -- Implementation of getnline function, a modification of
   the GNU C library function getline to allow the caller to set a
   maximum number of characters to be retrieved.

   Copyright (C) 1993, 1996, 1997, 1998, 2000, 2003 Free Software
   Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

/* Adapted by Derek Price <derek@ximbiot.com>
 * from getline.c written by Jan Brittenson <bson@gnu.ai.mit.edu>.
 */

#if HAVE_CONFIG_H
# include <config.h>
#endif

#include "getnline.h"

#include <stddef.h>
#include <sys/types.h> /* Included for ssize_t. */

#include "getndelim2.h"

ssize_t
getnline( char **lineptr, size_t *n, int limit, FILE *stream )
{
  return getndelim2( lineptr, n, 0, limit, '\n', 0, stream );
}

ssize_t
getndelim( char **lineptr, size_t *n, int limit, int delimiter, FILE *stream )
{
  return getndelim2( lineptr, n, 0, limit, delimiter, 0, stream );
}
