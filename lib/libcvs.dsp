# Microsoft Developer Studio Project File - Name="libcvs" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libcvs - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libcvs.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libcvs.mak" CFG="libcvs - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libcvs - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libcvs - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libcvs - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "WinRel"
# PROP BASE Intermediate_Dir "WinRel"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "..\windows-NT" /I "." /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "WinDebug"
# PROP BASE Intermediate_Dir "WinDebug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "WinDebug"
# PROP Intermediate_Dir "WinDebug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /I "..\windows-NT" /I "." /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "libcvs - Win32 Release"
# Name "libcvs - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\exitfail.c
# End Source File
# Begin Source File

SOURCE=.\getdate.c
# End Source File
# Begin Source File

SOURCE=.\getline.c
# End Source File
# Begin Source File

SOURCE=.\getndelim2.c
# End Source File
# Begin Source File

SOURCE=.\getopt.c
# End Source File
# Begin Source File

SOURCE=.\getopt1.c
# End Source File
# Begin Source File

SOURCE=".\printf-args.c"
# End Source File
# Begin Source File

SOURCE=".\printf-parse.c"
# End Source File
# Begin Source File

SOURCE=.\realloc.c
# End Source File
# Begin Source File

SOURCE=.\regex.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\alloca_.h

!IF  "$(CFG)" == "libcvs - Win32 Release"

# Begin Custom Build
InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\alloca_.h .\alloca.h

# End Custom Build

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

# Begin Custom Build
InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\alloca_.h .\alloca.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\windows-NT\config.h"
# End Source File
# Begin Source File

SOURCE=.\fnmatch_.h

!IF  "$(CFG)" == "libcvs - Win32 Release"

# Begin Custom Build
InputPath=.\fnmatch_.h

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\fnmatch_.h .\fnmatch.h

# End Custom Build

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

# Begin Custom Build
InputPath=.\fnmatch_.h

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\fnmatch_.h .\fnmatch.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\regex.h
# End Source File
# End Group
# End Target
# End Project
