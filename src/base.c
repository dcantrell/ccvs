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
#include "difflib.h"
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
    if (!fp)
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
	       const char *poptions, const char *options)
{
    int status;
    char *basefile;

    TRACE (TRACE_FUNCTION, "base_checkout (%s, %s, %s, %s, %s, %s)",
	   finfo->fullname, prev, rev, tag, poptions, options);

    mkdir_if_needed (CVSADM_BASE);

    assert (!current_parsed_root->isremote);

    basefile = make_base_file_name (finfo->file, rev);
    status = RCS_checkout (rcs, basefile, rev, tag, options,
			   NULL, NULL, NULL);

    /* Always mark base files as read-only, to make disturbing them
     * accidentally at least slightly challenging.
     */
    xchmod (basefile, false);
    free (basefile);

    if (server_active && strcmp (cvs_cmd_name, "export"))
	server_base_checkout (rcs, finfo, prev, rev, tag, poptions, options);

    return status;
}



void
base_copy (struct file_info *finfo, const char *rev, const char *flags)
{
    char *basefile;

    TRACE (TRACE_FUNCTION, "base_copy (%s, %s, %s)",
	   finfo->fullname, rev, flags);

    assert (flags && flags[0] && flags[1]);

    basefile = make_base_file_name (finfo->file, rev);
    if (isfile (finfo->file))
	xchmod (finfo->file, true);
    copy_file (basefile, finfo->file);
    if (flags[1] == 'y')
	xchmod (finfo->file, true);
    free (basefile);

    if (server_active && strcmp (cvs_cmd_name, "export"))
	server_base_copy (finfo, rev, flags);
}



void
base_remove (const char *file, const char *rev)
{
    char *basefile;

    if (*rev == '-') rev++;
    basefile = make_base_file_name (file, rev);
    if (unlink_file (basefile) < 0 && !existence_error (errno))
	error (0, errno, "Failed to remove `%s'", basefile);
    free (basefile);
}



/* Merge revisions REV1 and REV2. */
int
base_merge (RCSNode *rcs, struct file_info *finfo, const char *options,
	    const char *urev, const char *rev1, const char *rev2)
{
    char *f1, *f2;
    int retval;

    assert (!options || !options[0]
	    || (options[0] == '-' && options[1] == 'k'));

    /* Check out chosen revisions.  The error message when RCS_checkout
       fails is not very informative -- it is taken verbatim from RCS 5.7,
       and relies on RCS_checkout saying something intelligent upon failure. */

    if (base_checkout (rcs, finfo, urev, rev1, rev1, NULL, options))
	error (1, 0, "checkout of revision %s of `%s' failed.\n",
	       rev1, finfo->fullname);

    if (base_checkout (rcs, finfo, urev, rev2, rev2, NULL, options))
	error (1, 0, "checkout of revision %s of `%s' failed.\n",
	       rev2, finfo->fullname);

    f1 = make_base_file_name (finfo->file, rev1);
    f2 = make_base_file_name (finfo->file, rev2);

    if (!server_active || !server_use_bases())
    {
	/* Merge changes. */
	/* It may violate the current abstraction to fail to generate the same
	 * files on the server as will be generated on the client, but I do not
	 * believe that they are being used currently and it saves server CPU.
	 */
	cvs_output ("Merging differences between revisions ", 0);
	cvs_output (rev1, 0);
	cvs_output (" and ", 5);
	cvs_output (rev2, 0);
	cvs_output (" into `", 7);
	if (!finfo->update_dir || !strcmp (finfo->update_dir, "."))
	    cvs_output (finfo->file, 0);
	else
	    cvs_output (finfo->fullname, 0);
	cvs_output ("'\n", 2);

	retval = merge (finfo->file, finfo->file, f1, f2, rev1, rev2);
    }
    else
	retval = 0;

    if (server_active)
	server_base_merge (finfo, rev1, rev2);

    if (strcmp (urev, rev1) && unlink_file (f1) < 0)
	error (0, errno, "unable to remove `%s'", f1);
    if (strcmp (urev, rev2) && unlink_file (f2) < 0)
	error (0, errno, "unable to remove `%s'", f2);
    free (f1);
    free (f2);

    return retval;
}
