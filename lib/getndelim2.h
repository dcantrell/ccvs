/* getndelim2 - Read n characters or less from a stream, stopping at one of up
   to two specified delimiters.

   Copyright (C) 2003 Free Software Foundation, Inc.

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

#ifndef GETNDELIM2_H_
# define GETNDELIM2_H_ 1

# include <stddef.h>
# include <stdio.h>
# include <sys/types.h> /* Included for ssize_t. */

# define GETNDELIM_NO_LIMIT (ssize_t)-1

extern ssize_t getndelim2 (char **_lineptr, size_t *_linesize, size_t _offset,
                           ssize_t _limit, int _delim1, int _delim2,
                           FILE *_stream);

#endif /* not GETNDELIM2_H */
