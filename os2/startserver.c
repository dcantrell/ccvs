/* startserver.c --- open a connection to the CVS server under OS/2
   Karl Fogel <kfogel@cyclic.com> --- August 1995  */

#include "cvs.h"
#include "rcmd.h"

#include <stdlib.h>
/* #include <winsock.h> */
#include <malloc.h>
#include <io.h>
#include <errno.h>


void
os2_start_server (int *tofd, int *fromfd,
		  char *client_user,
		  char *server_user,
		  char *server_host,
		  char *server_cvsroot)
{
    fprintf (stderr,
             "Error: os2_start_server() doesn't work.\n");
    exit (1);
}


void
os2_shutdown_server (int fd)
{
    fprintf (stderr,
             "Error: os2_start_server() doesn't work.\n");
    exit (1);
}
