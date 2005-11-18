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
#include "base.h"

/* Standard headers.  */
#include <assert.h>

/* GNULIB headers.  */

/* CVS headers.  */
#include "server.h"
#include "subr.h"
#include "cvs.h"	/* For CVSADM_BASE. */



char *
make_base_file_name (const char *filename, const char *rev)
{
    return Xasprintf ("%s/.#%s.%s", CVSADM_BASE, filename, rev);
}



/* OK, the following base_* code tracks the revisions of the files in
   CVS/Base.  We do this in a file CVS/Baserev.  Separate from
   CVS/Entries because it needs to go in separate data structures
   anyway (the name in Entries must be unique), so this seemed
   cleaner.  The business of rewriting the whole file in
   base_deregister and base_register is the kind of thing we used to
   do for Entries and which turned out to be slow, which is why there
   is now the Entries.Log machinery.  So maybe from that point of
   view it is a mistake to do this separately from Entries, I dunno.  */

enum base_walk
{
    /* Set the revision for FILE to *REV.  */
    BASE_REGISTER,
    /* Get the revision for FILE and put it in a newly malloc'd string
       in *REV, or put NULL if not mentioned.  */
    BASE_GET,
    /* Remove FILE.  */
    BASE_DEREGISTER
};



/* Read through the lines in CVS/Baserev, taking the actions as documented
   for CODE.  */
static void
base_walk (enum base_walk code, const char *update_dir, const char *file,
	   char **rev)
{
    FILE *fp;
    char *line;
    size_t line_allocated;
    FILE *newf;
    char *baserev_fullname;
    char *baserevtmp_fullname;

    line = NULL;
    line_allocated = 0;
    newf = NULL;

    /* First compute the fullnames for the error messages.  This
       computation probably should be broken out into a separate function,
       as recurse.c does it too and places like Entries_Open should be
       doing it.  */
    if (update_dir[0] != '\0')
    {
	baserev_fullname = Xasprintf ("%s/%s", update_dir,
				      CVSADM_BASEREV);
	baserevtmp_fullname = Xasprintf ("%s/%s", update_dir,
					 CVSADM_BASEREVTMP);
    }
    else
    {
	baserev_fullname = xstrdup (CVSADM_BASEREV);
	baserevtmp_fullname = xstrdup (CVSADM_BASEREVTMP);
    }

    fp = CVS_FOPEN (CVSADM_BASEREV, "r");
    if (fp)
    {
	if (!existence_error (errno))
	{
	    error (0, errno, "cannot open %s for reading", baserev_fullname);
	    goto out;
	}
    }

    switch (code)
    {
	case BASE_REGISTER:
	case BASE_DEREGISTER:
	    newf = CVS_FOPEN (CVSADM_BASEREVTMP, "w");
	    if (!newf)
	    {
		error (0, errno, "cannot open %s for writing",
		       baserevtmp_fullname);
		goto out;
	    }
	    break;
	case BASE_GET:
	    *rev = NULL;
	    break;
    }

    if (fp)
    {
	while (getline (&line, &line_allocated, fp) >= 0)
	{
	    char *linefile;
	    char *p;
	    char *linerev;

	    if (line[0] != 'B')
		/* Ignore, for future expansion.  */
		continue;

	    linefile = line + 1;
	    p = strchr (linefile, '/');
	    if (!p)
		/* Syntax error, ignore.  */
		continue;
	    linerev = p + 1;
	    p = strchr (linerev, '/');
	    if (!p) continue;

	    linerev[-1] = '\0';
	    if (fncmp (linefile, file) == 0)
	    {
		switch (code)
		{
		case BASE_REGISTER:
		case BASE_DEREGISTER:
		    /* Don't copy over the old entry, we don't want it.  */
		    break;
		case BASE_GET:
		    *p = '\0';
		    *rev = xstrdup (linerev);
		    *p = '/';
		    goto got_it;
		}
	    }
	    else
	    {
		linerev[-1] = '/';
		switch (code)
		{
		case BASE_REGISTER:
		case BASE_DEREGISTER:
		    if (fprintf (newf, "%s\n", line) < 0)
			error (0, errno, "error writing %s",
			       baserevtmp_fullname);
		    break;
		case BASE_GET:
		    break;
		}
	    }
	}
	if (ferror (fp))
	    error (0, errno, "cannot read %s", baserev_fullname);
    }
 got_it:

    if (code == BASE_REGISTER)
    {
	if (fprintf (newf, "B%s/%s/\n", file, *rev) < 0)
	    error (0, errno, "error writing %s",
		   baserevtmp_fullname);
    }

 out:

    if (line) free (line);

    if (fp)
    {
	if (fclose (fp) < 0)
	    error (0, errno, "cannot close %s", baserev_fullname);
    }
    if (newf)
    {
	if (fclose (newf) < 0)
	    error (0, errno, "cannot close %s", baserevtmp_fullname);
	rename_file (CVSADM_BASEREVTMP, CVSADM_BASEREV);
    }

    free (baserev_fullname);
    free (baserevtmp_fullname);
}



/* Return, in a newly malloc'd string, the revision for FILE in CVS/Baserev,
 * or NULL if not listed.
 */
char *
base_get (const char *update_dir, const char *file)
{
    char *rev;
    base_walk (BASE_GET, update_dir, file, &rev);
    return rev;
}



/* Set the revision for FILE to REV.  */
void
base_register (const char *update_dir, const char *file, char *rev)
{
    base_walk (BASE_REGISTER, update_dir, file, &rev);
}



/* Remove FILE.  */
void
base_deregister (const char *update_dir, const char *file)
{
    base_walk (BASE_DEREGISTER, update_dir, file, NULL);
}



int
base_checkout (RCSNode *rcs, struct file_info *finfo,
	       const char *prev, const char *rev, const char *tag,
	       const char *options, bool writable)
{
    int status;

    mkdir_if_needed (CVSADM_BASE);

    if (!current_parsed_root->isremote)
    {
	char *basefile = make_base_file_name (finfo->file, rev);
	status = RCS_checkout (rcs, basefile, rev, tag, options,
			       NULL, NULL, NULL);
	xchmod (basefile, writable);
	free (basefile);
    }
    else
	status = 0;

    if (server_active)
	server_base_checkout (finfo, options, prev, rev);

    return status;
}



void
base_copy (struct file_info *finfo, const char *rev, const char *exists)
{
    char *basefile = make_base_file_name (finfo->file, rev);
    copy_file (basefile, finfo->file);
    free (basefile);

    if (server_active)
	server_base_copy (finfo, rev, exists);
}
