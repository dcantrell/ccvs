# Microsoft Developer Studio Project File - Name="cvsnt" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=cvsnt - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "cvsnt.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "cvsnt.mak" CFG="cvsnt - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "cvsnt - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "cvsnt - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
# PROP Ignore_Export_Lib 0
# ADD BASE CPP /nologo /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /YX /FD /c
# SUBTRACT BASE CPP /WX /Fr
# ADD CPP /nologo /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /YX /FD /c
# SUBTRACT CPP /WX /Fr
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\Release\zlib.lib diff\Release\libdiff.lib /nologo /subsystem:console /machine:I386 /out:".\Release\cvs.exe"
# ADD LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\WinRel\zlib.lib diff\WinRel\libdiff.lib /nologo /subsystem:console /machine:I386 /nodefaultlib:"libcmtd.lib" /out:".\WinRel\cvs.exe"
# SUBTRACT LINK32 /nodefaultlib

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "WinDebug"
# PROP Intermediate_Dir "WinDebug"
# PROP Ignore_Export_Lib 0
# ADD BASE CPP /nologo /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /YX /FD /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\Debug\zlib.lib diff\Debug\libdiff.lib /nologo /subsystem:console /pdb:".\Debug\cvs.pdb" /debug /machine:I386 /out:".\Debug\cvs.exe"
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\WinDebug\zlib.lib diff\WinDebug\libdiff.lib  lib\WinDebug\libcvs.lib /nologo /subsystem:console /pdb:".\WinDebug\cvs.pdb" /debug /machine:I386 /nodefaultlib:"libcmtd.lib" /out:".\WinDebug\cvs.exe"
# SUBTRACT LINK32 /pdb:none /nodefaultlib

!ENDIF 

# Begin Target

# Name "cvsnt - Win32 Release"
# Name "cvsnt - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;hpj;bat;for;f90"
# Begin Source File

SOURCE=.\src\add.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\admin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\annotate.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\argmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\asnprintf.c
# End Source File
# Begin Source File

SOURCE=.\src\buffer.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\checkin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\checkout.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\classify.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\client.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\commit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\create_adm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\cvsrc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\edit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\entries.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\error.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\exithandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\expand_path.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\fileattr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\filesubr.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\find_names.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\fncase.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\fnmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\fseeko.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\ftello.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\hash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\history.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\ignore.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\import.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\lock.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\log-buffer.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\log.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\login.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\logmsg.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\main.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\md5.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\mkdir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\mkmodules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\modules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\myndbm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\ndir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\no_diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\parseinfo.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\patch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\pwd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\rcmd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\rcs.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\rcscmds.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\recurse.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\release.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\remove.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\repos.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\root.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\rsh-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\run.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\savecwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\scramble.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\server.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\sighandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\sockerror.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\socket-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\stack.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\startserver.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\status.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\stripslash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\subr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\tag.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\update.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\valloc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\vasnprintf.c
# End Source File
# Begin Source File

SOURCE=.\src\vers_ts.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\version.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\waitpid.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\watch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\woe32.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\wrapper.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\xgetwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\xmalloc.c
# End Source File
# Begin Source File

SOURCE=.\lib\xstrdup.c
# End Source File
# Begin Source File

SOURCE=.\lib\yesno.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\zlib.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "WinRel"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl;fi;fd"
# Begin Source File

SOURCE=.\lib\alloca.h
# End Source File
# Begin Source File

SOURCE=.\src\buffer.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\client.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\config.h"
# End Source File
# Begin Source File

SOURCE=.\zlib\deflate.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\edit.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\exitfail.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\fileattr.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\fnmatch.h
# End Source File
# Begin Source File

SOURCE=.\lib\getline.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\getopt.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\hash.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\infblock.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\infcodes.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\inffast.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\inftrees.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\infutil.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\log-buffer.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\md5.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\myndbm.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\ndir.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\lib\printf-args.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\lib\printf-parse.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\pwd.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\windows-NT\rcmd.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\rcs.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\regex.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\rsh-client.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\savecwd.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\server.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=".\src\socket-client.h"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\stack.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\update.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lib\vasnprintf.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\watch.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zlib\zutil.h

!IF  "$(CFG)" == "cvsnt - Win32 Release"

# PROP Intermediate_Dir "Release"

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# End Group
# End Target
# End Project
