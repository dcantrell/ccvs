# Microsoft Visual C++ Generated NMAKE File, Format Version 2.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=Win32 Debug
!MESSAGE No configuration specified.  Defaulting to Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "Win32 Release" && "$(CFG)" != "Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "cvsnt.mak" CFG="Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

################################################################################
# Begin Project
# PROP Target_Last_Scanned "Win32 Debug"
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "WinRel"
# PROP BASE Intermediate_Dir "WinRel"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
OUTDIR=.\WinRel
INTDIR=.\WinRel

ALL : $(OUTDIR)/"cvs.exe" $(OUTDIR)/"cvsnt.bsc"

$(OUTDIR) : 
    if not exist $(OUTDIR)/nul mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /YX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /W3 /GX /YX /Ob1 /I "windows-NT" /I "lib" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /FR /c
CPP_PROJ=/nologo /W3 /GX /YX /Ob1 /I "windows-NT" /I "lib" /D "WIN32" /D\
 "NDEBUG" /D "_CONSOLE" /FR$(INTDIR)/ /Fp$(OUTDIR)/"cvsnt.pch" /Fo$(INTDIR)/ /c 
CPP_OBJS=.\WinRel/
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"cvsnt.bsc" 
BSC32_SBRS= \
	$(INTDIR)/"subr.sbr" \
	$(INTDIR)/"admin.sbr" \
	$(INTDIR)/"server.sbr" \
	$(INTDIR)/"diff.sbr" \
	$(INTDIR)/"client.sbr" \
	$(INTDIR)/"checkout.sbr" \
	$(INTDIR)/"no_diff.sbr" \
	$(INTDIR)/"entries.sbr" \
	$(INTDIR)/"tag.sbr" \
	$(INTDIR)/"rtag.sbr" \
	$(INTDIR)/"mkmodules.sbr" \
	$(INTDIR)/"status.sbr" \
	$(INTDIR)/"root.sbr" \
	$(INTDIR)/"myndbm.sbr" \
	$(INTDIR)/"hash.sbr" \
	$(INTDIR)/"repos.sbr" \
	$(INTDIR)/"parseinfo.sbr" \
	$(INTDIR)/"vers_ts.sbr" \
	$(INTDIR)/"checkin.sbr" \
	$(INTDIR)/"commit.sbr" \
	$(INTDIR)/"version.sbr" \
	$(INTDIR)/"cvsrc.sbr" \
	$(INTDIR)/"remove.sbr" \
	$(INTDIR)/"update.sbr" \
	$(INTDIR)/"logmsg.sbr" \
	$(INTDIR)/"classify.sbr" \
	$(INTDIR)/"history.sbr" \
	$(INTDIR)/"add.sbr" \
	$(INTDIR)/"lock.sbr" \
	$(INTDIR)/"recurse.sbr" \
	$(INTDIR)/"modules.sbr" \
	$(INTDIR)/"find_names.sbr" \
	$(INTDIR)/"rcs.sbr" \
	$(INTDIR)/"create_adm.sbr" \
	$(INTDIR)/"main.sbr" \
	$(INTDIR)/"patch.sbr" \
	$(INTDIR)/"release.sbr" \
	$(INTDIR)/"rcscmds.sbr" \
	$(INTDIR)/"import.sbr" \
	$(INTDIR)/"ignore.sbr" \
	$(INTDIR)/"log.sbr" \
	$(INTDIR)/"getwd.sbr" \
	$(INTDIR)/"strerror.sbr" \
	$(INTDIR)/"error.sbr" \
	$(INTDIR)/"mkdir.sbr" \
	$(INTDIR)/"strippath.sbr" \
	$(INTDIR)/"waitpid.sbr" \
	$(INTDIR)/"rename.sbr" \
	$(INTDIR)/"dup2.sbr" \
	$(INTDIR)/"sighandle.sbr" \
	$(INTDIR)/"getopt.sbr" \
	$(INTDIR)/"strdup.sbr" \
	$(INTDIR)/"argmatch.sbr" \
	$(INTDIR)/"memmove.sbr" \
	$(INTDIR)/"ftruncate.sbr" \
	$(INTDIR)/"md5.sbr" \
	$(INTDIR)/"yesno.sbr" \
	$(INTDIR)/"stripslash.sbr" \
	$(INTDIR)/"getopt1.sbr" \
	$(INTDIR)/"alloca.sbr" \
	$(INTDIR)/"valloc.sbr" \
	$(INTDIR)/"xgetwd.sbr" \
	$(INTDIR)/"regex.sbr" \
	$(INTDIR)/"hostname.sbr" \
	$(INTDIR)/"fnmatch.sbr"

$(OUTDIR)/"cvsnt.bsc" : $(OUTDIR)  $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /NOLOGO /SUBSYSTEM:console /MACHINE:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /NOLOGO /SUBSYSTEM:console /MACHINE:I386 /OUT:"WinRel/cvs.exe"
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /NOLOGO /SUBSYSTEM:console /INCREMENTAL:no\
 /PDB:$(OUTDIR)/"cvsnt.pdb" /MACHINE:I386 /OUT:"WinRel/cvs.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/"subr.obj" \
	$(INTDIR)/"admin.obj" \
	$(INTDIR)/"server.obj" \
	$(INTDIR)/"diff.obj" \
	$(INTDIR)/"client.obj" \
	$(INTDIR)/"checkout.obj" \
	$(INTDIR)/"no_diff.obj" \
	$(INTDIR)/"entries.obj" \
	$(INTDIR)/"tag.obj" \
	$(INTDIR)/"rtag.obj" \
	$(INTDIR)/"mkmodules.obj" \
	$(INTDIR)/"status.obj" \
	$(INTDIR)/"root.obj" \
	$(INTDIR)/"myndbm.obj" \
	$(INTDIR)/"hash.obj" \
	$(INTDIR)/"repos.obj" \
	$(INTDIR)/"parseinfo.obj" \
	$(INTDIR)/"vers_ts.obj" \
	$(INTDIR)/"checkin.obj" \
	$(INTDIR)/"commit.obj" \
	$(INTDIR)/"version.obj" \
	$(INTDIR)/"cvsrc.obj" \
	$(INTDIR)/"remove.obj" \
	$(INTDIR)/"update.obj" \
	$(INTDIR)/"logmsg.obj" \
	$(INTDIR)/"classify.obj" \
	$(INTDIR)/"history.obj" \
	$(INTDIR)/"add.obj" \
	$(INTDIR)/"lock.obj" \
	$(INTDIR)/"recurse.obj" \
	$(INTDIR)/"modules.obj" \
	$(INTDIR)/"find_names.obj" \
	$(INTDIR)/"rcs.obj" \
	$(INTDIR)/"create_adm.obj" \
	$(INTDIR)/"main.obj" \
	$(INTDIR)/"patch.obj" \
	$(INTDIR)/"release.obj" \
	$(INTDIR)/"rcscmds.obj" \
	$(INTDIR)/"import.obj" \
	$(INTDIR)/"ignore.obj" \
	$(INTDIR)/"log.obj" \
	$(INTDIR)/"getwd.obj" \
	$(INTDIR)/"strerror.obj" \
	$(INTDIR)/"error.obj" \
	$(INTDIR)/"mkdir.obj" \
	$(INTDIR)/"strippath.obj" \
	$(INTDIR)/"waitpid.obj" \
	$(INTDIR)/"rename.obj" \
	$(INTDIR)/"dup2.obj" \
	$(INTDIR)/"sighandle.obj" \
	$(INTDIR)/"getopt.obj" \
	$(INTDIR)/"strdup.obj" \
	$(INTDIR)/"argmatch.obj" \
	$(INTDIR)/"memmove.obj" \
	$(INTDIR)/"ftruncate.obj" \
	$(INTDIR)/"md5.obj" \
	$(INTDIR)/"yesno.obj" \
	$(INTDIR)/"stripslash.obj" \
	$(INTDIR)/"getopt1.obj" \
	$(INTDIR)/"alloca.obj" \
	$(INTDIR)/"valloc.obj" \
	$(INTDIR)/"xgetwd.obj" \
	$(INTDIR)/"regex.obj" \
	$(INTDIR)/"hostname.obj" \
	$(INTDIR)/"fnmatch.obj"

$(OUTDIR)/"cvs.exe" : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "WinDebug"
# PROP BASE Intermediate_Dir "WinDebug"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "WinDebug"
# PROP Intermediate_Dir "WinDebug"
OUTDIR=.\WinDebug
INTDIR=.\WinDebug

ALL : $(OUTDIR)/"cvs.exe" $(OUTDIR)/"cvsnt.bsc"

$(OUTDIR) : 
    if not exist $(OUTDIR)/nul mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /W3 /GX /Zi /YX /Ob1 /I "windows-NT" /I "lib" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /FR /c
CPP_PROJ=/nologo /W3 /GX /Zi /YX /Ob1 /I "windows-NT" /I "lib" /D "WIN32" /D\
 "_DEBUG" /D "_CONSOLE" /FR$(INTDIR)/ /Fp$(OUTDIR)/"cvsnt.pch" /Fo$(INTDIR)/\
 /Fd$(OUTDIR)/"cvsnt.pdb" /c 
CPP_OBJS=.\WinDebug/
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"cvsnt.bsc" 
BSC32_SBRS= \
	$(INTDIR)/"subr.sbr" \
	$(INTDIR)/"admin.sbr" \
	$(INTDIR)/"server.sbr" \
	$(INTDIR)/"diff.sbr" \
	$(INTDIR)/"client.sbr" \
	$(INTDIR)/"checkout.sbr" \
	$(INTDIR)/"no_diff.sbr" \
	$(INTDIR)/"entries.sbr" \
	$(INTDIR)/"tag.sbr" \
	$(INTDIR)/"rtag.sbr" \
	$(INTDIR)/"mkmodules.sbr" \
	$(INTDIR)/"status.sbr" \
	$(INTDIR)/"root.sbr" \
	$(INTDIR)/"myndbm.sbr" \
	$(INTDIR)/"hash.sbr" \
	$(INTDIR)/"repos.sbr" \
	$(INTDIR)/"parseinfo.sbr" \
	$(INTDIR)/"vers_ts.sbr" \
	$(INTDIR)/"checkin.sbr" \
	$(INTDIR)/"commit.sbr" \
	$(INTDIR)/"version.sbr" \
	$(INTDIR)/"cvsrc.sbr" \
	$(INTDIR)/"remove.sbr" \
	$(INTDIR)/"update.sbr" \
	$(INTDIR)/"logmsg.sbr" \
	$(INTDIR)/"classify.sbr" \
	$(INTDIR)/"history.sbr" \
	$(INTDIR)/"add.sbr" \
	$(INTDIR)/"lock.sbr" \
	$(INTDIR)/"recurse.sbr" \
	$(INTDIR)/"modules.sbr" \
	$(INTDIR)/"find_names.sbr" \
	$(INTDIR)/"rcs.sbr" \
	$(INTDIR)/"create_adm.sbr" \
	$(INTDIR)/"main.sbr" \
	$(INTDIR)/"patch.sbr" \
	$(INTDIR)/"release.sbr" \
	$(INTDIR)/"rcscmds.sbr" \
	$(INTDIR)/"import.sbr" \
	$(INTDIR)/"ignore.sbr" \
	$(INTDIR)/"log.sbr" \
	$(INTDIR)/"getwd.sbr" \
	$(INTDIR)/"strerror.sbr" \
	$(INTDIR)/"error.sbr" \
	$(INTDIR)/"mkdir.sbr" \
	$(INTDIR)/"strippath.sbr" \
	$(INTDIR)/"waitpid.sbr" \
	$(INTDIR)/"rename.sbr" \
	$(INTDIR)/"dup2.sbr" \
	$(INTDIR)/"sighandle.sbr" \
	$(INTDIR)/"getopt.sbr" \
	$(INTDIR)/"strdup.sbr" \
	$(INTDIR)/"argmatch.sbr" \
	$(INTDIR)/"memmove.sbr" \
	$(INTDIR)/"ftruncate.sbr" \
	$(INTDIR)/"md5.sbr" \
	$(INTDIR)/"yesno.sbr" \
	$(INTDIR)/"stripslash.sbr" \
	$(INTDIR)/"getopt1.sbr" \
	$(INTDIR)/"alloca.sbr" \
	$(INTDIR)/"valloc.sbr" \
	$(INTDIR)/"xgetwd.sbr" \
	$(INTDIR)/"regex.sbr" \
	$(INTDIR)/"hostname.sbr" \
	$(INTDIR)/"fnmatch.sbr"

$(OUTDIR)/"cvsnt.bsc" : $(OUTDIR)  $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /NOLOGO /SUBSYSTEM:console /DEBUG /MACHINE:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /NOLOGO /SUBSYSTEM:console /DEBUG /MACHINE:I386 /OUT:"WinDebug/cvs.exe"
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /NOLOGO /SUBSYSTEM:console /INCREMENTAL:yes\
 /PDB:$(OUTDIR)/"cvsnt.pdb" /DEBUG /MACHINE:I386 /OUT:"WinDebug/cvs.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/"subr.obj" \
	$(INTDIR)/"admin.obj" \
	$(INTDIR)/"server.obj" \
	$(INTDIR)/"diff.obj" \
	$(INTDIR)/"client.obj" \
	$(INTDIR)/"checkout.obj" \
	$(INTDIR)/"no_diff.obj" \
	$(INTDIR)/"entries.obj" \
	$(INTDIR)/"tag.obj" \
	$(INTDIR)/"rtag.obj" \
	$(INTDIR)/"mkmodules.obj" \
	$(INTDIR)/"status.obj" \
	$(INTDIR)/"root.obj" \
	$(INTDIR)/"myndbm.obj" \
	$(INTDIR)/"hash.obj" \
	$(INTDIR)/"repos.obj" \
	$(INTDIR)/"parseinfo.obj" \
	$(INTDIR)/"vers_ts.obj" \
	$(INTDIR)/"checkin.obj" \
	$(INTDIR)/"commit.obj" \
	$(INTDIR)/"version.obj" \
	$(INTDIR)/"cvsrc.obj" \
	$(INTDIR)/"remove.obj" \
	$(INTDIR)/"update.obj" \
	$(INTDIR)/"logmsg.obj" \
	$(INTDIR)/"classify.obj" \
	$(INTDIR)/"history.obj" \
	$(INTDIR)/"add.obj" \
	$(INTDIR)/"lock.obj" \
	$(INTDIR)/"recurse.obj" \
	$(INTDIR)/"modules.obj" \
	$(INTDIR)/"find_names.obj" \
	$(INTDIR)/"rcs.obj" \
	$(INTDIR)/"create_adm.obj" \
	$(INTDIR)/"main.obj" \
	$(INTDIR)/"patch.obj" \
	$(INTDIR)/"release.obj" \
	$(INTDIR)/"rcscmds.obj" \
	$(INTDIR)/"import.obj" \
	$(INTDIR)/"ignore.obj" \
	$(INTDIR)/"log.obj" \
	$(INTDIR)/"getwd.obj" \
	$(INTDIR)/"strerror.obj" \
	$(INTDIR)/"error.obj" \
	$(INTDIR)/"mkdir.obj" \
	$(INTDIR)/"strippath.obj" \
	$(INTDIR)/"waitpid.obj" \
	$(INTDIR)/"rename.obj" \
	$(INTDIR)/"dup2.obj" \
	$(INTDIR)/"sighandle.obj" \
	$(INTDIR)/"getopt.obj" \
	$(INTDIR)/"strdup.obj" \
	$(INTDIR)/"argmatch.obj" \
	$(INTDIR)/"memmove.obj" \
	$(INTDIR)/"ftruncate.obj" \
	$(INTDIR)/"md5.obj" \
	$(INTDIR)/"yesno.obj" \
	$(INTDIR)/"stripslash.obj" \
	$(INTDIR)/"getopt1.obj" \
	$(INTDIR)/"alloca.obj" \
	$(INTDIR)/"valloc.obj" \
	$(INTDIR)/"xgetwd.obj" \
	$(INTDIR)/"regex.obj" \
	$(INTDIR)/"hostname.obj" \
	$(INTDIR)/"fnmatch.obj"

$(OUTDIR)/"cvs.exe" : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Group "src"

################################################################################
# Begin Source File

SOURCE=.\src\subr.c

$(INTDIR)/"subr.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\admin.c

$(INTDIR)/"admin.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\server.c
DEP_SERVE=\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\server.h"\
	".\src\client.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"

$(INTDIR)/"server.obj" :  $(SOURCE)  $(DEP_SERVE) $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\diff.c

$(INTDIR)/"diff.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\client.c

$(INTDIR)/"client.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\checkout.c

$(INTDIR)/"checkout.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\no_diff.c

$(INTDIR)/"no_diff.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\entries.c

$(INTDIR)/"entries.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\tag.c

$(INTDIR)/"tag.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\rtag.c

$(INTDIR)/"rtag.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\mkmodules.c

$(INTDIR)/"mkmodules.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\status.c

$(INTDIR)/"status.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\root.c

$(INTDIR)/"root.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\myndbm.c

$(INTDIR)/"myndbm.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\hash.c

$(INTDIR)/"hash.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\repos.c

$(INTDIR)/"repos.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\parseinfo.c

$(INTDIR)/"parseinfo.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\vers_ts.c

$(INTDIR)/"vers_ts.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\checkin.c

$(INTDIR)/"checkin.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\commit.c

$(INTDIR)/"commit.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\version.c

$(INTDIR)/"version.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\cvsrc.c

$(INTDIR)/"cvsrc.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\remove.c

$(INTDIR)/"remove.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\update.c

$(INTDIR)/"update.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\logmsg.c

$(INTDIR)/"logmsg.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\classify.c

$(INTDIR)/"classify.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\history.c

$(INTDIR)/"history.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\add.c

$(INTDIR)/"add.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\lock.c

$(INTDIR)/"lock.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\recurse.c

$(INTDIR)/"recurse.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\modules.c

$(INTDIR)/"modules.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\find_names.c

$(INTDIR)/"find_names.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\rcs.c

$(INTDIR)/"rcs.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\create_adm.c

$(INTDIR)/"create_adm.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\main.c

$(INTDIR)/"main.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\patch.c

$(INTDIR)/"patch.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\release.c

$(INTDIR)/"release.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\rcscmds.c

$(INTDIR)/"rcscmds.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\import.c

$(INTDIR)/"import.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\ignore.c

$(INTDIR)/"ignore.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\src\log.c

$(INTDIR)/"log.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
# End Group
################################################################################
# Begin Group "lib"

################################################################################
# Begin Source File

SOURCE=.\lib\getwd.c

$(INTDIR)/"getwd.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\strerror.c

$(INTDIR)/"strerror.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\error.c

$(INTDIR)/"error.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\mkdir.c

$(INTDIR)/"mkdir.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\strippath.c

$(INTDIR)/"strippath.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\waitpid.c

$(INTDIR)/"waitpid.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\rename.c

$(INTDIR)/"rename.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\dup2.c

$(INTDIR)/"dup2.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\sighandle.c

$(INTDIR)/"sighandle.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\getopt.c

$(INTDIR)/"getopt.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\strdup.c

$(INTDIR)/"strdup.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\argmatch.c

$(INTDIR)/"argmatch.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\memmove.c

$(INTDIR)/"memmove.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\ftruncate.c

$(INTDIR)/"ftruncate.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\md5.c

$(INTDIR)/"md5.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\yesno.c

$(INTDIR)/"yesno.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\stripslash.c

$(INTDIR)/"stripslash.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\getopt1.c

$(INTDIR)/"getopt1.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\alloca.c

$(INTDIR)/"alloca.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\valloc.c

$(INTDIR)/"valloc.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\xgetwd.c

$(INTDIR)/"xgetwd.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\regex.c

$(INTDIR)/"regex.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\hostname.c

$(INTDIR)/"hostname.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\lib\fnmatch.c

$(INTDIR)/"fnmatch.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
# End Group
# End Project
################################################################################
