/* This file was written by Jim Kingdon, and is hereby placed
   in the public domain.  */

#include <Wtypes.h>
#include <stdio.h>


/* Bits of the interface.
   For paranoia's sake, I'm not using the same names as Microsoft.
   I don't imagine copying a few names could be a credible copyright
   case, but it seems safer to stick to only what is necessary for
   the interface to work.  */
typedef long SCC_return;
#define SCC_return_success 0
#define SCC_return_not_supported -14
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

typedef long (*SCC_out_proc) (LPCSTR, DWORD);
typedef BOOL (*SCC_popul_proc) (LPVOID callerdat, BOOL add_keep,
                                LONG status, LPCSTR file);



/* We get to put whatever we want here, and the caller will pass it
   to us, so we don't need any global variables.  */
struct context {
    FILE *debuglog;
};

LONG
SccGetVersion ()
{
    return 1;
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
    *contextp = context;
    fprintf (fp, "Made it into SccInitialize!\n");
    fflush (fp);
    return SCC_return_success;
}

SCC_return
SccUninitialize (void *context_arg)
{
    struct context *context = (struct context *)context_arg;
    if (fclose (context->debuglog) == EOF)
        /* FIXME: return error value, I think.  */
        ;
    free (context);
    return SCC_return_success;
}

SCC_return
SccOpenProject (void *context_arg, HWND window, LPSTR user,
                 LPSTR project, LPSTR local_proj, LPSTR aux_proj,
                 LPSTR comment, SCC_out_proc outproc, LONG flags)
{
    return SCC_return_success;
}

SCC_return
SccCloseProject (void *context_arg)
{
    return SCC_return_success;
}

/* cvs get.  */
SCC_return
SccGet (void *context_arg, HWND window, LONG num_files,
        LPSTR *file_names, LONG options, void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs edit.  */
SCC_return
SccCheckout (void *context_arg, HWND window, LONG num_files,
             LPSTR *file_names, LPSTR comment, LONG options,
             void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs ci.  */
SCC_return
SccCheckin (void *context_arg, HWND window, LONG num_files,
            LPSTR *file_names, LPSTR comment, LONG options,
            void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs unedit.  */
SCC_return
SccUncheckout (void *context_arg, HWND window, LONG num_files,
               LPSTR *file_names, LONG options, void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs add + cvs ci, more or less, I think (but see also
   the "keep checked out" flag in options).  */
SCC_return
SccAdd (void *context_arg, HWND window, LONG num_files,
        LPSTR *file_names, LPSTR comment, LONG *options,
        void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs rm -f + cvs ci, I think.  Should barf if SCC_REMOVE_KEEP
   (or maybe just put the file there, as if the user had removed
   it and then done a "copy <saved-file> <filename>".  */
SCC_return
SccRemove (void *context_arg, HWND window, LONG num_files,
           LPSTR *file_names, LPSTR comment, LONG options,
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

/* If "contents flag", then implement this ourself.  For no
   args or checksum (which we fall back to full compare) basically a
   call to No_Diff or ? in the client case.  For timestamp, just a
   Classify_File.  Now, if contents not set, then want to do a
   cvs diff, and preferably start up WinDiff or something (to be
   determined, for now perhaps could just shove in the text).  */
SCC_return
SccDiff (void *context_arg, HWND window, LPSTR file_name,
         LONG options, void *prov_options)
{
    return SCC_return_not_supported;
}

/* cvs log, I presume.  If we want to get fancier we could bring
   up a screen more analogous to the tkCVS log window, let the user
   do "cvs update -r", etc.  */
SCC_return
SccHistory (void *context_arg, HWND window, LONG num_files,
            LPSTR file_names, LONG options, void *prov_options)
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
   such as -r -D -k etc. just for starters.  */
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
                 void *callerdat, LONG options)
{
    return SCC_return_success;
}

/* cvs status, sort of.  */
SCC_return
SccQueryInfo (void *context_arg, LONG num_files, LPSTR *file_names,
              LPLONG status)
{
    return SCC_return_not_supported;
}

SCC_return
SccGetEvents (void *context_arg, LPSTR file_name, LPLONG status,
              LPLONG events_remaining)
{
    /* They say this is supposed to only return cached status
       information, not go to disk or anything.  OK, although I
       haven't really figured out what calls would cause us to
       cache status without returning it then.  */
    return SCC_return_success;
}

/* This is where the user gives us the CVSROOT.  */
SCC_return
SccGetProjPath (void *context_arg, HWND window, LPSTR user,
                LPSTR proj_name, LPSTR local_proj, LPSTR aux_proj,
                BOOL allow_change, BOOL *new)
{
    return SCC_return_not_supported;
}

/* Pretty much similar to SccPopulateList.  */
SCC_return
SccAddFromScc (void *context_arg, HWND window, LONG *files,
               LPSTR **file_names)
{
    return SCC_return_not_supported;
}

/* This changes several aspects of how we interact with the IDE.  */
SCC_return
SccSetOption (void *context_arg, LONG option, LONG val)
{
    return SCC_return_success;
}
