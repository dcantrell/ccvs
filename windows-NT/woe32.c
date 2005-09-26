/*
 * Copyright (C) 2003-2005 The Free Software Foundation, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

/*
 * woe32.c
 * - utility functions for cvs under win32
 *
 */

#include "config.h"

#include "woe32.h"

#include <stdio.h>
#include <conio.h>

#include <sys/socket.h>  /* This does: #include <windows.h> */

#include <stdlib.h>
#include <unistd.h>
#include <xalloc.h>



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



char *
woe32_home_dir (void)
{
    static char *home_dir = NULL;
    char *home_drive, *home_path;

    if (home_dir)
	return home_dir;
    
    if ((home_drive = getenv ("HOMEDRIVE")) && (home_path = getenv ("HOMEPATH")))
    {
	const char NUL = '\0';
	size_t home_drive_len, home_path_len;

	home_drive_len = strlen (home_drive);
	home_path_len  = strlen (home_path);

	home_dir = xmalloc (home_drive_len + home_path_len + sizeof NUL);

	memcpy (home_dir,                  home_drive, home_drive_len );
	memcpy (home_dir + home_drive_len, home_path,  home_path_len  );
	home_dir[ home_drive_len + home_path_len ] = NUL;

	return home_dir;
    }

    return NULL;
}



/* #define nanosleep woe32_nanosleep */
int
woe32_nanosleep (const struct timespec *requested_delay,
                       struct timespec *remaining_delay)
{
    const useconds_t one_second = 1000000;
    const useconds_t nano_per_micro = 1000;
    useconds_t micro_delay;

    micro_delay = requested_delay->tv_sec * one_second
		+ ( requested_delay->tv_nsec + nano_per_micro - 1 ) / nano_per_micro
		;

    return usleep (micro_delay);
}



char *
woe32_shell (void)
{
    char *shell;

    shell = getenv ("ComSpec");

    if (shell == NULL)
    {
	/* Windows always sets ComSpec, the user is messing with us */
	const char *os;

	if ((os = getenv ("OS")) && strcmp (os, "Windows_NT"))
	    /* Windows NT, Windows 2000, Windows XP, Windows 2003 */
	    shell = "cmd.exe";
	else
	    /* Windows 95, Windows 98, Windows Me */
	    shell = "command.com";
    }

    return shell;
}
