/*
 * mac_init.c --- routines to initialize and cleanup macintosh behavior
 *
 * MDLadwig <mike@twinpeaks.prc.com> --- June 1996
 */
 
#ifdef __POWERPC__
#include <MacHeadersPPC>
#else
#include <MacHeaders68K>
#endif

#include <sioux.h>
#include <GUSI.h>

extern char **Args;
extern char **EnvVars, **EnvVals;
extern int ArgC;
extern int EnvC;

extern int argc;
extern char **argv;

void
macos_error_cleanup( void )
{
	Lock_Cleanup();
	RemoveConsole();		// FOOFOOFOO - Ugly, but necessary until MW fixes _exit
}

void
InitializeMacToolbox( void )
{
	InitGraf((Ptr) &qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();
	
	#ifndef __POWERPC__
	SetApplLimit(GetApplLimit() - 98305);
	#endif
	
	MaxApplZone();
	MoreMasters();
}

void
MacOS_Initialize( int *argc, char ***argv )
{
	InitializeMacToolbox();
	
	GUSISetup(GUSIwithSIOUXSockets);
	GUSISetup(GUSIwithUnixSockets);

	SIOUXSettings.showstatusline = TRUE;
	SIOUXSettings.autocloseonquit = FALSE;
	SIOUXSettings.asktosaveonclose = TRUE;
	
	GetUnixCommandEnvironment( "cvs" );
	
	if( ArgC == 1 )
		*argc = ccommand(argv);
	else
	{
		*argc = ArgC;
		*argv = Args;
	}
	
	error_set_cleanup (macos_error_cleanup);
}

void
MacOS_Cleanup ( void )
{
	RemoveConsole();		// FOOFOOFOO - Ugly, but necessary until MW fixes _exit
}

