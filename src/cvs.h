/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 *
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS kit.
 */

/*
 * basic information used in all source files
 *
 */


#ifdef HAVE_CONFIG_H
# include <config.h>		/* this is stuff found via autoconf */
#endif /* CONFIG_H */

/* Add GNU attribute suppport.  */
#ifndef __attribute__
/* This feature is available in gcc versions 2.5 and later.  */
# if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 5) || __STRICT_ANSI__
#  define __attribute__(Spec) /* empty */
# else
#   if __GNUC__ == 2 && __GNUC_MINOR__ < 96
#    define __pure__	/* empty */
#   endif
#   if __GNUC__ < 3
#    define __malloc__	/* empty */
#   endif
# endif
/* The __-protected variants of `format' and `printf' attributes
   are accepted by gcc versions 2.6.4 (effectively 2.7) and later.  */
# if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 7)
#  define __const__	const
#  define __format__	format
#  define __noreturn__	noreturn
#  define __printf__	printf
# endif
#endif /* __attribute__ */

#include "exit.h"

#if ! STDC_HEADERS
extern char *getenv();
#endif /* ! STDC_HEADERS */

/* Under OS/2, <stdio.h> doesn't define popen()/pclose(). */
#ifdef USE_OWN_POPEN
#include "popen.h"
#endif

#ifdef SERVER_SUPPORT
/* If the system doesn't provide strerror, it won't be declared in
   string.h.  */
char *strerror (int);
#endif

#ifdef HAVE_FNMATCH
# include <fnmatch.h> /* This is supposed to be available on Posix systems */
#else /* HAVE_FNMATCH */
# include "fnmatch.h" /* Our substitute */
#endif /* HAVE_FNMATCH */

#include "system.h"

#include "hash.h"

#include "root.h"

#if defined(SERVER_SUPPORT) || defined(CLIENT_SUPPORT)
# include "client.h"
#endif

#ifdef MY_NDBM
#include "myndbm.h"
#else
#include <ndbm.h>
#endif /* MY_NDBM */

#include "regex.h"
#include "getopt.h"
#include "wait.h"

#include "rcs.h"



/* Note that the _ONLY_ reason for PATH_MAX is if various system calls (getwd,
 * getcwd, readlink) require/want us to use it.  All other parts of CVS
 * allocate pathname buffers dynamically, and we want to keep it that way.
 */
#include "pathmax.h"



/* Definitions for the CVS Administrative directory and the files it contains.
   Here as #define's to make changing the names a simple task.  */

#ifdef USE_VMS_FILENAMES
#define CVSADM          "CVS"
#define CVSADM_ENT      "CVS/Entries."
#define CVSADM_ENTBAK   "CVS/Entries.Backup"
#define CVSADM_ENTLOG   "CVS/Entries.Log"
#define CVSADM_ENTSTAT  "CVS/Entries.Static"
#define CVSADM_REP      "CVS/Repository."
#define CVSADM_ROOT     "CVS/Root."
#define CVSADM_TAG      "CVS/Tag."
#define CVSADM_NOTIFY   "CVS/Notify."
#define CVSADM_NOTIFYTMP "CVS/Notify.tmp"
#define CVSADM_BASE      "CVS/Base"
#define CVSADM_BASEREV   "CVS/Baserev."
#define CVSADM_BASEREVTMP "CVS/Baserev.tmp"
#define CVSADM_TEMPLATE "CVS/Template."
#else /* USE_VMS_FILENAMES */
#define	CVSADM		"CVS"
#define	CVSADM_ENT	"CVS/Entries"
#define	CVSADM_ENTBAK	"CVS/Entries.Backup"
#define CVSADM_ENTLOG	"CVS/Entries.Log"
#define	CVSADM_ENTSTAT	"CVS/Entries.Static"
#define	CVSADM_REP	"CVS/Repository"
#define	CVSADM_ROOT	"CVS/Root"
#define	CVSADM_TAG	"CVS/Tag"
#define CVSADM_NOTIFY	"CVS/Notify"
#define CVSADM_NOTIFYTMP "CVS/Notify.tmp"
/* A directory in which we store base versions of files we currently are
   editing with "cvs edit".  */
#define CVSADM_BASE     "CVS/Base"
#define CVSADM_BASEREV  "CVS/Baserev"
#define CVSADM_BASEREVTMP "CVS/Baserev.tmp"
/* File which contains the template for use in log messages.  */
#define CVSADM_TEMPLATE "CVS/Template"
#endif /* USE_VMS_FILENAMES */

/* This is the special directory which we use to store various extra
   per-directory information in the repository.  It must be the same as
   CVSADM to avoid creating a new reserved directory name which users cannot
   use, but is a separate #define because if anyone changes it (which I don't
   recommend), one needs to deal with old, unconverted, repositories.
   
   See fileattr.h for details about file attributes, the only thing stored
   in CVSREP currently.  */
#define CVSREP "CVS"

/*
 * Definitions for the CVSROOT Administrative directory and the files it
 * contains.  This directory is created as a sub-directory of the $CVSROOT
 * environment variable, and holds global administration information for the
 * entire source repository beginning at $CVSROOT.
 */
#define	CVSROOTADM		"CVSROOT"
#define	CVSROOTADM_MODULES	"modules"
#define	CVSROOTADM_LOGINFO	"loginfo"
#define	CVSROOTADM_RCSINFO	"rcsinfo"
#define CVSROOTADM_COMMITINFO	"commitinfo"
#define CVSROOTADM_TAGINFO      "taginfo"
#define CVSROOTADM_VERIFYMSG    "verifymsg"
#define	CVSROOTADM_HISTORY	"history"
#define CVSROOTADM_VALTAGS	"val-tags"
#define	CVSROOTADM_IGNORE	"cvsignore"
#define	CVSROOTADM_CHECKOUTLIST "checkoutlist"
#define CVSROOTADM_WRAPPER	"cvswrappers"
#define CVSROOTADM_NOTIFY	"notify"
#define CVSROOTADM_USERS	"users"
#define CVSROOTADM_READERS	"readers"
#define CVSROOTADM_WRITERS	"writers"
#define CVSROOTADM_PASSWD	"passwd"
#define CVSROOTADM_CONFIG	"config"

#define CVSNULLREPOS		"Emptydir"	/* an empty directory */

/* Other CVS file names */

/* Files go in the attic if the head main branch revision is dead,
   otherwise they go in the regular repository directories.  The whole
   concept of having an attic is sort of a relic from before death
   support but on the other hand, it probably does help the speed of
   some operations (such as main branch checkouts and updates).  */
#define	CVSATTIC	"Attic"

#define	CVSLCK		"#cvs.lock"
#define	CVSRFL		"#cvs.rfl"
#define	CVSWFL		"#cvs.wfl"
#define CVSRFLPAT	"#cvs.rfl.*"	/* wildcard expr to match read locks */
#define	CVSEXT_LOG	",t"
#define	CVSPREFIX	",,"
#define CVSDOTIGNORE	".cvsignore"
#define CVSDOTWRAPPER   ".cvswrappers"

/* Command attributes -- see function lookup_command_attribute(). */
#define CVS_CMD_IGNORE_ADMROOT        1

/* Set if CVS needs to create a CVS/Root file upon completion of this
   command.  The name may be slightly confusing, because the flag
   isn't really as general purpose as it seems (it is not set for cvs
   release).  */

#define CVS_CMD_USES_WORK_DIR         2

#define CVS_CMD_MODIFIES_REPOSITORY   4

/* miscellaneous CVS defines */

/* This is the string which is at the start of the non-log-message lines
   that we put up for the user when they edit the log message.  */
#define	CVSEDITPREFIX	"CVS: "
/* Number of characters in CVSEDITPREFIX to compare when deciding to strip
   off those lines.  We don't check for the space, to accomodate users who
   have editors which strip trailing spaces.  */
#define CVSEDITPREFIXLEN 4

#define	CVSLCKAGE	(60*60)		/* 1-hour old lock files cleaned up */
#define	CVSLCKSLEEP	30		/* wait 30 seconds before retrying */
#define	CVSBRANCH	"1.1.1"		/* RCS branch used for vendor srcs */

#ifdef USE_VMS_FILENAMES
#define BAKPREFIX       "_$"
#define DEVNULL         "NLA0:"
#else /* USE_VMS_FILENAMES */
#define	BAKPREFIX	".#"		/* when rcsmerge'ing */
#ifndef DEVNULL
#define	DEVNULL		"/dev/null"
#endif
#endif /* USE_VMS_FILENAMES */

/*
 * Special tags. -rHEAD	refers to the head of an RCS file, regardless of any
 * sticky tags. -rBASE	refers to the current revision the user has checked
 * out This mimics the behaviour of RCS.
 */
#define	TAG_HEAD	"HEAD"
#define	TAG_BASE	"BASE"

/* Environment variable used by CVS */
#define	CVSREAD_ENV	"CVSREAD"	/* make files read-only */
#define	CVSREAD_DFLT	0		/* writable files by default */

#define	CVSREADONLYFS_ENV "CVSREADONLYFS" /* repository is read-only */

#define	TMPDIR_ENV	"TMPDIR"	/* Temporary directory */
#define	CVS_PID_ENV	"CVS_PID"	/* pid of running cvs */

#define	EDITOR1_ENV	"CVSEDITOR"	/* which editor to use */
#define	EDITOR2_ENV	"VISUAL"	/* which editor to use */
#define	EDITOR3_ENV	"EDITOR"	/* which editor to use */

#define	CVSROOT_ENV	"CVSROOT"	/* source directory root */
#define	CVSROOT_DFLT	NULL		/* No dflt; must set for checkout */

#define	IGNORE_ENV	"CVSIGNORE"	/* More files to ignore */
#define WRAPPER_ENV     "CVSWRAPPERS"   /* name of the wrapper file */

#define	CVSUMASK_ENV	"CVSUMASK"	/* Effective umask for repository */

/*
 * If the beginning of the Repository matches the following string, strip it
 * so that the output to the logfile does not contain a full pathname.
 *
 * If the CVSROOT environment variable is set, it overrides this define.
 */
#define	REPOS_STRIP	"/master/"

/* Large enough to hold DATEFORM.  Not an arbitrary limit as long as
   it is used for that purpose, and not to hold a string from the
   command line, the client, etc.  */
#define MAXDATELEN	50

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

/* The type of request that is being done in do_module() */
enum mtype
{
    CHECKOUT, TAG, PATCH, EXPORT, MISC
};

/*
 * structure used for list-private storage by Entries_Open() and
 * Version_TS() and Find_Directories().
 */
struct stickydirtag
{
    /* These fields pass sticky tag information from Entries_Open() to
       Version_TS().  */
    int aflag;
    char *tag;
    char *date;
    int nonbranch;

    /* This field is set by Entries_Open() if there was subdirectory
       information; Find_Directories() uses it to see whether it needs
       to scan the directory itself.  */
    int subdirs;
};

/* Flags for find_{names,dirs} routines */
#define W_LOCAL			0x01	/* look for files locally */
#define W_REPOS			0x02	/* look for files in the repository */
#define W_ATTIC			0x04	/* look for files in the attic */

/* Flags for return values of direnter procs for the recursion processor */
enum direnter_type
{
    R_PROCESS = 1,			/* process files and maybe dirs */
    R_SKIP_FILES,			/* don't process files in this dir */
    R_SKIP_DIRS,			/* don't process sub-dirs */
    R_SKIP_ALL				/* don't process files or dirs */
};
#ifdef ENUMS_CAN_BE_TROUBLE
typedef int Dtype;
#else
typedef enum direnter_type Dtype;
#endif

/* Recursion processor lock types */
#define CVS_LOCK_NONE	0
#define CVS_LOCK_READ	1
#define CVS_LOCK_WRITE	2

/* Option flags for Parse_Info() */
#define PIOPT_ALL 1	/* accept "all" keyword */

extern char *program_name, *program_path, *command_name;
extern char *Tmpdir, *Editor;
extern int cvsadmin_root;
extern char *CurDir;
extern int really_quiet, quiet;
extern int use_editor;
extern int cvswrite;
extern mode_t cvsumask;



/* This global variable holds the global -d option.  It is NULL if -d
   was not used, which means that we must get the CVSroot information
   from the CVSROOT environment variable or from a CVS/Root file.  */
extern char *CVSroot_cmdline;

/* These variables keep track of all of the CVSROOT directories that
   have been seen by the client and the current one of those selected.  */
extern List *root_directories;
extern cvsroot_t *current_parsed_root;

extern char *emptydir_name (void);
extern int safe_location (char *);

extern int trace;		/* Show all commands */
extern int noexec;		/* Don't modify disk anywhere */
extern int readonlyfs;		/* fail on all write locks; succeed all read locks */
extern int logoff;		/* Don't write history entry */

extern int top_level_admin;


#define LOGMSG_REREAD_NEVER 0	/* do_verify - never  reread message */
#define LOGMSG_REREAD_ALWAYS 1	/* do_verify - always reread message */
#define LOGMSG_REREAD_STAT 2	/* do_verify - reread message if changed */
extern int RereadLogAfterVerify;

#ifdef CLIENT_SUPPORT
extern List *dirs_sent_to_server; /* used to decide which "Argument
				     xxx" commands to send to each
				     server in multiroot mode. */
#endif

extern char hostname[];

/* Externs that are included directly in the CVS sources */

int RCS_merge (RCSNode *, char *, char *, char *, char *, char *);
/* Flags used by RCS_* functions.  See the description of the individual
   functions for which flags mean what for each function.  */
#define RCS_FLAGS_FORCE 1
#define RCS_FLAGS_DEAD 2
#define RCS_FLAGS_QUIET 4
#define RCS_FLAGS_MODTIME 8
#define RCS_FLAGS_KEEPFILE 16

extern int RCS_exec_rcsdiff (RCSNode *rcsfile,
				    char *opts, char *options,
				    char *rev1, char *rev1_cache, char *rev2,
				    char *label1, char *label2,
				    char *workfile);
extern int diff_exec (char *file1, char *file2,
			     char *label1, char *label2,
			     char *options, char *out);


#include "error.h"

DBM *open_module (void);
FILE *open_file (const char *, const char *);
List *Find_Directories (char *repository, int which, List *entries);
void Entries_Close (List *entries);
List *Entries_Open (int aflag, char *update_dir);
void Subdirs_Known (List *entries);
void Subdir_Register (List *, const char *, const char *);
void Subdir_Deregister (List *, const char *, const char *);

char *Make_Date (char *rawdate);
char *date_from_time_t (time_t);
void date_to_internet (char *, const char *);
void date_to_tm (struct tm *, const char *);
void tm_to_internet (char *, const struct tm *);

char *Name_Repository (char *dir, char *update_dir);
char *Short_Repository (char *repository);
void Sanitize_Repository_Name (char *repository);

char *Name_Root (char *dir, char *update_dir);
void free_cvsroot_t (cvsroot_t *root_in);
cvsroot_t *parse_cvsroot (const char *root)
	__attribute__ ((__malloc__));
cvsroot_t *local_cvsroot (const char *dir)
	__attribute__ ((__malloc__));
void Create_Root (char *dir, char *rootdir);
void root_allow_add (char *);
void root_allow_free (void);
int root_allow_ok (char *);

char *gca (const char *rev1, const char *rev2);
extern void check_numeric (const char *, int, char **);
char *getcaller (void);
char *time_stamp (char *file);

void *xmalloc (size_t bytes)
	__attribute__((__malloc__));
void *xrealloc (void *ptr, size_t bytes)
	__attribute__ ((__malloc__));
void expand_string (char **, size_t *, size_t);
void xrealloc_and_strcat (char **, size_t *, const char *);
char *xstrdup (const char *str)
	__attribute__ ((__malloc__));
int strip_trailing_newlines (char *str);
int pathname_levels (char *path);

typedef	int (*CALLPROC)	( char *repository, char *value, void *closure );
int Parse_Info ( char *infofile, char *repository, CALLPROC callproc,
                       int opt, void *closure );
extern int parse_config (char *);

typedef	RETSIGTYPE (*SIGCLEANUPPROC)	();
int SIG_register (int sig, SIGCLEANUPPROC sigcleanup);
int isdir (const char *file);
int isfile (const char *file);
int islink (const char *file);
int isdevice (const char *);
int isreadable (const char *file);
int iswritable (const char *file);
int isaccessible (const char *file, const int mode);
int isabsolute (const char *filename);
#ifdef HAVE_READLINK
char *xreadlink (const char *link);
#endif /* HAVE_READLINK */
char *xresolvepath (const char *path);
char *last_component (char *path);
char *get_homedir (void);
char *strcat_filename_onto_homedir (const char *, const char *);
char *cvs_temp_name (void);
FILE *cvs_temp_file (char **filename);

int numdots (const char *s);
char *increment_revnum (const char *);
int compare_revnums (const char *, const char *);
int unlink_file (const char *f);
int unlink_file_dir (const char *f);
int update (int argc, char *argv[]);
int xcmp (const char *file1, const char *file2);
int yesno (void);
void *valloc (size_t bytes);
time_t get_date (char *date, struct timeb *now);
extern int Create_Admin (char *dir, char *update_dir,
			 char *repository, char *tag, char *date,
			 int nonbranch, int warn, int dotemplate);
extern int expand_at_signs (char *, off_t, FILE *);

/* Locking subsystem (implemented in lock.c).  */

int Reader_Lock (char *xrepository);
void Lock_Cleanup (void);

/* Writelock an entire subtree, well the part specified by ARGC, ARGV, LOCAL,
   and AFLAG, anyway.  */
void lock_tree_for_write (int argc, char **argv, int local, int which,
				 int aflag);

/* See lock.c for description.  */
extern void lock_dir_for_write (char *);

/* LockDir setting from CVSROOT/config.  */
extern char *lock_dir;

/* AllowedAdminOptions setting from CVSROOT/config.  */
extern char *UserAdminOptions;

void Scratch_Entry (List * list, char *fname);
void ParseTag (char **tagp, char **datep, int *nonbranchp);
void WriteTag (char *dir, char *tag, char *date, int nonbranch,
		      char *update_dir, char *repository);
void WriteTemplate (char *update_dir, int dotemplate,
			   char *repository);
void cat_module (int status);
void check_entries (char *dir);
void close_module (DBM * db);
void copy_file (const char *from, const char *to);
void fperrmsg (FILE * fp, int status, int errnum, char *message,...);
void free_names (int *pargc, char *argv[]);

extern int ign_name (char *name);
void ign_add (char *ign, int hold);
void ign_add_file (char *file, int hold);
void ign_setup (void);
void ign_dir_add (char *name);
int ignore_directory (char *name);
typedef void (*Ignore_proc) (char *, char *);
extern void ignore_files (List *, List *, char *, Ignore_proc);
extern int ign_inhibit_server;
extern int ign_case;

#include "update.h"

void line2argv (int *pargc, char ***argv, char *line, char *sepchars);
void make_directories (const char *name);
void make_directory (const char *name);
extern int mkdir_if_needed (char *name);
void rename_file (const char *from, const char *to);
/* Expand wildcards in each element of (ARGC,ARGV).  This is according to the
   files which exist in the current directory, and accordingly to OS-specific
   conventions regarding wildcard syntax.  It might be desirable to change the
   former in the future (e.g. "cvs status *.h" including files which don't exist
   in the working directory).  The result is placed in *PARGC and *PARGV;
   the *PARGV array itself and all the strings it contains are newly
   malloc'd.  It is OK to call it with PARGC == &ARGC or PARGV == &ARGV.  */
extern void expand_wild (int argc, char **argv, 
                                int *pargc, char ***pargv);
char *locate_file_in_dir (const char *dir, const char *file );

#ifdef SERVER_SUPPORT
extern int cvs_casecmp (const char *, const char *);
extern int fopen_case (char *, char *, FILE **, char **);
#endif

/* exithandle.c */
void signals_register (RETSIGTYPE (*handler)(int));
void cleanup_register (void (*handler) (void));

void strip_trailing_slashes (char *path);
void update_delproc (Node * p);
void usage (const char *const *cpp);
void xchmod (char *fname, int writable);
char *xgetwd (void);
List *Find_Names (char *repository, int which, int aflag,
		  List ** optentries);
void Register (List * list, char *fname, char *vn, char *ts,
	       char *options, char *tag, char *date, char *ts_conflict);
void Update_Logfile (char *repository, char *xmessage, FILE * xlogfp,
		     List * xchanges);
void do_editor (char *dir, char **messagep,
		      char *repository, List * changes);

void do_verify (char **messagep, char *repository);

typedef	int (*CALLBACKPROC)	(int argc, char *argv[], char *where,
	char *mwhere, char *mfile, int shorten, int local_specified,
	char *omodule, char *msg);

/* This is the structure that the recursion processor passes to the
   fileproc to tell it about a particular file.  */
struct file_info
{
    /* Name of the file, without any directory component.  */
    char *file;

    /* Name of the directory we are in, relative to the directory in
       which this command was issued.  We have cd'd to this directory
       (either in the working directory or in the repository, depending
       on which sort of recursion we are doing).  If we are in the directory
       in which the command was issued, this is "".  */
    char *update_dir;

    /* update_dir and file put together, with a slash between them as
       necessary.  This is the proper way to refer to the file in user
       messages.  */
    char *fullname;

    /* Name of the directory corresponding to the repository which contains
       this file.  */
    char *repository;

    /* The pre-parsed entries for this directory.  */
    List *entries;

    RCSNode *rcs;
};

typedef	int (*FILEPROC) (void *callerdat, struct file_info *finfo);
typedef	int (*FILESDONEPROC) (void *callerdat, int err,
				     char *repository, char *update_dir,
				     List *entries);
typedef	Dtype (*DIRENTPROC) (void *callerdat, char *dir,
				    char *repos, char *update_dir,
				    List *entries);
typedef	int (*DIRLEAVEPROC) (void *callerdat, char *dir, int err,
				    char *update_dir, List *entries);

extern int mkmodules (char *dir);
extern int init (int argc, char **argv);

int do_module (DBM * db, char *mname, enum mtype m_type, char *msg,
		CALLBACKPROC callback_proc, char *where, int shorten,
		int local_specified, int run_module_prog, int build_dirs,
		char *extra_arg);
void history_write (int type, char *update_dir, char *revs, char *name,
		    char *repository);
int start_recursion (FILEPROC fileproc, FILESDONEPROC filesdoneproc,
		     DIRENTPROC direntproc, DIRLEAVEPROC dirleaveproc,
		     void *callerdat,
		     int argc, char *argv[], int local, int which,
		     int afag, int locktype, char *update_preload,
		     int dosrcsi, char *repository);
void SIG_beginCrSect (void);
void SIG_endCrSect (void);
int SIG_inCrSect (void);
void read_cvsrc (int *argc, char ***argv, char *cmdname);

char *make_message_rcsvalid (char *message);
extern int file_has_conflict (const struct file_info *,
				     const char *ts_conflict);
extern int file_has_markers (const struct file_info *);
extern void get_file (const char *, const char *, const char *,
			     char **, size_t *, size_t *);
extern char *shell_escape (char *buf, const char *str);
char *backup_file (const char *file, const char *suffix);
extern void resolve_symlink (char **filename);
void sleep_past (time_t desttime);

/* flags for run_exec(), the fast system() for CVS */
#define	RUN_NORMAL		0x0000	/* no special behaviour */
#define	RUN_COMBINED		0x0001	/* stdout is duped to stderr */
#define	RUN_REALLY		0x0002	/* do the exec, even if noexec is on */
#define	RUN_STDOUT_APPEND	0x0004	/* append to stdout, don't truncate */
#define	RUN_STDERR_APPEND	0x0008	/* append to stderr, don't truncate */
#define	RUN_SIGIGNORE		0x0010	/* ignore interrupts for command */
#define	RUN_TTY		(char *)0	/* for the benefit of lint */

void run_arg (const char *s);
void run_print (FILE * fp);
void run_setup (const char *prog);
int run_exec (const char *stin, const char *stout, const char *sterr,
		    int flags);

/* other similar-minded stuff from run.c.  */
FILE *run_popen (const char *, const char *);
int piped_child (char **, int *, int *);
void close_on_exec (int);

pid_t waitpid (pid_t, int *, int);

/*
 * a struct vers_ts contains all the information about a file including the
 * user and rcs file names, and the version checked out and the head.
 *
 * this is usually obtained from a call to Version_TS which takes a
 * tag argument for the RCS file if desired
 */
struct vers_ts
{
    /* rcs version user file derives from, from CVS/Entries.
       It can have the following special values:

       NULL = file is not mentioned in Entries (this is also used for a
	      directory).
       "" = INVALID!  The comment used to say that it meant "no user file"
	    but as far as I know CVS didn't actually use it that way.
	    Note that according to cvs.texinfo, "" is not valid in the
	    Entries file.
       0 = user file is new
       -vers = user file to be removed.  */
    char *vn_user;

    /* Numeric revision number corresponding to ->vn_tag (->vn_tag
       will often be symbolic).  */
    char *vn_rcs;
    /* If ->tag is a simple tag in the RCS file--a tag which really
       exists which is not a magic revision--and if ->date is NULL,
       then this is a copy of ->tag.  Otherwise, it is a copy of
       ->vn_rcs.  */
    char *vn_tag;

    /* This is the timestamp from stating the file in the working directory.
       It is NULL if there is no file in the working directory.  It is
       "Is-modified" if we know the file is modified but don't have its
       contents.  */
    char *ts_user;
    /* Timestamp from CVS/Entries.  For the server, ts_user and ts_rcs
       are computed in a slightly different way, but the fact remains that
       if they are equal the file in the working directory is unmodified
       and if they differ it is modified.  */
    char *ts_rcs;

    /* Options from CVS/Entries (keyword expansion), malloc'd.  If none,
       then it is an empty string (never NULL).  */
    char *options;

    /* If non-NULL, there was a conflict (or merely a merge?  See merge_file)
       and the time stamp in this field is the time stamp of the working
       directory file which was created with the conflict markers in it.
       This is from CVS/Entries.  */
    char *ts_conflict;

    /* Tag specified on the command line, or if none, tag stored in
       CVS/Entries.  */
    char *tag;
    /* Date specified on the command line, or if none, date stored in
       CVS/Entries.  */
    char *date;
    /* If this is 1, then tag is not a branch tag.  If this is 0, then
       tag may or may not be a branch tag.  */
    int nonbranch;

    /* Pointer to entries file node  */
    Entnode *entdata;

    /* Pointer to parsed src file info */
    RCSNode *srcfile;
};
typedef struct vers_ts Vers_TS;

Vers_TS *Version_TS (struct file_info *finfo, char *options, char *tag,
			    char *date, int force_tag_match,
			    int set_time);
void freevers_ts (Vers_TS ** versp);

/* Miscellaneous CVS infrastructure which layers on top of the recursion
   processor (for example, needs struct file_info).  */

int Checkin (int type, struct file_info *finfo, char *rev,
	     char *tag, char *options, char *message);
int No_Difference (struct file_info *finfo, Vers_TS *vers);
/* TODO: can the finfo argument to special_file_mismatch be changed? -twp */
int special_file_mismatch (struct file_info *finfo,
				  char *rev1, char *rev2);

/* CVSADM_BASEREV stuff, from entries.c.  */
extern char *base_get (struct file_info *);
extern void base_register (struct file_info *, char *);
extern void base_deregister (struct file_info *);

/*
 * defines for Classify_File() to determine the current state of a file.
 * These are also used as types in the data field for the list we make for
 * Update_Logfile in commit, import, and add.
 */
enum classify_type
{
    T_UNKNOWN = 1,			/* no old-style analog existed	 */
    T_CONFLICT,				/* C (conflict) list		 */
    T_NEEDS_MERGE,			/* G (needs merging) list	 */
    T_MODIFIED,				/* M (needs checked in) list 	 */
    T_CHECKOUT,				/* O (needs checkout) list	 */
    T_ADDED,				/* A (added file) list		 */
    T_REMOVED,				/* R (removed file) list	 */
    T_REMOVE_ENTRY,			/* W (removed entry) list	 */
    T_UPTODATE,				/* File is up-to-date		 */
    T_PATCH,				/* P Like C, but can patch	 */
    T_TITLE				/* title for node type 		 */
};
typedef enum classify_type Ctype;

Ctype Classify_File (struct file_info *finfo, char *tag, char *date, char *options,
      int force_tag_match, int aflag, Vers_TS **versp, int pipeout);

/*
 * structure used for list nodes passed to Update_Logfile() and
 * do_editor().
 */
struct logfile_info
{
  enum classify_type type;
  char *tag;
  char *rev_old;		/* rev number before a commit/modify,
				   NULL for add or import */
  char *rev_new;		/* rev number after a commit/modify,
				   add, or import, NULL for remove */
};

/* Wrappers.  */

typedef enum { WRAP_MERGE, WRAP_COPY } WrapMergeMethod;
typedef enum {
    /* -t and -f wrapper options.  Treating directories as single files.  */
    WRAP_TOCVS,
    WRAP_FROMCVS,
    /* -k wrapper option.  Default keyword expansion options.  */
    WRAP_RCSOPTION
} WrapMergeHas;

void  wrap_setup (void);
int   wrap_name_has (const char *name,WrapMergeHas has);
char *wrap_rcsoption (const char *fileName, int asFlag);
char *wrap_tocvs_process_file (const char *fileName);
int   wrap_merge_is_copy (const char *fileName);
void wrap_fromcvs_process_file (const char *fileName);
void wrap_add_file (const char *file,int temp);
void wrap_add (char *line,int temp);
void wrap_send (void);
#if defined(SERVER_SUPPORT) || defined(CLIENT_SUPPORT)
void wrap_unparse_rcs_options (char **, int);
#endif /* SERVER_SUPPORT || CLIENT_SUPPORT */

/* Pathname expansion */
char *expand_path (char *name, char *file, int line);

/* User variables.  */
extern List *variable_list;

extern void variable_set (char *nameval);

int watch (int argc, char **argv);
int edit (int argc, char **argv);
int unedit (int argc, char **argv);
int editors (int argc, char **argv);
int watchers (int argc, char **argv);
extern int annotate (int argc, char **argv);
extern int add (int argc, char **argv);
extern int admin (int argc, char **argv);
extern int checkout (int argc, char **argv);
extern int commit (int argc, char **argv);
extern int diff (int argc, char **argv);
extern int history (int argc, char **argv);
extern int import (int argc, char **argv);
extern int cvslog (int argc, char **argv);
#ifdef AUTH_CLIENT_SUPPORT
/* Some systems (namely Mac OS X) have conflicting definitions for these
 * functions.  Avoid them.
 */
#ifdef HAVE_LOGIN
# define login		cvs_login
#endif /* HAVE_LOGIN */
#ifdef HAVE_LOGOUT
# define logout		cvs_logout
#endif /* HAVE_LOGOUT */
extern int login (int argc, char **argv);
extern int logout (int argc, char **argv);
#endif /* AUTH_CLIENT_SUPPORT */
extern int patch (int argc, char **argv);
extern int release (int argc, char **argv);
extern int cvsremove (int argc, char **argv);
extern int rtag (int argc, char **argv);
extern int cvsstatus (int argc, char **argv);
extern int cvstag (int argc, char **argv);
extern int version (int argc, char **argv);

extern unsigned long int lookup_command_attribute (char *);

#if defined(AUTH_CLIENT_SUPPORT) || defined(AUTH_SERVER_SUPPORT)
char *scramble (char *str);
char *descramble (char *str);
#endif /* AUTH_CLIENT_SUPPORT || AUTH_SERVER_SUPPORT */

#ifdef AUTH_CLIENT_SUPPORT
char *get_cvs_password (void);
/* get_cvs_port_number() is not pure since the /etc/services file could change
 * between calls.  */
int get_cvs_port_number (const cvsroot_t *root);
/* normalize_cvsroot() is not pure since it calls get_cvs_port_number.  */
char *normalize_cvsroot (const cvsroot_t *root)
	__attribute__ ((__malloc__));
#endif /* AUTH_CLIENT_SUPPORT */

extern void tag_check_valid (char *, int, char **, int, int, char *);
extern void tag_check_valid_join (char *, int, char **, int, int,
					 char *);

#include "server.h"

/* From server.c and documented there.  */
extern void cvs_output (const char *, size_t);
extern void cvs_output_binary (char *, size_t);
extern void cvs_outerr (const char *, size_t);
extern void cvs_flusherr (void);
extern void cvs_flushout (void);
extern void cvs_output_tagged (char *, char *);

/* The trace function from subr.c */
void cvs_trace (int level, const char *fmt, ...)
  __attribute__ ((__format__ (__printf__, 2, 3)));
#define TRACE cvs_trace
/* Trace levels:
 *
 * TRACE_FUNCTION	Trace function calls, often including function
 * 			arguments.  This is the trace level that, historically,
 * 			applied to all trace calls.
 * TRACE_FLOW		Include the flow control functions, such as
 * 			start_recursion, do_recursion, and walklist in the
 * 			function traces.
 * TRACE_DATA		Trace important internal function data.
 */ 
#define TRACE_FUNCTION		1
#define TRACE_FLOW		2
#define TRACE_DATA		3
