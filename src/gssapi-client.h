/* CVS GSSAPI client stuff.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.  */


#ifndef GSSAPI_CLIENT_H__
#define GSSAPI_CLIENT_H__

#include "xgssapi.h"

#include "socket-client.h"

/* Set this to turn on GSSAPI encryption.  */
extern int cvs_gssapi_encrypt;

extern gss_ctx_id_t gcontext;

/* We can't declare the arguments without including gssapi.h, and I
   don't want to do that in every file.  */
struct buffer* cvs_gssapi_wrap_buffer_initialize PROTO((struct buffer *buf,
							int input,
							gss_ctx_id_t gcontext,
							void (*memory) PROTO((struct buffer *))));

int connect_to_gserver PROTO((cvsroot_t *, int, struct hostent *));

extern void initialize_gssapi_buffers PROTO((struct buffer **to_server_p,
					     struct buffer **from_server_p));

#endif
