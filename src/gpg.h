/* gpg.h - OpenPGP functions header.
 * Copyright (C) 2005 Free Software Foundation, Inc.
 *
 * This file is part of of CVS.
 *
 * GnuPG is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * GnuPG is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
 * USA.
 */

#ifndef GPG_H
#define GPG_H

/* ANSI C Headers.  */
#include <stdint.h>

/* CVS Headers.  */
#include "buffer.h"



struct openpgp_signature
{
  time_t ctime;
  uint64_t keyid;
};



int read_signature (struct buffer *bpin, struct buffer *bpout);
int parse_signature (struct buffer *bpin, struct openpgp_signature *spout);

#endif /* GPG_H */
