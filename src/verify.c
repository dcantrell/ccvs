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

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

/* Verify interface.  */
#include "verify.h"

/* ANSI C headers.  */
#include <assert.h>
#include <stdlib.h>

/* GNULIB headers.  */
#include "error.h"
#include "xalloc.h"

/* CVS headers.  */
#include "stack.h"

/* Get current_parsed_root.  */
#include "cvs.h"



extern int noexec;



/*
 * Globals set via the command line parser in main.c.
 */

/* If a program capable of generating OpenPGP signatures couldn't be found at
 * configure time, default the sign state to off, otherwise, depend on the
 * server support.
 */
#ifdef HAVE_OPENPGP
static verify_state verify_checkouts = VERIFY_DEFAULT;
#else
static verify_state verify_checkouts = VERIFY_NEVER;
#endif

static char *verify_template;
static List *verify_args;



void
set_verify_checkouts (verify_state verify)
{
    verify_checkouts = verify;
}



void
set_verify_template (const char *template)
{
    assert (template);
    if (verify_template) free (verify_template);
    verify_template = xstrdup (template);
}



void
add_verify_arg (const char *arg)
{
    if (!verify_args) verify_args = getlist ();
    push_string (verify_args, xstrdup (arg));
}



/* Return the current verify_state based on the command line options, current
 * cvsroot, and compiled default.
 *
 * INPUTS
 *   server_active	Whether the server is active.
 *   server_support	Whether the server supports signed files.
 *
 * ERRORS
 *   This function exits with a fatal error when the server does not support
 *   OpenPGP signatures and VERIFY_FATAL would otherwise be returned.
 *
 * RETURNS
 *   VERIFY_OFF, VERIFY_WARN, or VERIFY_FATAL.
 */
static verify_state
iget_verify_checkouts (bool server_active, bool server_support)
{
    verify_state tmp;

    /* Only verify checkouts from the client (and in local mode).  */
    if (server_active) return false;

    if (verify_checkouts == VERIFY_DEFAULT)
	tmp = current_parsed_root->verify;
    else
	tmp = verify_checkouts;

    if (tmp == VERIFY_DEFAULT)
	tmp = VERIFY_FATAL;

    if (tmp == VERIFY_FATAL && !server_support)
	error (1, 0, "Server does not support OpenPGP signatures.");

    return tmp;
}



/* Return true if the client should attempt to verify files sent by the server.
 *
 * INPUTS
 *   server_active	Whether the server is active.
 *   server_support	Whether the server supports signed files.
 *
 * ERRORS
 *   This function exits with a fatal error if iget_verify_checkouts does.
 */
bool
get_verify_checkouts (bool server_active, bool server_support)
{
    verify_state tmp = iget_verify_checkouts (server_active, server_support);
    return tmp == VERIFY_WARN || tmp == VERIFY_FATAL;
}



/* Return VERIFY_TEMPLATE from the command line if it exists, else return the
 * VERIFY_TEMPLATE from CURRENT_PARSED_ROOT.
 */
static inline const char *
get_verify_template (void)
{
    if (verify_template) return verify_template;
    return current_parsed_root->verify_template;
}



/* Return VERIFY_ARGS from the command line if it exists, else return the
 * VERIFY_ARGS from CURRENT_PARSED_ROOT.
 */
static inline List *
get_verify_args (void)
{
    if (verify_args && !list_isempty (verify_args)) return verify_args;
    return current_parsed_root->verify_args;
}



/* This function is intended to be passed into walklist() with a list of args
 * to be substituted into the sign template.
 *
 * closure will be a struct format_cmdline_walklist_closure
 * where closure is undefined.
 */
static int
verify_args_list_to_args_proc (Node *p, void *closure)
{
    struct format_cmdline_walklist_closure *c = closure;
    char *arg = NULL;
    const char *f;
    char *d;
    size_t doff;

    if (p->data == NULL) return 1;

    f = c->format;
    d = *c->d;
    /* foreach requested attribute */
    while (*f)
    {
	switch (*f++)
	{
	    case 'a':
		arg = p->key;
		break;
	    default:
		error (1, 0,
		       "Unknown format character or not a list attribute: %c",
		       f[-1]);
		/* NOTREACHED */
		break;
	}
	/* copy the attribute into an argument */
	if (c->quotes)
	{
	    arg = cmdlineescape (c->quotes, arg);
	}
	else
	{
	    arg = cmdlinequote ('"', arg);
	}

	doff = d - *c->buf;
	expand_string (c->buf, c->length, doff + strlen (arg));
	d = *c->buf + doff;
	strncpy (d, arg, strlen (arg));
	d += strlen (arg);
	free (arg);

	/* Always put the extra space on.  we'll have to back up a char
	 * when we're done, but that seems most efficient.
	 */
	doff = d - *c->buf;
	expand_string (c->buf, c->length, doff + 1);
	d = *c->buf + doff;
	*d++ = ' ';
    }
    /* correct our original pointer into the buff */
    *c->d = d;
    return 0;
}



/* Generate a signature and return it in allocated memory.  */
char *
verify_signature (const char *srepos, const char *filename, bool bin,\
		  size_t *len)
{
}
