# Microsoft Developer Studio Generated NMAKE File, Based on cvsnt.dsp
!IF "$(CFG)" == ""
CFG=cvsnt - Win32 Release
!MESSAGE No configuration specified. Defaulting to cvsnt - Win32 Release.
!ENDIF 

!IF "$(CFG)" != "cvsnt - Win32 Release" && "$(CFG)" != "cvsnt - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "cvsnt.mak" CFG="cvsnt - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "cvsnt - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "cvsnt - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "cvsnt - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\cvs.exe"

!ELSE 

ALL : "zlib - Win32 Release" "libdiff - Win32 Release" "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 ReleaseCLEAN" "zlib - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\getopt.obj"
	-@erase "$(INTDIR)\getopt1.obj"
	-@erase "$(INTDIR)\md5.obj"
	-@erase "$(INTDIR)\pwd.obj"
	-@erase "$(INTDIR)\savecwd.obj"
	-@erase "$(INTDIR)\sockerror.obj"
	-@erase "$(INTDIR)\stripslash.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\waitpid.obj"
	-@erase "$(INTDIR)\yesno.obj"
	-@erase "$(OUTDIR)\cvs.exe"
	-@erase ".\Release\add.obj"
	-@erase ".\Release\admin.obj"
	-@erase ".\Release\argmatch.obj"
	-@erase ".\Release\buffer.obj"
	-@erase ".\Release\checkin.obj"
	-@erase ".\Release\checkout.obj"
	-@erase ".\Release\classify.obj"
	-@erase ".\Release\client.obj"
	-@erase ".\Release\commit.obj"
	-@erase ".\Release\create_adm.obj"
	-@erase ".\Release\cvsrc.obj"
	-@erase ".\Release\diff.obj"
	-@erase ".\Release\edit.obj"
	-@erase ".\Release\entries.obj"
	-@erase ".\Release\error.obj"
	-@erase ".\Release\expand_path.obj"
	-@erase ".\Release\fileattr.obj"
	-@erase ".\Release\filesubr.obj"
	-@erase ".\Release\find_names.obj"
	-@erase ".\Release\fncase.obj"
	-@erase ".\Release\fnmatch.obj"
	-@erase ".\Release\getdate.obj"
	-@erase ".\Release\getline.obj"
	-@erase ".\Release\hash.obj"
	-@erase ".\Release\history.obj"
	-@erase ".\Release\ignore.obj"
	-@erase ".\Release\import.obj"
	-@erase ".\Release\lock.obj"
	-@erase ".\Release\log.obj"
	-@erase ".\Release\login.obj"
	-@erase ".\Release\logmsg.obj"
	-@erase ".\Release\main.obj"
	-@erase ".\Release\mkdir.obj"
	-@erase ".\Release\mkmodules.obj"
	-@erase ".\Release\modules.obj"
	-@erase ".\Release\myndbm.obj"
	-@erase ".\Release\ndir.obj"
	-@erase ".\Release\no_diff.obj"
	-@erase ".\Release\parseinfo.obj"
	-@erase ".\Release\patch.obj"
	-@erase ".\Release\rcmd.obj"
	-@erase ".\Release\rcs.obj"
	-@erase ".\Release\rcscmds.obj"
	-@erase ".\Release\recurse.obj"
	-@erase ".\Release\regex.obj"
	-@erase ".\Release\release.obj"
	-@erase ".\Release\remove.obj"
	-@erase ".\Release\repos.obj"
	-@erase ".\Release\root.obj"
	-@erase ".\Release\rtag.obj"
	-@erase ".\Release\run.obj"
	-@erase ".\Release\scramble.obj"
	-@erase ".\Release\server.obj"
	-@erase ".\Release\sighandle.obj"
	-@erase ".\Release\startserver.obj"
	-@erase ".\Release\status.obj"
	-@erase ".\Release\subr.obj"
	-@erase ".\Release\tag.obj"
	-@erase ".\Release\update.obj"
	-@erase ".\Release\valloc.obj"
	-@erase ".\Release\vers_ts.obj"
	-@erase ".\Release\version.obj"
	-@erase ".\Release\watch.obj"
	-@erase ".\Release\win32.obj"
	-@erase ".\Release\wrapper.obj"
	-@erase ".\Release\xgetwd.obj"
	-@erase ".\Release\zlib.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I\
 ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE"\
 /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR)\cvsnt.pch" /YX /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 zlib\Release\zlib.lib diff\Release\libdiff.lib /nologo /subsystem:console\
 /incremental:no /pdb:"$(OUTDIR)\cvs.pdb" /machine:I386 /out:"$(OUTDIR)\cvs.exe"\
 
LINK32_OBJS= \
	"$(INTDIR)\getopt.obj" \
	"$(INTDIR)\getopt1.obj" \
	"$(INTDIR)\md5.obj" \
	"$(INTDIR)\pwd.obj" \
	"$(INTDIR)\savecwd.obj" \
	"$(INTDIR)\sockerror.obj" \
	"$(INTDIR)\stripslash.obj" \
	"$(INTDIR)\waitpid.obj" \
	"$(INTDIR)\yesno.obj" \
	".\diff\Release\libdiff.lib" \
	".\Release\add.obj" \
	".\Release\admin.obj" \
	".\Release\argmatch.obj" \
	".\Release\buffer.obj" \
	".\Release\checkin.obj" \
	".\Release\checkout.obj" \
	".\Release\classify.obj" \
	".\Release\client.obj" \
	".\Release\commit.obj" \
	".\Release\create_adm.obj" \
	".\Release\cvsrc.obj" \
	".\Release\diff.obj" \
	".\Release\edit.obj" \
	".\Release\entries.obj" \
	".\Release\error.obj" \
	".\Release\expand_path.obj" \
	".\Release\fileattr.obj" \
	".\Release\filesubr.obj" \
	".\Release\find_names.obj" \
	".\Release\fncase.obj" \
	".\Release\fnmatch.obj" \
	".\Release\getdate.obj" \
	".\Release\getline.obj" \
	".\Release\hash.obj" \
	".\Release\history.obj" \
	".\Release\ignore.obj" \
	".\Release\import.obj" \
	".\Release\lock.obj" \
	".\Release\log.obj" \
	".\Release\login.obj" \
	".\Release\logmsg.obj" \
	".\Release\main.obj" \
	".\Release\mkdir.obj" \
	".\Release\mkmodules.obj" \
	".\Release\modules.obj" \
	".\Release\myndbm.obj" \
	".\Release\ndir.obj" \
	".\Release\no_diff.obj" \
	".\Release\parseinfo.obj" \
	".\Release\patch.obj" \
	".\Release\rcmd.obj" \
	".\Release\rcs.obj" \
	".\Release\rcscmds.obj" \
	".\Release\recurse.obj" \
	".\Release\regex.obj" \
	".\Release\release.obj" \
	".\Release\remove.obj" \
	".\Release\repos.obj" \
	".\Release\root.obj" \
	".\Release\rtag.obj" \
	".\Release\run.obj" \
	".\Release\scramble.obj" \
	".\Release\server.obj" \
	".\Release\sighandle.obj" \
	".\Release\startserver.obj" \
	".\Release\status.obj" \
	".\Release\subr.obj" \
	".\Release\tag.obj" \
	".\Release\update.obj" \
	".\Release\valloc.obj" \
	".\Release\vers_ts.obj" \
	".\Release\version.obj" \
	".\Release\watch.obj" \
	".\Release\win32.obj" \
	".\Release\wrapper.obj" \
	".\Release\xgetwd.obj" \
	".\Release\zlib.obj" \
	".\zlib\Release\zlib.lib"

"$(OUTDIR)\cvs.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\cvs.exe"

!ELSE 

ALL : "zlib - Win32 Debug" "libdiff - Win32 Debug" "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 DebugCLEAN" "zlib - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\getopt.obj"
	-@erase "$(INTDIR)\getopt1.obj"
	-@erase "$(INTDIR)\md5.obj"
	-@erase "$(INTDIR)\pwd.obj"
	-@erase "$(INTDIR)\savecwd.obj"
	-@erase "$(INTDIR)\sockerror.obj"
	-@erase "$(INTDIR)\stripslash.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\waitpid.obj"
	-@erase "$(INTDIR)\yesno.obj"
	-@erase "$(OUTDIR)\cvs.exe"
	-@erase "$(OUTDIR)\cvs.ilk"
	-@erase "$(OUTDIR)\cvs.pdb"
	-@erase ".\Debug\add.obj"
	-@erase ".\Debug\admin.obj"
	-@erase ".\Debug\argmatch.obj"
	-@erase ".\Debug\buffer.obj"
	-@erase ".\Debug\checkin.obj"
	-@erase ".\Debug\checkout.obj"
	-@erase ".\Debug\classify.obj"
	-@erase ".\Debug\client.obj"
	-@erase ".\Debug\commit.obj"
	-@erase ".\Debug\create_adm.obj"
	-@erase ".\Debug\cvsrc.obj"
	-@erase ".\Debug\diff.obj"
	-@erase ".\Debug\edit.obj"
	-@erase ".\Debug\entries.obj"
	-@erase ".\Debug\error.obj"
	-@erase ".\Debug\expand_path.obj"
	-@erase ".\Debug\fileattr.obj"
	-@erase ".\Debug\filesubr.obj"
	-@erase ".\Debug\find_names.obj"
	-@erase ".\Debug\fncase.obj"
	-@erase ".\Debug\fnmatch.obj"
	-@erase ".\Debug\getdate.obj"
	-@erase ".\Debug\getline.obj"
	-@erase ".\Debug\hash.obj"
	-@erase ".\Debug\history.obj"
	-@erase ".\Debug\ignore.obj"
	-@erase ".\Debug\import.obj"
	-@erase ".\Debug\lock.obj"
	-@erase ".\Debug\log.obj"
	-@erase ".\Debug\login.obj"
	-@erase ".\Debug\logmsg.obj"
	-@erase ".\Debug\main.obj"
	-@erase ".\Debug\mkdir.obj"
	-@erase ".\Debug\mkmodules.obj"
	-@erase ".\Debug\modules.obj"
	-@erase ".\Debug\myndbm.obj"
	-@erase ".\Debug\ndir.obj"
	-@erase ".\Debug\no_diff.obj"
	-@erase ".\Debug\parseinfo.obj"
	-@erase ".\Debug\patch.obj"
	-@erase ".\Debug\rcmd.obj"
	-@erase ".\Debug\rcs.obj"
	-@erase ".\Debug\rcscmds.obj"
	-@erase ".\Debug\recurse.obj"
	-@erase ".\Debug\regex.obj"
	-@erase ".\Debug\release.obj"
	-@erase ".\Debug\remove.obj"
	-@erase ".\Debug\repos.obj"
	-@erase ".\Debug\root.obj"
	-@erase ".\Debug\rtag.obj"
	-@erase ".\Debug\run.obj"
	-@erase ".\Debug\scramble.obj"
	-@erase ".\Debug\server.obj"
	-@erase ".\Debug\sighandle.obj"
	-@erase ".\Debug\startserver.obj"
	-@erase ".\Debug\status.obj"
	-@erase ".\Debug\subr.obj"
	-@erase ".\Debug\tag.obj"
	-@erase ".\Debug\update.obj"
	-@erase ".\Debug\valloc.obj"
	-@erase ".\Debug\vers_ts.obj"
	-@erase ".\Debug\version.obj"
	-@erase ".\Debug\watch.obj"
	-@erase ".\Debug\win32.obj"
	-@erase ".\Debug\wrapper.obj"
	-@erase ".\Debug\xgetwd.obj"
	-@erase ".\Debug\zlib.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR)\cvsnt.pch" /YX\
 /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 zlib\Debug\zlib.lib diff\Debug\libdiff.lib /nologo /subsystem:console\
 /incremental:yes /pdb:"$(OUTDIR)\cvs.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\cvs.exe" 
LINK32_OBJS= \
	"$(INTDIR)\getopt.obj" \
	"$(INTDIR)\getopt1.obj" \
	"$(INTDIR)\md5.obj" \
	"$(INTDIR)\pwd.obj" \
	"$(INTDIR)\savecwd.obj" \
	"$(INTDIR)\sockerror.obj" \
	"$(INTDIR)\stripslash.obj" \
	"$(INTDIR)\waitpid.obj" \
	"$(INTDIR)\yesno.obj" \
	".\Debug\add.obj" \
	".\Debug\admin.obj" \
	".\Debug\argmatch.obj" \
	".\Debug\buffer.obj" \
	".\Debug\checkin.obj" \
	".\Debug\checkout.obj" \
	".\Debug\classify.obj" \
	".\Debug\client.obj" \
	".\Debug\commit.obj" \
	".\Debug\create_adm.obj" \
	".\Debug\cvsrc.obj" \
	".\Debug\diff.obj" \
	".\Debug\edit.obj" \
	".\Debug\entries.obj" \
	".\Debug\error.obj" \
	".\Debug\expand_path.obj" \
	".\Debug\fileattr.obj" \
	".\Debug\filesubr.obj" \
	".\Debug\find_names.obj" \
	".\Debug\fncase.obj" \
	".\Debug\fnmatch.obj" \
	".\Debug\getdate.obj" \
	".\Debug\getline.obj" \
	".\Debug\hash.obj" \
	".\Debug\history.obj" \
	".\Debug\ignore.obj" \
	".\Debug\import.obj" \
	".\Debug\lock.obj" \
	".\Debug\log.obj" \
	".\Debug\login.obj" \
	".\Debug\logmsg.obj" \
	".\Debug\main.obj" \
	".\Debug\mkdir.obj" \
	".\Debug\mkmodules.obj" \
	".\Debug\modules.obj" \
	".\Debug\myndbm.obj" \
	".\Debug\ndir.obj" \
	".\Debug\no_diff.obj" \
	".\Debug\parseinfo.obj" \
	".\Debug\patch.obj" \
	".\Debug\rcmd.obj" \
	".\Debug\rcs.obj" \
	".\Debug\rcscmds.obj" \
	".\Debug\recurse.obj" \
	".\Debug\regex.obj" \
	".\Debug\release.obj" \
	".\Debug\remove.obj" \
	".\Debug\repos.obj" \
	".\Debug\root.obj" \
	".\Debug\rtag.obj" \
	".\Debug\run.obj" \
	".\Debug\scramble.obj" \
	".\Debug\server.obj" \
	".\Debug\sighandle.obj" \
	".\Debug\startserver.obj" \
	".\Debug\status.obj" \
	".\Debug\subr.obj" \
	".\Debug\tag.obj" \
	".\Debug\update.obj" \
	".\Debug\valloc.obj" \
	".\Debug\vers_ts.obj" \
	".\Debug\version.obj" \
	".\Debug\watch.obj" \
	".\Debug\win32.obj" \
	".\Debug\wrapper.obj" \
	".\Debug\xgetwd.obj" \
	".\Debug\zlib.obj" \
	".\diff\Debug\libdiff.lib" \
	".\zlib\Debug\zlib.lib"

"$(OUTDIR)\cvs.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<


!IF "$(CFG)" == "cvsnt - Win32 Release" || "$(CFG)" == "cvsnt - Win32 Debug"
SOURCE=.\src\add.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ADD_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\add.obj" : $(SOURCE) $(DEP_CPP_ADD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ADD_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\add.obj" : $(SOURCE) $(DEP_CPP_ADD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\admin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ADMIN=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\admin.obj" : $(SOURCE) $(DEP_CPP_ADMIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ADMIN=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\admin.obj" : $(SOURCE) $(DEP_CPP_ADMIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\argmatch.c
DEP_CPP_ARGMA=\
	".\windows-nt\config.h"\
	
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\argmatch.obj" : $(SOURCE) $(DEP_CPP_ARGMA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\argmatch.obj" : $(SOURCE) $(DEP_CPP_ARGMA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\buffer.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_BUFFE=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\buffer.obj" : $(SOURCE) $(DEP_CPP_BUFFE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_BUFFE=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\buffer.obj" : $(SOURCE) $(DEP_CPP_BUFFE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CHECK=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\checkin.obj" : $(SOURCE) $(DEP_CPP_CHECK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CHECK=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\checkin.obj" : $(SOURCE) $(DEP_CPP_CHECK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkout.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CHECKO=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\checkout.obj" : $(SOURCE) $(DEP_CPP_CHECKO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CHECKO=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\checkout.obj" : $(SOURCE) $(DEP_CPP_CHECKO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\classify.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CLASS=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\classify.obj" : $(SOURCE) $(DEP_CPP_CLASS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CLASS=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\classify.obj" : $(SOURCE) $(DEP_CPP_CLASS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\client.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CLIEN=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\md5.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\client.obj" : $(SOURCE) $(DEP_CPP_CLIEN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CLIEN=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\md5.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\client.obj" : $(SOURCE) $(DEP_CPP_CLIEN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\commit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_COMMI=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\commit.obj" : $(SOURCE) $(DEP_CPP_COMMI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_COMMI=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\commit.obj" : $(SOURCE) $(DEP_CPP_COMMI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\create_adm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CREAT=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\create_adm.obj" : $(SOURCE) $(DEP_CPP_CREAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CREAT=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\create_adm.obj" : $(SOURCE) $(DEP_CPP_CREAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\cvsrc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CVSRC=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\cvsrc.obj" : $(SOURCE) $(DEP_CPP_CVSRC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CVSRC=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\cvsrc.obj" : $(SOURCE) $(DEP_CPP_CVSRC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_DIFF_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_DIFF_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\edit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_EDIT_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\edit.obj" : $(SOURCE) $(DEP_CPP_EDIT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_EDIT_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\edit.obj" : $(SOURCE) $(DEP_CPP_EDIT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\entries.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ENTRI=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\entries.obj" : $(SOURCE) $(DEP_CPP_ENTRI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ENTRI=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\entries.obj" : $(SOURCE) $(DEP_CPP_ENTRI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\error.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ERROR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\error.obj" : $(SOURCE) $(DEP_CPP_ERROR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ERROR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\error.obj" : $(SOURCE) $(DEP_CPP_ERROR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\expand_path.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_EXPAN=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\expand_path.obj" : $(SOURCE) $(DEP_CPP_EXPAN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_EXPAN=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\expand_path.obj" : $(SOURCE) $(DEP_CPP_EXPAN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\fileattr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FILEA=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\fileattr.obj" : $(SOURCE) $(DEP_CPP_FILEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FILEA=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\fileattr.obj" : $(SOURCE) $(DEP_CPP_FILEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\filesubr.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FILES=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\filesubr.obj" : $(SOURCE) $(DEP_CPP_FILES) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FILES=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\filesubr.obj" : $(SOURCE) $(DEP_CPP_FILES) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\find_names.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FIND_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\find_names.obj" : $(SOURCE) $(DEP_CPP_FIND_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FIND_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\find_names.obj" : $(SOURCE) $(DEP_CPP_FIND_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fncase.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FNCAS=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\fncase.obj" : $(SOURCE) $(DEP_CPP_FNCAS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FNCAS=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\fncase.obj" : $(SOURCE) $(DEP_CPP_FNCAS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fnmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FNMAT=\
	".\lib\fnmatch.h"\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\fnmatch.obj" : $(SOURCE) $(DEP_CPP_FNMAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FNMAT=\
	".\lib\fnmatch.h"\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\fnmatch.obj" : $(SOURCE) $(DEP_CPP_FNMAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\getdate.c
DEP_CPP_GETDA=\
	".\windows-nt\config.h"\
	
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\getdate.obj" : $(SOURCE) $(DEP_CPP_GETDA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\getdate.obj" : $(SOURCE) $(DEP_CPP_GETDA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\getline.c
DEP_CPP_GETLI=\
	".\windows-nt\config.h"\
	
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\getline.obj" : $(SOURCE) $(DEP_CPP_GETLI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\getline.obj" : $(SOURCE) $(DEP_CPP_GETLI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\getopt.c
DEP_CPP_GETOP=\
	".\lib\getopt.h"\
	".\windows-nt\config.h"\
	

"$(INTDIR)\getopt.obj" : $(SOURCE) $(DEP_CPP_GETOP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\lib\getopt1.c
DEP_CPP_GETOPT=\
	".\lib\getopt.h"\
	".\windows-nt\config.h"\
	

"$(INTDIR)\getopt1.obj" : $(SOURCE) $(DEP_CPP_GETOPT) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\hash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_HASH_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\hash.obj" : $(SOURCE) $(DEP_CPP_HASH_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_HASH_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\hash.obj" : $(SOURCE) $(DEP_CPP_HASH_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\history.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_HISTO=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\history.obj" : $(SOURCE) $(DEP_CPP_HISTO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_HISTO=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\history.obj" : $(SOURCE) $(DEP_CPP_HISTO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\ignore.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_IGNOR=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\ignore.obj" : $(SOURCE) $(DEP_CPP_IGNOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_IGNOR=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\ignore.obj" : $(SOURCE) $(DEP_CPP_IGNOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\import.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_IMPOR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\import.obj" : $(SOURCE) $(DEP_CPP_IMPOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_IMPOR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\import.obj" : $(SOURCE) $(DEP_CPP_IMPOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\lock.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOCK_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\lock.obj" : $(SOURCE) $(DEP_CPP_LOCK_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOCK_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\lock.obj" : $(SOURCE) $(DEP_CPP_LOCK_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\log.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOG_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\log.obj" : $(SOURCE) $(DEP_CPP_LOG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOG_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\log.obj" : $(SOURCE) $(DEP_CPP_LOG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\login.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOGIN=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\login.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOGIN=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\login.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\logmsg.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOGMS=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\logmsg.obj" : $(SOURCE) $(DEP_CPP_LOGMS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOGMS=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\logmsg.obj" : $(SOURCE) $(DEP_CPP_LOGMS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\main.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MAIN_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\main.obj" : $(SOURCE) $(DEP_CPP_MAIN_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MAIN_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\main.obj" : $(SOURCE) $(DEP_CPP_MAIN_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\md5.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MD5_C=\
	".\lib\md5.h"\
	".\windows-nt\config.h"\
	

"$(INTDIR)\md5.obj" : $(SOURCE) $(DEP_CPP_MD5_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MD5_C=\
	".\lib\md5.h"\
	".\windows-nt\config.h"\
	

"$(INTDIR)\md5.obj" : $(SOURCE) $(DEP_CPP_MD5_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=".\windows-NT\mkdir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MKDIR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\mkdir.obj" : $(SOURCE) $(DEP_CPP_MKDIR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MKDIR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\mkdir.obj" : $(SOURCE) $(DEP_CPP_MKDIR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\mkmodules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MKMOD=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\mkmodules.obj" : $(SOURCE) $(DEP_CPP_MKMOD) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MKMOD=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\mkmodules.obj" : $(SOURCE) $(DEP_CPP_MKMOD) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\modules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MODUL=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\modules.obj" : $(SOURCE) $(DEP_CPP_MODUL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MODUL=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\modules.obj" : $(SOURCE) $(DEP_CPP_MODUL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\myndbm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MYNDB=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\myndbm.obj" : $(SOURCE) $(DEP_CPP_MYNDB) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MYNDB=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\myndbm.obj" : $(SOURCE) $(DEP_CPP_MYNDB) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\ndir.c"
DEP_CPP_NDIR_=\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\ndir.obj" : $(SOURCE) $(DEP_CPP_NDIR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\ndir.obj" : $(SOURCE) $(DEP_CPP_NDIR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\no_diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_NO_DI=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\no_diff.obj" : $(SOURCE) $(DEP_CPP_NO_DI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_NO_DI=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\no_diff.obj" : $(SOURCE) $(DEP_CPP_NO_DI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\parseinfo.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_PARSE=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\parseinfo.obj" : $(SOURCE) $(DEP_CPP_PARSE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_PARSE=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\parseinfo.obj" : $(SOURCE) $(DEP_CPP_PARSE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\patch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_PATCH=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\patch.obj" : $(SOURCE) $(DEP_CPP_PATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_PATCH=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\patch.obj" : $(SOURCE) $(DEP_CPP_PATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\pwd.c"
DEP_CPP_PWD_C=\
	".\windows-NT\pwd.h"\
	

"$(INTDIR)\pwd.obj" : $(SOURCE) $(DEP_CPP_PWD_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=".\windows-NT\rcmd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCMD_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\rcmd.obj" : $(SOURCE) $(DEP_CPP_RCMD_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCMD_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\rcmd.obj" : $(SOURCE) $(DEP_CPP_RCMD_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcs.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCS_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\rcs.obj" : $(SOURCE) $(DEP_CPP_RCS_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCS_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\rcs.obj" : $(SOURCE) $(DEP_CPP_RCS_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcscmds.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCSCM=\
	".\diff\diffrun.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\rcscmds.obj" : $(SOURCE) $(DEP_CPP_RCSCM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCSCM=\
	".\diff\diffrun.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\rcscmds.obj" : $(SOURCE) $(DEP_CPP_RCSCM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\recurse.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RECUR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\recurse.obj" : $(SOURCE) $(DEP_CPP_RECUR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RECUR=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\recurse.obj" : $(SOURCE) $(DEP_CPP_RECUR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\regex.c
DEP_CPP_REGEX=\
	".\lib\regex.h"\
	".\windows-nt\config.h"\
	
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\regex.obj" : $(SOURCE) $(DEP_CPP_REGEX) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\regex.obj" : $(SOURCE) $(DEP_CPP_REGEX) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\release.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RELEA=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\release.obj" : $(SOURCE) $(DEP_CPP_RELEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RELEA=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\release.obj" : $(SOURCE) $(DEP_CPP_RELEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\remove.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_REMOV=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\remove.obj" : $(SOURCE) $(DEP_CPP_REMOV) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_REMOV=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\remove.obj" : $(SOURCE) $(DEP_CPP_REMOV) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\repos.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_REPOS=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\repos.obj" : $(SOURCE) $(DEP_CPP_REPOS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_REPOS=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\repos.obj" : $(SOURCE) $(DEP_CPP_REPOS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\root.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ROOT_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\root.obj" : $(SOURCE) $(DEP_CPP_ROOT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ROOT_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\root.obj" : $(SOURCE) $(DEP_CPP_ROOT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rtag.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RTAG_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\rtag.obj" : $(SOURCE) $(DEP_CPP_RTAG_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RTAG_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\rtag.obj" : $(SOURCE) $(DEP_CPP_RTAG_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\run.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RUN_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\run.obj" : $(SOURCE) $(DEP_CPP_RUN_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RUN_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\run.obj" : $(SOURCE) $(DEP_CPP_RUN_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\savecwd.c
DEP_CPP_SAVEC=\
	".\lib\savecwd.h"\
	".\windows-nt\config.h"\
	

"$(INTDIR)\savecwd.obj" : $(SOURCE) $(DEP_CPP_SAVEC) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\scramble.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SCRAM=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\scramble.obj" : $(SOURCE) $(DEP_CPP_SCRAM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SCRAM=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\scramble.obj" : $(SOURCE) $(DEP_CPP_SCRAM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\server.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SERVE=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\server.obj" : $(SOURCE) $(DEP_CPP_SERVE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SERVE=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\server.obj" : $(SOURCE) $(DEP_CPP_SERVE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\sighandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SIGHA=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\sighandle.obj" : $(SOURCE) $(DEP_CPP_SIGHA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SIGHA=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\sighandle.obj" : $(SOURCE) $(DEP_CPP_SIGHA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\sockerror.c"

"$(INTDIR)\sockerror.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=".\windows-NT\startserver.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_START=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\startserver.obj" : $(SOURCE) $(DEP_CPP_START) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_START=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\startserver.obj" : $(SOURCE) $(DEP_CPP_START) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\status.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_STATU=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\status.obj" : $(SOURCE) $(DEP_CPP_STATU) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_STATU=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\status.obj" : $(SOURCE) $(DEP_CPP_STATU) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\stripslash.c
DEP_CPP_STRIP=\
	".\windows-nt\config.h"\
	

"$(INTDIR)\stripslash.obj" : $(SOURCE) $(DEP_CPP_STRIP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\subr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SUBR_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\subr.obj" : $(SOURCE) $(DEP_CPP_SUBR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SUBR_=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\subr.obj" : $(SOURCE) $(DEP_CPP_SUBR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\tag.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_TAG_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\tag.obj" : $(SOURCE) $(DEP_CPP_TAG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_TAG_C=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\tag.obj" : $(SOURCE) $(DEP_CPP_TAG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\update.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_UPDAT=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\update.obj" : $(SOURCE) $(DEP_CPP_UPDAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_UPDAT=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\update.obj" : $(SOURCE) $(DEP_CPP_UPDAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\valloc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VALLO=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\valloc.obj" : $(SOURCE) $(DEP_CPP_VALLO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VALLO=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\valloc.obj" : $(SOURCE) $(DEP_CPP_VALLO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\vers_ts.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VERS_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\vers_ts.obj" : $(SOURCE) $(DEP_CPP_VERS_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VERS_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\vers_ts.obj" : $(SOURCE) $(DEP_CPP_VERS_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\version.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VERSI=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\version.obj" : $(SOURCE) $(DEP_CPP_VERSI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VERSI=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\version.obj" : $(SOURCE) $(DEP_CPP_VERSI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\waitpid.c"
DEP_CPP_WAITP=\
	".\windows-nt\config.h"\
	

"$(INTDIR)\waitpid.obj" : $(SOURCE) $(DEP_CPP_WAITP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\watch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WATCH=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\watch.obj" : $(SOURCE) $(DEP_CPP_WATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WATCH=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\watch.obj" : $(SOURCE) $(DEP_CPP_WATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\win32.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WIN32=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\win32.obj" : $(SOURCE) $(DEP_CPP_WIN32) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WIN32=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\win32.obj" : $(SOURCE) $(DEP_CPP_WIN32) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\wrapper.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WRAPP=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\wrapper.obj" : $(SOURCE) $(DEP_CPP_WRAPP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WRAPP=\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\wrapper.obj" : $(SOURCE) $(DEP_CPP_WRAPP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\xgetwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_XGETW=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\xgetwd.obj" : $(SOURCE) $(DEP_CPP_XGETW) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_XGETW=\
	".\lib\system.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\xgetwd.obj" : $(SOURCE) $(DEP_CPP_XGETW) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\yesno.c
DEP_CPP_YESNO=\
	".\windows-nt\config.h"\
	

"$(INTDIR)\yesno.obj" : $(SOURCE) $(DEP_CPP_YESNO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\zlib.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ZLIB_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\zlib\zconf.h"\
	".\zlib\zlib.h"\
	
INTDIR_SRC=.\Release
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D\
 "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Release\zlib.obj" : $(SOURCE) $(DEP_CPP_ZLIB_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ZLIB_=\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\regex.h"\
	".\lib\system.h"\
	".\lib\wait.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\options.h"\
	".\src\rcs.h"\
	".\src\server.h"\
	".\src\update.h"\
	".\windows-nt\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\zlib\zconf.h"\
	".\zlib\zlib.h"\
	
INTDIR_SRC=.\Debug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\Debug\zlib.obj" : $(SOURCE) $(DEP_CPP_ZLIB_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release
INTDIR_SRC=.\Release

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"libdiff - Win32 Release" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F .\libdiff.mak CFG="libdiff - Win32 Release" 
   cd ".."

"libdiff - Win32 ReleaseCLEAN" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\libdiff.mak CFG="libdiff - Win32 Release"\
 RECURSE=1 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"libdiff - Win32 Debug" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F .\libdiff.mak CFG="libdiff - Win32 Debug" 
   cd ".."

"libdiff - Win32 DebugCLEAN" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\libdiff.mak CFG="libdiff - Win32 Debug"\
 RECURSE=1 
   cd ".."

!ENDIF 

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"zlib - Win32 Release" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F .\zlib.mak CFG="zlib - Win32 Release" 
   cd ".."

"zlib - Win32 ReleaseCLEAN" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\zlib.mak CFG="zlib - Win32 Release"\
 RECURSE=1 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"zlib - Win32 Debug" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F .\zlib.mak CFG="zlib - Win32 Debug" 
   cd ".."

"zlib - Win32 DebugCLEAN" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\zlib.mak CFG="zlib - Win32 Debug" RECURSE=1\
 
   cd ".."

!ENDIF 


!ENDIF 

