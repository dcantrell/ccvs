#include "pwd.h"
#include <stdio.h>
#include <unixlib.h>

static struct passwd pw;

/* This is only called from one relevant place, lock.c.  In that context
   the code is really trying to figure out who owns a directory.  Nothing
   which has anything to do with getpwuid or anything of the sort can help
   us on VMS (getuid returns only the group part of the UIC).  */
struct passwd *getpwuid(unsigned int uid)
{
    return NULL;
}

struct passwd *getpwnam(char *name)
{
    /* This will lead expand_path() to complain about "no such user"
       anytime someone tries to use ~user.  That is better than giving
       some bogus answer.  expand_path is the only relevant call to
       this function.  */
    return NULL;
}

char *getlogin()
{
  static char login[256];
  return cuserid(login);
} 
