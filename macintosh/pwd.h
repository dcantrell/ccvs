/*********************************************************************
Project	:	GUSI				-	Grand Unified Socket Interface
File		:	pwd.h			-	Provide mission header ioctl.h for CodeWarrior
Author	:	Matthias Neeracher
Language	:	MPW C/C++
$Log$
*********************************************************************/

#include <sys/types.h>

struct  group { /* see getgrent(3) */
        char    *gr_name;
        char    *gr_passwd;
        gid_t   gr_gid;
        char    **gr_mem;
};

struct passwd {
        char    *pw_name;
        char    *pw_passwd;
        uid_t   pw_uid;
        gid_t   pw_gid;
        char    *pw_age;
        char    *pw_comment;
        char    *pw_gecos;
        char    *pw_dir;
        char    *pw_shell;
};