/*
 * Copyright (c) 1989-2003 Free Software Foundation
 * Copyright (c) 2003 Derek R. Price & Ximbiot <http://ximbiot.com>
 * Copyright (c) 2003 Alexey Mahotkin
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 *
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS kit.
 *
 */

#ifndef PROTO_H
#define PROTO_H

/* Add prototype support as per AC_C_PROTOTYPES documentation.  */
#ifndef PROTO
# if PROTOTYPES
#  define PROTO(ARGS) ARGS
# else
#  define PROTO(ARGS) ()
# endif
#endif

#endif
