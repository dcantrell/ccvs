#include <io.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <fnmatch.h>


/* Expand wildcards in argv. */

void
os2_initialize (pargc, pargv)
    int *pargc;
    char **pargv[];
{
   _wildcard (pargc, pargv);
}


/* Modifies 'stat' so that always the same inode is returned. EMX never
   returns the same value for st_ino. Without this modification,
   release_delete in module src/release.c refuses to work. Care must
   be taken if someone is using the value of st_ino. for example, look at
   same_directories in src/root.c. (AFAIK this never gets called) */

int
os2_stat (name, buffer)
    const char *name;
    struct stat *buffer;
{
   int rc = stat (name, buffer);

   /* There are no inodes on OS/2. */
   buffer->st_ino = 42;

   return rc;
}


/* chdir must not only change the directory, but also the current drive.
   Otherwise it is be impossible to have the working directory and the
   repository on different drives. */

int
os2_chdir (name)
    const char *name;
{
   return _chdir2 (name);
}


/* getwd must return a drive specification. */

char *
os2_getwd (buffer)
    char *buffer;
{
   return _getcwd2 (buffer, MAXPATHLEN);
}


/* fnmatch must recognize OS/2 filename conventions: Filename case must be
   preserved, but ignored in searches. */

#define _FNM_OS2           1
#define _FNM_IGNORECASE    128

int
os2_fnmatch (pattern, name, flags)
    const char *pattern;
    const char *name;
    int flags;
{
   return fnmatch (pattern, name, _FNM_IGNORECASE|_FNM_OS2|flags);
}

