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

#ifndef SIGN_H
#define SIGN_H

/* Get List.  */
#include "hash.h"

#define DEFAULT_SIGN_TEMPLATE GPG_PROGRAM" --detach-sign --output - %t %a -- %s"
#define DEFAULT_SIGN_TEXTMODE "--textmode"

typedef enum { SIGN_DEFAULT, SIGN_ALWAYS, SIGN_NEVER } sign_state;

extern char *sign_textmode;

#endif /* SIGN_H */
