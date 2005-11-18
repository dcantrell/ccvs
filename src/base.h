/*
 * Copyright (C) 2005 The Free Software Foundation, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifndef BASE_H
#define BASE_H

#include "rcs.h"

char *make_base_file_name (const char *filename, const char *rev);

char *base_get (const char *update_dir, const char *file);
void base_register (const char *update_dir, const char *file, char *rev);
void base_deregister (const char *update_dir, const char *file);

int base_checkout (RCSNode *rcs, struct file_info *finfo,
		   const char *prev, const char *rev, const char *tag,
		   const char *options, bool writable);
void base_copy (struct file_info *finfo, const char *rev, const char *exists);
#endif /* BASE_H */
