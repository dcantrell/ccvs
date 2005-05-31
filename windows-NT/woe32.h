/*
 * woe32.h
 * - utility functions for cvs under win32
 *
 */

#ifndef WOE32_H
#define WOE32_H

#include <timespec.h>

/* #define SYSTEM_CLEANUP woe32_cleanup */
void woe32_cleanup (void);

char *woe32_getlogin (void);

/* #define SYSTEM_INITIALIZE(pargc,pargv) woe32_init_winsock() */
void woe32_init_winsock (void);

/* #define nanosleep woe32_nanosleep */
int woe32_nanosleep (const struct timespec *requested_delay,
                           struct timespec *remaining_delay);

#endif /* WOE32_H */
