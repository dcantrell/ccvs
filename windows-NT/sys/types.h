/*
 * windows-NT/sys/types.h
 */

#ifdef _MSC_VER

#pragma once

/* Compatable with Visual C++ 6.0 - cl.exe 12.00 */
#if _MSC_VER != 1200
#pragma message ( "Please email Microsoft's <sys/types.h>" )
#pragma message ( "file to <conradpino@cvshome.org>" )
#endif /* _MSC_VER != 1200 */

/***************************************************************************/
/* Mimic what Micrsoft defines in their <sys/types.h> */
#ifndef _INC_TYPES
#define _INC_TYPES



/* Define time_t */
#ifndef _TIME_T_DEFINED
#define _TIME_T_DEFINED

typedef long time_t;
#endif /* _TIME_T_DEFINED */



/* Define ino_t */
#ifndef _INO_T_DEFINED
#define _INO_T_DEFINED

typedef unsigned short ino_t;

/* Microsoft uses _ino_t */
typedef ino_t _ino_t;
#endif /* _INO_T_DEFINED */



/* Define dev_t */
#ifndef _DEV_T_DEFINED
#define _DEV_T_DEFINED

typedef unsigned int dev_t;

/* Microsoft uses _dev_t */
typedef dev_t _dev_t;
#endif /* _DEV_T_DEFINED */



/* Define off_t */
#ifndef _OFF_T_DEFINED
#define _OFF_T_DEFINED

typedef long off_t;

/* Microsoft uses _off_t */
typedef off_t _off_t;
#endif /* _OFF_T_DEFINED */
#endif  /* _INC_TYPES */

/***************************************************************************/
/* define what Micrsoft doesn't */
typedef int gid_t;
typedef int pid_t;
typedef int uid_t;

typedef unsigned int useconds_t;
/***************************************************************************/

#else /* _MSC_VER */
#error This file is for use with Microsoft compilers only.
#endif /* _MSC_VER */
