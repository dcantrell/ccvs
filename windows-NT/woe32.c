/*
 * woe32.c
 * - utility functions for cvs under win32
 *
 */

#include "config.h"

#include "woe32.h"

#include <stdio.h>
#include <conio.h>

#define WIN32_LEAN_AND_MEAN
#include <winsock.h>  /* This does: #include <windows.h> */

#include <stdlib.h>



/* #define SYSTEM_INITIALIZE(pargc,pargv) woe32_init_winsock() */
void
woe32_init_winsock (void)
{
    WSADATA data;

    if (WSAStartup (MAKEWORD (1, 1), &data))
    {
	fprintf (stderr, "cvs: unable to initialize winsock\n");
	exit (1);
    }
}



/* #define SYSTEM_CLEANUP woe32_cleanup */
void
woe32_cleanup (void)
{
    if (WSACleanup ())
    {
#ifdef SERVER_ACTIVE
	if (server_active || error_use_protocol)
	    /* FIXME: how are we supposed to report errors?  As of now
	       (Sep 98), error() can in turn call us (if it is out of
	       memory) and in general is built on top of lots of
	       stuff.  */
	    ;
	else
#endif
	    fprintf (stderr, "cvs: cannot WSACleanup: %s\n",
		     sock_strerror (WSAGetLastError ()));
    }
}



/*
 * Sleep at least some number of microseconds, specified with nanosecond
 * resolution and rounding up to the nearest microsecond.
 */
static int
my_usleep (const struct timespec *ts_delay)
{
    struct timeval tv_delay;
    tv_delay.tv_sec = ts_delay->tv_sec;
    tv_delay.tv_usec = ts_delay->tv_nsec / 1000
		       + (ts_delay->tv_nsec % 1000 ? 1 : 0);
    return select (0, (void *) 0, (void *) 0, (void *) 0, &tv_delay);
}



/* #define nanosleep woe32_nanosleep */
int
woe32_nanosleep (const struct timespec *requested_delay,
                       struct timespec *remaining_delay)
{
    return my_usleep (requested_delay);
}



char *
woe32_getlogin (void)
{
    static char name[256];
    DWORD dw = sizeof (name);
    GetUserName (name, &dw);
    if (name[0] == '\0')
	return NULL;
    else
	return name;
}
