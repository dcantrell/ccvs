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

#ifndef ENTRIES_H
#define ENTRIES_H

/* The type of an entnode.  */
enum ent_type
{
    ENT_FILE, ENT_SUBDIR
};

/* structure of a entry record */
struct entnode
{
    enum ent_type type;
    char *user;
    char *version;

    /* Timestamp, or "" if none (never NULL).  */
    char *timestamp;

    /* Keyword expansion options, or "" if none (never NULL).  */
    char *options;

    char *tag;
    char *date;
    char *conflict;
};
typedef struct entnode Entnode;

#endif /* !defined ENTRIES_H */
