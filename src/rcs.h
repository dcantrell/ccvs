/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * RCS source control definitions needed by rcs.c and friends
 */

#define	RCS		"rcs"
#define	RCS_CI		"ci"
#define	RCS_DIFF	"rcsdiff"
#define	RCS_RCSMERGE	"rcsmerge"

/* String which indicates a conflict if it occurs at the start of a line.  */
#define	RCS_MERGE_PAT ">>>>>>> "

#define	RCSEXT		",v"
#define RCSPAT		"*,v"
#define	RCSHEAD		"head"
#define	RCSBRANCH	"branch"
#define	RCSSYMBOLS	"symbols"
#define	RCSDATE		"date"
#define	RCSDESC		"desc"
#define RCSEXPAND	"expand"

/* Used by the version of death support which resulted from old
   versions of CVS (e.g. 1.5 if you define DEATH_SUPPORT and not
   DEATH_STATE).  Only a hacked up RCS (used by those old versions of
   CVS) will put this into RCS files.  Considered obsolete.  */
#define RCSDEAD		"dead"

#define	DATEFORM	"%02d.%02d.%02d.%02d.%02d.%02d"
#define	SDATEFORM	"%d.%d.%d.%d.%d.%d"

/*
 * Opaque structure definitions used by RCS specific lookup routines
 */
#define VALID	0x1			/* flags field contains valid data */
#define	INATTIC	0x2			/* RCS file is located in the Attic */
#define PARTIAL 0x4			/* RCS file not completly parsed */

/* All the "char *" fields in RCSNode, Deltatext, and RCSVers are
   '\0'-terminated (except "text" in Deltatext).  This means that we
   can't deal with fields containing '\0', which is a limitation that
   RCS does not have.  Would be nice to fix this some day.  */

struct rcsnode
{
    int refcount;
    int flags;

    /* File name of the RCS file.  This is not necessarily the name
       as specified by the user, but it is a name which can be passed to
       system calls and a name which is OK to print in error messages
       (the various names might differ in case).  */
    char *path;

    char *head;
    char *branch;
    char *symbols_data;
    char *expand;
    List *symbols;
    List *versions;
    char *access;
    char *locks_data;
    List *locks;
    int strict_locks;
    char *comment;
    char *desc;
    long delta_pos;
    List *other;
};

typedef struct rcsnode RCSNode;

struct deltatext {
    char *version;
    char *log;
    char *text;
    int len;
    /* Newphrase fields from deltatext nodes.  FIXME: duplicates the
       other field in the rcsversnode, I think.  */
    List *other;
};
typedef struct deltatext Deltatext;

struct rcsversnode
{
    char *version;
    char *date;
    char *author;
    char *state;
    char *next;
    int dead;
    int outdated;
    Deltatext *text;
    List *branches;
    /* Newphrase fields from deltatext nodes.  Also contains ";add" and
       ";delete" magic fields (see rcs.c, log.c).  I think this is
       only used by log.c (where it looks up "log").  Duplicates the
       other field in struct deltatext, I think.  */
    List *other;
    /* Newphrase fields from delta nodes.  */
    List *other_delta;
};
typedef struct rcsversnode RCSVers;

/*
 * CVS reserves all even-numbered branches for its own use.  "magic" branches
 * (see rcs.c) are contained as virtual revision numbers (within symbolic
 * tags only) off the RCS_MAGIC_BRANCH, which is 0.  CVS also reserves the
 * ".1" branch for vendor revisions.  So, if you do your own branching, you
 * should limit your use to odd branch numbers starting at 3.
 */
#define	RCS_MAGIC_BRANCH	0

/* The type of a function passed to RCS_checkout.  */
typedef void (*RCSCHECKOUTPROC) PROTO ((void *, const char *, size_t));

/*
 * exported interfaces
 */
RCSNode *RCS_parse PROTO((const char *file, const char *repos));
RCSNode *RCS_parsercsfile PROTO((char *rcsfile));
void RCS_fully_parse PROTO((RCSNode *));
char *RCS_check_kflag PROTO((const char *arg));
char *RCS_getdate PROTO((RCSNode * rcs, char *date, int force_tag_match));
char *RCS_gettag PROTO((RCSNode * rcs, char *symtag, int force_tag_match,
			int *simple_tag));
char *RCS_getversion PROTO((RCSNode * rcs, char *tag, char *date,
		      int force_tag_match, int *simple_tag));
char *RCS_magicrev PROTO((RCSNode *rcs, char *rev));
int RCS_isbranch PROTO((RCSNode *rcs, const char *rev));
int RCS_nodeisbranch PROTO((RCSNode *rcs, const char *tag));
char *RCS_whatbranch PROTO((RCSNode *rcs, const char *tag));
char *RCS_head PROTO((RCSNode * rcs));
int RCS_datecmp PROTO((char *date1, char *date2));
time_t RCS_getrevtime PROTO((RCSNode * rcs, char *rev, char *date, int fudge));
List *RCS_symbols PROTO((RCSNode *rcs));
void RCS_check_tag PROTO((const char *tag));
List *RCS_getlocks PROTO((RCSNode *rcs));
void freercsnode PROTO((RCSNode ** rnodep));
char *RCS_getbranch PROTO((RCSNode * rcs, char *tag, int force_tag_match));

int RCS_isdead PROTO((RCSNode *, const char *));
char *RCS_getexpand PROTO ((RCSNode *));
int RCS_checkout PROTO ((RCSNode *, char *, char *, char *, char *, char *,
			 RCSCHECKOUTPROC, void *));
int RCS_checkin PROTO ((RCSNode *rcs, char *workfile, char *message,
			char *rev, int flags));
int RCS_cmp_file PROTO ((RCSNode *, char *, char *, const char *));
int RCS_settag PROTO ((RCSNode *, const char *, const char *));
int RCS_deltag PROTO ((RCSNode *, const char *));
int RCS_setbranch PROTO((RCSNode *, const char *));
int RCS_lock PROTO ((RCSNode *, const char *, int));
int RCS_unlock PROTO ((RCSNode *, const char *, int));
int RCS_delete_revs PROTO ((RCSNode *, char *, char *));
void RCS_addaccess PROTO ((RCSNode *, char *));
void RCS_delaccess PROTO ((RCSNode *, char *));
char *RCS_getaccess PROTO ((RCSNode *));
void RCS_rewrite PROTO ((RCSNode *, Deltatext *, char *));
int rcs_change_text PROTO ((const char *, char *, size_t, const char *,
			    size_t, char **, size_t *));
char *make_file_label PROTO ((char *, char *, RCSNode *));

/* From import.c.  */
extern int add_rcs_file PROTO ((char *, char *, char *, char *, char *,
				char *, char *, int, char **,
				char *, size_t, FILE *));
