/*
 * Copyright (C) 1986-2007 The Free Software Foundation, Inc.
 *
 * Portions Copyright (C) 1998-2007 Derek Price,
 *                                  Ximbiot LLC <http://ximbiot.com>,
 *                                  and others.
 *
 * Portions Copyright (C) 1992, Brian Berliner and Jeff Polk
 * Portions Copyright (C) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * Create Administration.
 * 
 * Creates a CVS administration directory based on the argument repository; the
 * "Entries" file is prefilled from the "initrecord" argument.
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

/* CVS Headers.  */
#include "repos.h"

#include "cvs.h"



/* update_dir includes dir as its last component.

   Return value is 0 for success, or 1 if we printed a warning message.
   Note that many errors are still fatal; particularly for unlikely errors
   a fatal error is probably better than a warning which might be missed
   or after which CVS might do something non-useful.  If WARN is zero, then
   don't print warnings; all errors are fatal then.  */

int
Create_Admin (const char *dir, const char *update_dir, const char *repository,
              const char *tag, const char *date, int nonbranch, int warn,
              int dotemplate)
{
    FILE *fout;
    char *cp;
    char *reposcopy;
    char *tmp;
    bool ud;

    TRACE (TRACE_FUNCTION, "Create_Admin (%s, %s, %s, %s, %s, %d, %d, %d)",
	   dir, update_dir, repository, tag ? tag : "",
	   date ? date : "", nonbranch, warn, dotemplate);

    if (noexec)
	return 0;

    /* A leading "./" looks bad in error messages.  */
    ud = STREQ (dir, ".");
    tmp = Xasprintf ("%s%s%s", ud ? "" : dir, ud ? "" : "/", CVSADM);
    if (isfile (tmp))
	error (1, 0, "there is a version in %s already", update_dir);

    if (!cvs_mkdir (tmp, update_dir, warn ? 0 : MD_FATAL))
    {
	free (tmp);
	tmp = NULL;
	return 1;
    }
    /* else */

    free (tmp);
    tmp = NULL;

    /* record the current cvs root for later use */

    Create_Root (dir, original_parsed_root->original);
    if (dir != NULL)
	tmp = Xasprintf ("%s/%s", dir, CVSADM_REP);
    else
	tmp = xstrdup (CVSADM_REP);
    fout = CVS_FOPEN (tmp, "w+");
    if (fout == NULL)
    {
	if (update_dir[0] == '\0')
	    error (1, errno, "cannot open %s", tmp);
	else
	    error (1, errno, "cannot open %s/%s", update_dir, CVSADM_REP);
    }
    reposcopy = xstrdup (repository);
    Sanitize_Repository_Name (reposcopy);

    /* The top level of the repository is a special case -- we need to
       write it with an extra dot at the end.  This trailing `.' stuff
       rubs me the wrong way -- on the other hand, I don't want to
       spend the time making sure all of the code can handle it if we
       don't do it. */

    if (STREQ (reposcopy, current_parsed_root->directory))
    {
	reposcopy = xrealloc (reposcopy, strlen (reposcopy) + 3);
	strcat (reposcopy, "/.");
    }

    cp = reposcopy;

    /*
     * If the Repository file is to hold a relative path, try to strip off
     * the leading CVSroot argument.
     */
    {
	char *path = Xasprintf ("%s/", current_parsed_root->directory);
	if (STRNEQ (cp, path, strlen (path)))
	    cp += strlen (path);
	free (path);
    }

    if (fprintf (fout, "%s\n", cp) < 0)
    {
	if (update_dir[0] == '\0')
	    error (1, errno, "write to %s failed", tmp);
	else
	    error (1, errno, "write to %s/%s failed", update_dir, CVSADM_REP);
    }
    if (fclose (fout) == EOF)
    {
	if (update_dir[0] == '\0')
	    error (1, errno, "cannot close %s", tmp);
	else
	    error (1, errno, "cannot close %s/%s", update_dir, CVSADM_REP);
    }

    /* now, do the Entries file */
    if (dir != NULL)
	(void) sprintf (tmp, "%s/%s", dir, CVSADM_ENT);
    else
	(void) strcpy (tmp, CVSADM_ENT);
    fout = CVS_FOPEN (tmp, "w+");
    if (fout == NULL)
    {
	if (update_dir[0] == '\0')
	    error (1, errno, "cannot open %s", tmp);
	else
	    error (1, errno, "cannot open %s/%s", update_dir, CVSADM_ENT);
    }
    if (fclose (fout) == EOF)
    {
	if (update_dir[0] == '\0')
	    error (1, errno, "cannot close %s", tmp);
	else
	    error (1, errno, "cannot close %s/%s", update_dir, CVSADM_ENT);
    }

    /* Create a new CVS/Tag file */
    WriteTag (dir, tag, date, nonbranch, update_dir, repository);

    TRACE (TRACE_FUNCTION, "Create_Admin");

    free (reposcopy);
    free (tmp);
    return 0;
}
