#include <stdio.h>
#include <string.h>
#include "cvs.h"

/* This is for debugging on beezley. */
/* #define HARDCODED_PASSWD "" */
#undef HARDCODED_PASSWD

char *
getpass (char *prompt)
{
#ifndef HARDCODED_PASSWD
	static char passbuf[1024];
	char *p;

	printf ("%s", prompt);
	fflush (stdout);

	fgets (passbuf, 1023, stdin);
	p = strchr (passbuf, '\n');

	if (p == NULL)
		error (1, 0, "password oddity -- where is the newline?");

	*p = '\0';
	return passbuf;
#else /* HARDCODED_PASSWD */
	printf ("Sending hardcoded password.\n");
	fflush (stdout);
	return HARDCODED_PASSWD;
#endif /* ! HARDCODED_PASSWD */
}
