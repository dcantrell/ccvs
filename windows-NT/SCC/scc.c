/* This file was written by Jim Kingdon, and is hereby placed
   in the public domain.  */

#include <Wtypes.h>
#include <stdio.h>
#include <direct.h> /* For chdir */


/* Bits of the interface.
   For paranoia's sake, I'm not using the same names as Microsoft.
   I don't imagine copying a few names could be a credible copyright
   case, but it seems safer to stick to only what is necessary for
   the interface to work.

   Note that some of the descriptions here have a certain amount of
   guesswork (for example, sometimes I have tried to translate to CVS
   terminology without actually verifying that the item means what I
   think it does).  If you find errors, please let us know according to
   the usual procedures for reporting CVS bugs.  */
typedef long SCC_return;
#define SCC_return_success 0
#define SCC_return_unknown_project -2
/* The file is not under SCC control.  */
#define SCC_return_non_scc_file -11
/* This operation is not supported.  I believe this status can only
   be returned from SccGet, SccAdd, SccRemove, SccHistory, or
   SccQueryInfo.  I'm not really sure what happens if it is returned
   from other calls.  */
#define SCC_return_not_supported -14
#define SCC_return_non_specific_error -15

enum SCC_command
{
	SCC_command_get,
	SCC_command_checkout,
	SCC_command_checkin,
	SCC_command_uncheckout,
	SCC_command_add,
	SCC_command_remove,
	SCC_command_diff,
	SCC_command_history,
	SCC_command_rename,
	SCC_command_properties,
	SCC_command_options
};

/* Outproc codes, for second argument to outproc.  */
#define SCC_outproc_info 1L
#define SCC_outproc_warning 2L
#define SCC_outproc_error 3L
/* Codes 4-7 relate to cancels and are only supported if the
   development environment said so with SccSetOption.  */
/* A status message, typically goes in something analogous to the emacs
   minibuffer.  For both this and SCC_outproc_nostatus, the development
   environment returns SCC_outproc_return_cancelled if the user has
   hit the cancel button.  */
#define SCC_outproc_status 4L
/* Like SCC_outproc_status, but there is no message to report.  */
#define SCC_outproc_nostatus 5L
/* Tell the development environment to offer a cancel button.  */
#define SCC_outproc_cancel_on 6L
/* Tell the development environment to not offer a cancel button.  */
#define SCC_outproc_cancel_off 7L

/* Return values from outproc.  */
#define SCC_outproc_return_success 0L
#define SCC_outproc_return_cancelled -1L
typedef long (*SCC_outproc) (char *, long);

typedef BOOL (*SCC_popul_proc) (LPVOID callerdat, BOOL add_keep,
                                LONG status, LPCSTR file);

/* Maximum sizes of various strings.  These are arbitrary limits
   which are imposed by the SCC.  */
/* Name argument to SccInitialize.  */
#define SCC_max_name 31
/* Path argument to SccInitialize.  */
#define SCC_max_init_path 31
/* Various paths many places in the interface.  */
#include <stdlib.h>
#define SCC_max_path _MAX_PATH

/* Status codes, as used by QueryInfo and GetEvents.  */
/* This means that we can't get status.  If the status is not
   SCC_status_error, then the status is a set of bit flags, as defined by
   the other SCC_status_* codes.  */
#define SCC_status_error -1L

/* The following status codes are things which the development environment
   is encouraged to check to determine things like whether to allow
   a checkin.  */
/* The current user has the file checked out (that is, under "cvs edit").
   It may or may not be in the directory where the development
   environment thinks it should be.  */
#define SCC_status_out_me 0x1000L
/* Should be set only if out_me is set.  The file is checked out where
   the development environment thinks it should be.  */
#define SCC_status_out_here 2L
/* Some other user has the file checked out.  */
#define SCC_status_out_someoneelse 4L
/* Reserved checkouts are in effect for the file.  */
#define SCC_status_reserved 8L
/* Reserved checkouts are not in effect for the file.  Multiple users
   can edit it.  Only one of SCC_status_reserved or SCC_status_nonreserved
   should be set.  I think maybe this flag should only be set if there
   actually is more than one copy currently checked out.  */
#define SCC_status_nonreserved 0x10L

/* The following flags are intended for the development environment to
   display the status of a file.  We are allowed to support them or not
   as we choose.  */
/* The file in the working directory is not the latest version in the
   repository.  Like when "cvs status" says "Needs Checkout".  */
#define SCC_status_needs_update 0x20L
/* The file is no longer in the project.  I think this is the case where
   cvs update prints "file xxx is no longer pertinent" (but I don't know,
   there are other statuses involved with removed files).  */
#define SCC_status_not_pertinent 0x40L
/* No checkins are permitted for this file.  No real CVS analogue, because
   this sort of thing would be done by commitinfo, &c.  */
#define SCC_status_no_checkins 0x80L
/* There was a merge, but the user hasn't yet dealt with it.  I think this
   probably should be used both if there were conflicts on the merge and
   if there were not (not sure, though).  */
#define SCC_status_had_conflicts 0x100L
/* This indicates something has happened to the file.  I suspect it mainly
   is intended for cases in which we detect that something happened to the
   file behind our backs.  I suppose CVS might use this for cases in which
   sanity checks on the CVSADM files fail, or in which the file has been
   made read/write without a "cvs edit", or that sort of thing.

   Or maybe it should be set if the file has been edited in the
   normal fashion.  I'm not sure.  */
#define SCC_status_munged 0x800L
/* The file exists in several projects.  In CVS I would suppose the
   equivalent probably would be that several modules (using features
   like -d) are capable of checking out a given file in the repository
   in several locations.  CVS has no current ability to give a different
   status when that has happened, but it might be cool.  */
#define SCC_status_several_projects 0x200L
/* There is a sticky tag or date in effect.  */
#define SCC_status_stuck 0x400L

/* Bits to set in the caps used by SccInitialize.  Most of these are
   relatively straightforward, for example SCC_cap_QueryInfo is set to
   indicate that the SccQueryInfo function is supported.  */
#define SCC_cap_QueryInfo 0x80L
#define SCC_cap_GetProjPath 0x200L
#define SCC_cap_AddFromScc 0x400L
#define SCC_cap_want_outproc 0x8000L

/* These are command options.  Some of them are specific to a particular
   command, some of them are good for more than one command.  Because many
   values are reused for different commands, look at the listed commands
   to see what a particular value means for a particular command.  */
/* Recurse into directories.  SccGet.  */
#define SCC_cmdopt_recurse 2L
/* This means to get all the files in a directory.  SccGet.  */
#define SCC_cmdopt_dir 1L
/* Without this flag, after a checkin, files are normally not checked
   out.  This flag disables that handling, and if it is set files will
   still be checked out after the checkin completes.  SccCheckin, SccAdd.  */
#define SCC_cmdopt_no_unedit 0x1000L
/* File is text.  SccAdd.  */
#define SCC_cmdopt_text 1L
/* File is binary.  SccAdd.  */
#define SCC_cmdopt_binary 2L
/* We are supposed to decide whether it is text or binary.  We can use the
   CVS wrappers stuff to decide based on the file name.  Obviously, this
   constant is just another way of saying that neither SCC_cmdopt_text nor
   SCC_cmdopt_binary are set.  SccAdd.  */
#define SCC_cmdopt_auto 0L
/* Maintain only a head revision for the file, no history.  SccAdd.  */
#define SCC_cmdopt_only_one 4L
/* In addition to removing the file from the repository, also delete it
   from the working directory.  My guess is that development environments
   would generally tend to pass this flag by default.  SccRemove.  */
#define SCC_cmdopt_retain_local 1L
/* Compare files in a case-insensitive fashion.  SccDiff.  */
#define SCC_cmdopt_case_insensitive 2L
/* Ignore whitespace in comparing files.  SccDiff.  */
#define SCC_cmdopt_ignore_all_space 4L
/* Instead of generating diffs, just say whether files are equal, based on
   the file contents.  SccDiff.  */
#define SCC_cmdopt_compare_files 0x10L
/* Instead of generating diffs, just say whether files are equal.  This may
   use a checksum if we want, or if not, it can be the same as
   SCC_cmdopt_compare_files.  */
#define SCC_cmdopt_consult_checksum 0x20L
/* Instead of generating diffs, just say whether files are equal.  This may
   use a timestamp if we want, or if not, it can be the same as either
   SCC_cmdopt_consult_checksum or SCC_cmdopt_compare_files.  */
#define SCC_cmdopt_consult_timestamp 0x40L

/* Values for the flags argument to OpenProject.  */
/* If this is set, and the development environment tries to open a project
   which doesn't exist, then create it.  */
#define SCC_open_autocreate 1L
/* If autocreate is not set, and the development environment tries to
   open a project which doesn't exist, and may_prompt is set, we are
   allowed to prompt the user to create a new project.  If may_prompt
   is not set, we should just return SCC_return_unknown_project and
   not open the project.  */
#define SCC_open_may_prompt 2L

/* Constants for SccSetOption.  */
#define SCC_option_background 1L
/* If option is SCC_option_background, then val turns background
   processing on or off.  If it is off, we can, if we need to, queue
   up events or something which won't disturb the development
   environment.  */
#  define SCC_option_background_yes 1L
#  define SCC_option_background_no 0L
#define SCC_option_cancel 3L
/* If option is SCC_option_cancel, then val says whether the development
   environment supports the SCC_outproc_* codes related to having the
   development environment handle a cancel button.  If this is not set,
   we are allowed/encouraged to implement a cancel button ourselves.  */
#  define SCC_option_cancel_on 1L
#  define SCC_option_cancel_off 0L
/* A SCC_option_* value of 10 has also been observed (I think from
   CodeWright 5.00).  I have no idea what it means; it isn't documented
   by the SCC API from Microsoft (version 0.99.0823).  */

/* We get to put whatever we want here, and the caller will pass it
   to us, so we don't need any global variables.  This is the
   "void *context_arg" argument to most of the Scc* functions.  */
struct context {
    FILE *debuglog;
    /* Value of the CVSROOT we are currently working with (that is, the
       "open project" in SCC terminology), malloc'd, or NULL if there is
       no project currently open.  */
    char *root;
    /* Local directory (working directory in CVS parlance).  */
    char *local;
    SCC_outproc outproc;
};

/* In addition to context_arg, most of the Scc* functions take a
   "HWND window" argument.  This is so that we can put up dialogs.
   The window which is passed in is the IDE's window, which we
   should use as the parent of dialogs that we put up.  */

#include <windows.h>

/* Report a malloc error and return the SCC_return_* value which the
   caller should return to the IDE.  Probably this should be getting
   the window argument too, but for the moment we don't need it.
   Note that we only use this for errors which occur after the
   context->outproc is set up.  */
SCC_return
malloc_error (struct context *context)
{
    (*context->outproc) ("Out of memory\n", SCC_outproc_error);
    return SCC_return_non_specific_error;
}

/* Return the version of the SCC spec, major version in the high word,
   minor version in the low word.  */
LONG
SccGetVersion (void)
{
    /* We implement version 1.1 of the spec.  */
    return 0x10001;
}

SCC_return
SccInitialize (void **contextp, HWND window, LPSTR caller, LPSTR name,
               LPLONG caps, LPSTR path, LPDWORD co_comment_len,
               LPDWORD comment_len)
{
    struct context *context;
    FILE *fp;
    fp = fopen ("d:\\debug.scc", "w");
    if (fp == NULL)
        /* Do what?  Return some error value?  */
        abort ();
    context = malloc (sizeof (struct context));
    if (context == NULL)
    {
        fprintf (fp, "Out of memory\n");
        fclose (fp);
        /* Do what?  Return some error?  */
        abort ();
    }
    context->debuglog = fp;
    context->root = NULL;
    *contextp = context;
    fprintf (fp, "Made it into SccInitialize!\n");
    *caps = (SCC_cap_GetProjPath
	     | SCC_cap_AddFromScc
	     | SCC_cap_want_outproc);

    /* I think maybe this should have some more CVS-like
       name, like "CVS Root", if we decide that is what
       a SCC "project" is.  */
    strncpy (path, "CVS Project:", SCC_max_init_path);
    fprintf (fp, "Caller name is %s\n", caller);
    strncpy (name, "CVS", SCC_max_name);
    /* CVS has no limit on comment length.  But I suppose
       we need to return a value which is small enough for
       a caller to allocate a buffer this big.  Not that I
       would write a caller that way, but.....  */
    *co_comment_len = 8192;
    *comment_len = 8192;
    fflush (fp);
    return SCC_return_success;
}

SCC_return
SccUninitialize (void *context_arg)
{
    struct context *context = (struct context *)context_arg;
    if (ferror (context->debuglog))
	/* FIXME: return error value...  */
    if (fclose (context->debuglog) == EOF)
        /* FIXME: return error value, I think.  */
        ;
    free (context);
    return SCC_return_success;
}

SCC_return
SccOpenProject (void *context_arg, HWND window, LPSTR user,
		LPSTR project, LPSTR local_proj, LPSTR aux_proj,
		LPSTR comment, SCC_outproc outproc,

		/* One or more of the SCC_open_* settings.  */
		LONG flags)
{
    struct context *context = (struct context *)context_arg;

    /* This can happen if the IDE opens a project which is not under
       CVS control.  I'm not sure whether checking for aux_proj
       being "" is the right way to detect this case, but it seems
       it should work because I think that the source code control
       system is what has control over the contents of aux_proj.  */
    if (aux_proj[0] == '\0')
	return SCC_return_unknown_project;

    context->root = malloc (strlen (aux_proj) + 5);
    if (context->root == NULL)
	return SCC_return_non_specific_error;
    strcpy (context->root, aux_proj);
    /* Since we don't yet support creating projects, we don't
       do anything with flags.  */

    if (outproc == 0)
    {
	/* This supposedly can happen if the IDE chooses not to implement
	   the outproc feature.  */
	fprintf (context->debuglog, "Uh oh.  outproc is a null pointer\n");
	context->root = NULL;
	fflush (context->debuglog);
	return SCC_return_non_specific_error;
    }
    context->outproc = outproc;

    fprintf (context->debuglog, "SccOpenProject (aux_proj=%s)\n", aux_proj);

    context->local = malloc (strlen (local_proj) + 5);
    if (context->local == NULL)
	return malloc_error (context);
    strcpy (context->local, local_proj);

    fflush (context->debuglog);
    return SCC_return_success;
}

SCC_return
SccCloseProject (void *context_arg)
{
    struct context *context = (struct context *)context_arg;
    fprintf (context->debuglog, "SccCloseProject\n");
    fflush (context->debuglog);
    if (context->root != NULL)
	free (context->root);
    context->root = NULL;
    return SCC_return_success;
}

/* cvs get.  */
SCC_return
SccGet (void *context_arg, HWND window, LONG num_files,
        LPSTR *file_names,

	/* Command options.  */
	LONG options,

	void *prov_options)
{
    struct context *context = (struct context *)context_arg;
    int i;
    char *fname;

    fprintf (context->debuglog, "SccGet: %d; files:", num_files);
#if 1
    for (i = 0; i < num_files; ++i)
    {
	fprintf (context->debuglog, "%s ", file_names[i]);
    }
#endif
    fprintf (context->debuglog, "\n");
    if (options & SCC_cmdopt_dir)
	fprintf (context->debuglog, "  Get all\n");
    /* Should be using this flag to set -R vs. -l.  */
    if (options & SCC_cmdopt_recurse)
	fprintf (context->debuglog, "  recurse\n");

    for (i = 0; i < num_files; ++i)
    {
	FILE *fp;

	/* As with all file names passed to us by the SCC, these
	   file names are absolute pathnames.  I think they will
	   tend to be paths within context->local, although I
	   don't know whether there are any exceptions to that.  */
	fname = file_names[i];
	fprintf (context->debuglog, "%s ", fname);
#if 0
	fp = fopen (fname, "w");
#endif
    }
    fprintf (context->debuglog, "\nExiting SccGet\n");
    fflush (context->debuglog);
    return SCC_return_success;
}

/* cvs edit.  */
SCC_return
SccCheckout (void *context_arg, HWND window, LONG num_files,
             LPSTR *file_names, LPSTR comment,

	     /* Command options.  I'm not sure what command options,
		if any, are defined for SccCheckout.  */
	     LONG options,

             void *prov_options)
{
    struct context *context = (struct context *)context_arg;
    fprintf (context->debuglog, "SccCheckout num_files=%ld\n", num_files);
    fflush (context->debuglog);
    /* For the moment we say that all files are not ours.  I'm not sure
       whether this is ever necessary; that is, whether the IDE will call
       us except where we have told the IDE that a file is under source
       control.  */
    /* I'm not sure what we would do if num_files > 1 and we wanted to
       return different statuses for different files.  */
    return SCC_return_non_scc_file;
}

/* cvs ci.  */
SCC_return
SccCheckin (void *context_arg, HWND window, LONG num_files,
            LPSTR *file_names, LPSTR comment,

	    /* Command options.  */
	    LONG options,

            void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs unedit.  */
SCC_return
SccUncheckout (void *context_arg, HWND window, LONG num_files,
               LPSTR *file_names,

	       /* Command options.  I'm not sure what command options,
		  if any, are defined for SccUncheckout.  */
	       LONG options,

	       void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs add + cvs ci, more or less, I think (but see also
   the "keep checked out" flag in options).  */
SCC_return
SccAdd (void *context_arg, HWND window, LONG num_files,
        LPSTR *file_names, LPSTR comment,

	/* Array of NUM_FILES command options, one for each file.  */
	LONG *options,

        void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs rm -f + cvs ci, I think.  Should barf if SCC_REMOVE_KEEP
   (or maybe just put the file there, as if the user had removed
   it and then done a "copy <saved-file> <filename>".  */
SCC_return
SccRemove (void *context_arg, HWND window, LONG num_files,
           LPSTR *file_names, LPSTR comment,

	   /* Command options.  */
	   LONG options,

           void *prov_options)
{
    return SCC_return_not_supported;
}

/* mv, cvs add, cvs rm, and cvs ci, I think.  */
SCC_return
SccRename (void *context_arg, HWND window, LPSTR old_name,
           LPSTR new_name)
{
    return SCC_return_not_supported;
}

/* If SCC_cmdopt_compare_files, SCC_cmdopt_consult_checksum, or
   SCC_cmdopt_consult_timestamp, then we are supposed to silently
   return a status, without providing any information directly to the
   user.  For no args or checksum (which we fall back to full compare)
   basically a call to No_Diff or ? in the client case.  For
   timestamp, just a Classify_File.  Now, if contents not set, then
   want to do a cvs diff, and preferably start up WinDiff or something
   (to be determined, for now perhaps could just return text via
   outproc).  */
SCC_return
SccDiff (void *context_arg, HWND window, LPSTR file_name,

	 /* Command options.  */
         LONG options,

	 void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs log, I presume.  If we want to get fancier we could bring
   up a screen more analogous to the tkCVS log window, let the user
   do "cvs update -r", etc.  */
SCC_return
SccHistory (void *context_arg, HWND window, LONG num_files,
            LPSTR *file_names,

	    /* Command options.  I'm not sure what command options,
	       if any, are defined for SccHistory.  */
	    LONG options,

	    void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs status, presumably.  */
SCC_return
SccProperties (void *context_arg, HWND window, LPSTR file_name)
{
    return SCC_return_not_supported;
}

/* Not sure what this should do.  The most obvious thing is some
   kind of front-end to "cvs admin" but I'm not actually sure that
   is the most useful thing.  */
SCC_return
SccRunScc (void *context_arg, HWND window, LONG num_files,
           LPSTR *file_names)
{
    return SCC_return_not_supported;
}

/* Lots of things that we could do here.  Options to get/update
   such as -r -D -k etc. just for starters.  Note that the terminology is
   a little confusing here.  This function relates to "provider options"
   (prov_options) which are a way for us to provide extra dialogs beyond
   the basic ones for a particular command.  It is unrelated to "command
   options" (SCC_cmdopt_*).  */
SCC_return
SccGetCommandOptions (void *context_arg, HWND window,
                      enum SCC_command command,
                      void **prov_optionsp)
{
    return SCC_return_not_supported;
}

/* Not existing CVS functionality, I don't think.
   Need to be able to tell user about what files
   are out there without actually getting them.  */
SCC_return
SccPopulateList (void *context_arg, enum SCC_command command,
                 LONG num_files,
                 LPSTR *file_names, SCC_popul_proc populate,
                 void *callerdat,

		 /* Command options.  I'm not sure what command options,
		    if any, are defined for SccPopulateList.  */
		 LONG options)
{
    return SCC_return_success;
}

/* cvs status, sort of.  */
SCC_return
SccQueryInfo (void *context_arg, LONG num_files, LPSTR *file_names,

	      /* This is an array of NUM_FILES entries.  In each one
		 we store a SCC_status_* code.  */
              LPLONG status)
{
    return SCC_return_not_supported;
}

/* Like QueryInfo, but fast and for only a single file.  For example, the
   development environment might call this quite frequently to keep its
   screen display updated.  */
SCC_return
SccGetEvents (void *context_arg, LPSTR file_name,

	      /* Here we store the SCC_status_* code.  */
	      LPLONG status,

              LPLONG events_remaining)
{
    /* They say this is supposed to only return cached status
       information, not go to disk or anything.  I assume that
       QueryInfo and probably the usual calls like Get would cause
       us to cache the status in the first place.  */
    return SCC_return_success;
}

/* This is where the user gives us the CVSROOT.  */
SCC_return
SccGetProjPath (void *context_arg, HWND window, LPSTR user,
                LPSTR proj_name, LPSTR local_proj, LPSTR aux_proj,
                BOOL allow_change, BOOL *new)
{
    /* For now we just hardcode the CVSROOT.  In the future we will
       of course prompt the user for it (simple implementation would
       have them supply a string; potentially better implementation
       would have menus or something for access methods and so on,
       although it might also have a way of bypassing that in case
       CVS supports new features that the GUI code doesn't
       understand).  We probably will also at some point want a
       "project" to encompass both a CVSROOT and a directory or
       module name within that CVSROOT, but we don't try to handle
       that yet either.  We also will want to be able to use "user"
       instead of having the username encoded in the aux_proj or
       proj_name, probably.  */

    struct context *context = (struct context *)context_arg;
    fprintf (context->debuglog, "SccGetProjPath called\n");

    /* At least for now we leave the proj_name alone, and just use
       the aux_proj.  */
    strncpy (proj_name, "zwork", SCC_max_path);
    strncpy (aux_proj, ":server:harvey:/home/kingdon/zwork/cvsroot",
	     SCC_max_path);
    if (local_proj[0] == '\0' && allow_change)
	strncpy (local_proj, "d:\\sccwork", SCC_max_path);
    /* I don't think I saw anything in the spec about this,
       but let's see if it helps.  */
    if (_chdir (local_proj) < 0)
	fprintf (context->debuglog, "Error in chdir: %s", strerror (errno));

    if (*new)
	/* It is OK for us to prompt the user for creating a new
	   project.  */
	/* We will say that the user said to create a new one.  */
	*new = 1;

    fflush (context->debuglog);
    return SCC_return_success;
}

/* Pretty much similar to SccPopulateList.  */
SCC_return
SccAddFromScc (void *context_arg, HWND window, LONG *files,
               char ***file_names)
{
    struct context *context = (struct context *)context_arg;

    /* For now we have hardcoded the notion that there are two files,
       foo.c and bar.c.  */
#define NUM_FILES 2
    if (files == NULL)
    {
	char **p;

	/* This means to free the memory that is allocated for
	   file_names.  */
	for (p = *file_names; *p != NULL; ++p)
	{
	    fprintf (context->debuglog, "Freeing %s\n", *p);
	    free (*p);
	}
    }
    else
    {
	*file_names = malloc ((NUM_FILES + 1) * sizeof (char **));
	if (*file_names == NULL)
	    return malloc_error (context);
	(*file_names)[0] = malloc (80);
	if ((*file_names)[0] == NULL)
	    return malloc_error (context);
	strcpy ((*file_names)[0], "foo.c");
	(*file_names)[1] = malloc (80);
	if ((*file_names)[1] == NULL)
	    return malloc_error (context);
	strcpy ((*file_names)[1], "bar.c");
	(*file_names)[2] = NULL;
	*files = 2;

	/* Are we supposed to also Get the files?  Or is the IDE
	   next going to call SccGet on each one?  The spec doesn't
	   say explicitly.  */
    }
    fprintf (context->debuglog, "Success in SccAddFromScc\n");
    fflush (context->debuglog);
    return SCC_return_success;
}

/* This changes several aspects of how we interact with the IDE.  */
SCC_return
SccSetOption (void *context_arg,
	      /* One of the SCC_option_* codes.  */
	      LONG option,
	      /* Meaning of this will depend on the value of option.  */
	      LONG val)
{
    return SCC_return_success;
}
