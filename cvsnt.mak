# Microsoft Developer Studio Generated NMAKE File, Based on cvsnt.dsp
!IF "$(CFG)" == ""
CFG=cvsnt - Win32 Debug
!MESSAGE No configuration specified. Defaulting to cvsnt - Win32 Debug.
!ENDIF 
!IF "$(RECURSE)" == ""
RECURSE=1
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

!IF  "$(CFG)" == "cvsnt - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\cvs.exe"

!ELSE 

ALL : "LIB - Win32 Release" "zlib - Win32 Release" "libdiff - Win32 Release"\
 "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 ReleaseCLEAN" "zlib - Win32 ReleaseCLEAN"\
 "LIB - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\asnprintf.obj"
	-@erase "$(INTDIR)\vasnprintf.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\xmalloc.obj"
	-@erase "$(INTDIR)\xstrdup.obj"
	-@erase "$(OUTDIR)\cvs.exe"
	-@erase ".\WinRel\add.obj"
	-@erase ".\WinRel\admin.obj"
	-@erase ".\WinRel\annotate.obj"
	-@erase ".\WinRel\argmatch.obj"
	-@erase ".\WinRel\buffer.obj"
	-@erase ".\WinRel\checkin.obj"
	-@erase ".\WinRel\checkout.obj"
	-@erase ".\WinRel\classify.obj"
	-@erase ".\WinRel\client.obj"
	-@erase ".\WinRel\commit.obj"
	-@erase ".\WinRel\create_adm.obj"
	-@erase ".\WinRel\cvsrc.obj"
	-@erase ".\WinRel\diff.obj"
	-@erase ".\WinRel\edit.obj"
	-@erase ".\WinRel\entries.obj"
	-@erase ".\WinRel\error.obj"
	-@erase ".\WinRel\exithandle.obj"
	-@erase ".\WinRel\expand_path.obj"
	-@erase ".\WinRel\fileattr.obj"
	-@erase ".\WinRel\filesubr.obj"
	-@erase ".\WinRel\find_names.obj"
	-@erase ".\WinRel\fncase.obj"
	-@erase ".\WinRel\fnmatch.obj"
	-@erase ".\WinRel\fseeko.obj"
	-@erase ".\WinRel\ftello.obj"
	-@erase ".\WinRel\hash.obj"
	-@erase ".\WinRel\history.obj"
	-@erase ".\WinRel\ignore.obj"
	-@erase ".\WinRel\import.obj"
	-@erase ".\WinRel\lock.obj"
	-@erase ".\WinRel\log-buffer.obj"
	-@erase ".\WinRel\log.obj"
	-@erase ".\WinRel\login.obj"
	-@erase ".\WinRel\logmsg.obj"
	-@erase ".\WinRel\main.obj"
	-@erase ".\WinRel\md5.obj"
	-@erase ".\WinRel\mkdir.obj"
	-@erase ".\WinRel\mkmodules.obj"
	-@erase ".\WinRel\modules.obj"
	-@erase ".\WinRel\myndbm.obj"
	-@erase ".\WinRel\ndir.obj"
	-@erase ".\WinRel\no_diff.obj"
	-@erase ".\WinRel\parseinfo.obj"
	-@erase ".\WinRel\patch.obj"
	-@erase ".\WinRel\pwd.obj"
	-@erase ".\WinRel\rcmd.obj"
	-@erase ".\WinRel\rcs.obj"
	-@erase ".\WinRel\rcscmds.obj"
	-@erase ".\WinRel\recurse.obj"
	-@erase ".\WinRel\release.obj"
	-@erase ".\WinRel\remove.obj"
	-@erase ".\WinRel\repos.obj"
	-@erase ".\WinRel\root.obj"
	-@erase ".\WinRel\rsh-client.obj"
	-@erase ".\WinRel\run.obj"
	-@erase ".\WinRel\savecwd.obj"
	-@erase ".\WinRel\scramble.obj"
	-@erase ".\WinRel\server.obj"
	-@erase ".\WinRel\sighandle.obj"
	-@erase ".\WinRel\sockerror.obj"
	-@erase ".\WinRel\socket-client.obj"
	-@erase ".\WinRel\stack.obj"
	-@erase ".\WinRel\startserver.obj"
	-@erase ".\WinRel\status.obj"
	-@erase ".\WinRel\stripslash.obj"
	-@erase ".\WinRel\subr.obj"
	-@erase ".\WinRel\tag.obj"
	-@erase ".\WinRel\update.obj"
	-@erase ".\WinRel\valloc.obj"
	-@erase ".\WinRel\vers_ts.obj"
	-@erase ".\WinRel\version.obj"
	-@erase ".\WinRel\waitpid.obj"
	-@erase ".\WinRel\watch.obj"
	-@erase ".\WinRel\woe32.obj"
	-@erase ".\WinRel\wrapper.obj"
	-@erase ".\WinRel\xgetwd.obj"
	-@erase ".\WinRel\yesno.obj"
	-@erase ".\WinRel\zlib.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I\
 ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION"\
 /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR)\cvsnt.pch" /YX\
 /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\WinRel/
CPP_SBRS=.

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 zlib\WinRel\zlib.lib diff\WinRel\libdiff.lib /nologo /subsystem:console\
 /incremental:no /pdb:"$(OUTDIR)\cvs.pdb" /machine:I386\
 /nodefaultlib:"libcmtd.lib" /out:"$(OUTDIR)\cvs.exe" 
LINK32_OBJS= \
	"$(INTDIR)\asnprintf.obj" \
	"$(INTDIR)\vasnprintf.obj" \
	"$(INTDIR)\xmalloc.obj" \
	"$(INTDIR)\xstrdup.obj" \
	".\diff\WinRel\libdiff.lib" \
	".\LIB\WinRel\libcvs.lib" \
	".\WinRel\add.obj" \
	".\WinRel\admin.obj" \
	".\WinRel\annotate.obj" \
	".\WinRel\argmatch.obj" \
	".\WinRel\buffer.obj" \
	".\WinRel\checkin.obj" \
	".\WinRel\checkout.obj" \
	".\WinRel\classify.obj" \
	".\WinRel\client.obj" \
	".\WinRel\commit.obj" \
	".\WinRel\create_adm.obj" \
	".\WinRel\cvsrc.obj" \
	".\WinRel\diff.obj" \
	".\WinRel\edit.obj" \
	".\WinRel\entries.obj" \
	".\WinRel\error.obj" \
	".\WinRel\exithandle.obj" \
	".\WinRel\expand_path.obj" \
	".\WinRel\fileattr.obj" \
	".\WinRel\filesubr.obj" \
	".\WinRel\find_names.obj" \
	".\WinRel\fncase.obj" \
	".\WinRel\fnmatch.obj" \
	".\WinRel\fseeko.obj" \
	".\WinRel\ftello.obj" \
	".\WinRel\hash.obj" \
	".\WinRel\history.obj" \
	".\WinRel\ignore.obj" \
	".\WinRel\import.obj" \
	".\WinRel\lock.obj" \
	".\WinRel\log-buffer.obj" \
	".\WinRel\log.obj" \
	".\WinRel\login.obj" \
	".\WinRel\logmsg.obj" \
	".\WinRel\main.obj" \
	".\WinRel\md5.obj" \
	".\WinRel\mkdir.obj" \
	".\WinRel\mkmodules.obj" \
	".\WinRel\modules.obj" \
	".\WinRel\myndbm.obj" \
	".\WinRel\ndir.obj" \
	".\WinRel\no_diff.obj" \
	".\WinRel\parseinfo.obj" \
	".\WinRel\patch.obj" \
	".\WinRel\pwd.obj" \
	".\WinRel\rcmd.obj" \
	".\WinRel\rcs.obj" \
	".\WinRel\rcscmds.obj" \
	".\WinRel\recurse.obj" \
	".\WinRel\release.obj" \
	".\WinRel\remove.obj" \
	".\WinRel\repos.obj" \
	".\WinRel\root.obj" \
	".\WinRel\rsh-client.obj" \
	".\WinRel\run.obj" \
	".\WinRel\savecwd.obj" \
	".\WinRel\scramble.obj" \
	".\WinRel\server.obj" \
	".\WinRel\sighandle.obj" \
	".\WinRel\sockerror.obj" \
	".\WinRel\socket-client.obj" \
	".\WinRel\stack.obj" \
	".\WinRel\startserver.obj" \
	".\WinRel\status.obj" \
	".\WinRel\stripslash.obj" \
	".\WinRel\subr.obj" \
	".\WinRel\tag.obj" \
	".\WinRel\update.obj" \
	".\WinRel\valloc.obj" \
	".\WinRel\vers_ts.obj" \
	".\WinRel\version.obj" \
	".\WinRel\waitpid.obj" \
	".\WinRel\watch.obj" \
	".\WinRel\woe32.obj" \
	".\WinRel\wrapper.obj" \
	".\WinRel\xgetwd.obj" \
	".\WinRel\yesno.obj" \
	".\WinRel\zlib.obj" \
	".\zlib\WinRel\zlib.lib"

"$(OUTDIR)\cvs.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\cvs.exe"

!ELSE 

ALL : "LIB - Win32 Debug" "zlib - Win32 Debug" "libdiff - Win32 Debug"\
 "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 DebugCLEAN" "zlib - Win32 DebugCLEAN"\
 "LIB - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\asnprintf.obj"
	-@erase "$(INTDIR)\vasnprintf.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\xmalloc.obj"
	-@erase "$(INTDIR)\xstrdup.obj"
	-@erase "$(OUTDIR)\cvs.exe"
	-@erase "$(OUTDIR)\cvs.ilk"
	-@erase "$(OUTDIR)\cvs.pdb"
	-@erase ".\WinDebug\add.obj"
	-@erase ".\WinDebug\admin.obj"
	-@erase ".\WinDebug\annotate.obj"
	-@erase ".\WinDebug\argmatch.obj"
	-@erase ".\WinDebug\buffer.obj"
	-@erase ".\WinDebug\checkin.obj"
	-@erase ".\WinDebug\checkout.obj"
	-@erase ".\WinDebug\classify.obj"
	-@erase ".\WinDebug\client.obj"
	-@erase ".\WinDebug\commit.obj"
	-@erase ".\WinDebug\create_adm.obj"
	-@erase ".\WinDebug\cvsrc.obj"
	-@erase ".\WinDebug\diff.obj"
	-@erase ".\WinDebug\edit.obj"
	-@erase ".\WinDebug\entries.obj"
	-@erase ".\WinDebug\error.obj"
	-@erase ".\WinDebug\exithandle.obj"
	-@erase ".\WinDebug\expand_path.obj"
	-@erase ".\WinDebug\fileattr.obj"
	-@erase ".\WinDebug\filesubr.obj"
	-@erase ".\WinDebug\find_names.obj"
	-@erase ".\WinDebug\fncase.obj"
	-@erase ".\WinDebug\fnmatch.obj"
	-@erase ".\WinDebug\fseeko.obj"
	-@erase ".\WinDebug\ftello.obj"
	-@erase ".\WinDebug\hash.obj"
	-@erase ".\WinDebug\history.obj"
	-@erase ".\WinDebug\ignore.obj"
	-@erase ".\WinDebug\import.obj"
	-@erase ".\WinDebug\lock.obj"
	-@erase ".\WinDebug\log-buffer.obj"
	-@erase ".\WinDebug\log.obj"
	-@erase ".\WinDebug\login.obj"
	-@erase ".\WinDebug\logmsg.obj"
	-@erase ".\WinDebug\main.obj"
	-@erase ".\WinDebug\md5.obj"
	-@erase ".\WinDebug\mkdir.obj"
	-@erase ".\WinDebug\mkmodules.obj"
	-@erase ".\WinDebug\modules.obj"
	-@erase ".\WinDebug\myndbm.obj"
	-@erase ".\WinDebug\ndir.obj"
	-@erase ".\WinDebug\no_diff.obj"
	-@erase ".\WinDebug\parseinfo.obj"
	-@erase ".\WinDebug\patch.obj"
	-@erase ".\WinDebug\pwd.obj"
	-@erase ".\WinDebug\rcmd.obj"
	-@erase ".\WinDebug\rcs.obj"
	-@erase ".\WinDebug\rcscmds.obj"
	-@erase ".\WinDebug\recurse.obj"
	-@erase ".\WinDebug\release.obj"
	-@erase ".\WinDebug\remove.obj"
	-@erase ".\WinDebug\repos.obj"
	-@erase ".\WinDebug\root.obj"
	-@erase ".\WinDebug\rsh-client.obj"
	-@erase ".\WinDebug\run.obj"
	-@erase ".\WinDebug\savecwd.obj"
	-@erase ".\WinDebug\scramble.obj"
	-@erase ".\WinDebug\server.obj"
	-@erase ".\WinDebug\sighandle.obj"
	-@erase ".\WinDebug\sockerror.obj"
	-@erase ".\WinDebug\socket-client.obj"
	-@erase ".\WinDebug\stack.obj"
	-@erase ".\WinDebug\startserver.obj"
	-@erase ".\WinDebug\status.obj"
	-@erase ".\WinDebug\stripslash.obj"
	-@erase ".\WinDebug\subr.obj"
	-@erase ".\WinDebug\tag.obj"
	-@erase ".\WinDebug\update.obj"
	-@erase ".\WinDebug\valloc.obj"
	-@erase ".\WinDebug\vers_ts.obj"
	-@erase ".\WinDebug\version.obj"
	-@erase ".\WinDebug\waitpid.obj"
	-@erase ".\WinDebug\watch.obj"
	-@erase ".\WinDebug\woe32.obj"
	-@erase ".\WinDebug\wrapper.obj"
	-@erase ".\WinDebug\xgetwd.obj"
	-@erase ".\WinDebug\yesno.obj"
	-@erase ".\WinDebug\zlib.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR)\cvsnt.pch" /YX\
 /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\WinDebug/
CPP_SBRS=.

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 zlib\WinDebug\zlib.lib diff\WinDebug\libdiff.lib lib\WinDebug\libcvs.lib\
 /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\cvs.pdb" /debug\
 /machine:I386 /nodefaultlib:"libcmtd.lib" /out:"$(OUTDIR)\cvs.exe" 
LINK32_OBJS= \
	"$(INTDIR)\asnprintf.obj" \
	"$(INTDIR)\vasnprintf.obj" \
	"$(INTDIR)\xmalloc.obj" \
	"$(INTDIR)\xstrdup.obj" \
	".\diff\WinDebug\libdiff.lib" \
	".\LIB\WinDebug\libcvs.lib" \
	".\WinDebug\add.obj" \
	".\WinDebug\admin.obj" \
	".\WinDebug\annotate.obj" \
	".\WinDebug\argmatch.obj" \
	".\WinDebug\buffer.obj" \
	".\WinDebug\checkin.obj" \
	".\WinDebug\checkout.obj" \
	".\WinDebug\classify.obj" \
	".\WinDebug\client.obj" \
	".\WinDebug\commit.obj" \
	".\WinDebug\create_adm.obj" \
	".\WinDebug\cvsrc.obj" \
	".\WinDebug\diff.obj" \
	".\WinDebug\edit.obj" \
	".\WinDebug\entries.obj" \
	".\WinDebug\error.obj" \
	".\WinDebug\exithandle.obj" \
	".\WinDebug\expand_path.obj" \
	".\WinDebug\fileattr.obj" \
	".\WinDebug\filesubr.obj" \
	".\WinDebug\find_names.obj" \
	".\WinDebug\fncase.obj" \
	".\WinDebug\fnmatch.obj" \
	".\WinDebug\fseeko.obj" \
	".\WinDebug\ftello.obj" \
	".\WinDebug\hash.obj" \
	".\WinDebug\history.obj" \
	".\WinDebug\ignore.obj" \
	".\WinDebug\import.obj" \
	".\WinDebug\lock.obj" \
	".\WinDebug\log-buffer.obj" \
	".\WinDebug\log.obj" \
	".\WinDebug\login.obj" \
	".\WinDebug\logmsg.obj" \
	".\WinDebug\main.obj" \
	".\WinDebug\md5.obj" \
	".\WinDebug\mkdir.obj" \
	".\WinDebug\mkmodules.obj" \
	".\WinDebug\modules.obj" \
	".\WinDebug\myndbm.obj" \
	".\WinDebug\ndir.obj" \
	".\WinDebug\no_diff.obj" \
	".\WinDebug\parseinfo.obj" \
	".\WinDebug\patch.obj" \
	".\WinDebug\pwd.obj" \
	".\WinDebug\rcmd.obj" \
	".\WinDebug\rcs.obj" \
	".\WinDebug\rcscmds.obj" \
	".\WinDebug\recurse.obj" \
	".\WinDebug\release.obj" \
	".\WinDebug\remove.obj" \
	".\WinDebug\repos.obj" \
	".\WinDebug\root.obj" \
	".\WinDebug\rsh-client.obj" \
	".\WinDebug\run.obj" \
	".\WinDebug\savecwd.obj" \
	".\WinDebug\scramble.obj" \
	".\WinDebug\server.obj" \
	".\WinDebug\sighandle.obj" \
	".\WinDebug\sockerror.obj" \
	".\WinDebug\socket-client.obj" \
	".\WinDebug\stack.obj" \
	".\WinDebug\startserver.obj" \
	".\WinDebug\status.obj" \
	".\WinDebug\stripslash.obj" \
	".\WinDebug\subr.obj" \
	".\WinDebug\tag.obj" \
	".\WinDebug\update.obj" \
	".\WinDebug\valloc.obj" \
	".\WinDebug\vers_ts.obj" \
	".\WinDebug\version.obj" \
	".\WinDebug\waitpid.obj" \
	".\WinDebug\watch.obj" \
	".\WinDebug\woe32.obj" \
	".\WinDebug\wrapper.obj" \
	".\WinDebug\xgetwd.obj" \
	".\WinDebug\yesno.obj" \
	".\WinDebug\zlib.obj" \
	".\zlib\WinDebug\zlib.lib"

"$(OUTDIR)\cvs.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(CFG)" == "cvsnt - Win32 Release" || "$(CFG)" == "cvsnt - Win32 Debug"
SOURCE=.\src\add.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ADD_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\add.obj" : $(SOURCE) $(DEP_CPP_ADD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ADD_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ADD_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\add.obj" : $(SOURCE) $(DEP_CPP_ADD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\admin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ADMIN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\admin.obj" : $(SOURCE) $(DEP_CPP_ADMIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ADMIN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ADMIN=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\admin.obj" : $(SOURCE) $(DEP_CPP_ADMIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\annotate.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ANNOT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\annotate.obj" : $(SOURCE) $(DEP_CPP_ANNOT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ANNOT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ANNOT=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\annotate.obj" : $(SOURCE) $(DEP_CPP_ANNOT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\argmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ARGMA=\
	".\windows-NT\config.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\argmatch.obj" : $(SOURCE) $(DEP_CPP_ARGMA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ARGMA=\
	".\windows-NT\config.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\argmatch.obj" : $(SOURCE) $(DEP_CPP_ARGMA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\asnprintf.c
DEP_CPP_ASNPR=\
	".\lib\vasnprintf.h"\
	".\windows-NT\config.h"\
	

"$(INTDIR)\asnprintf.obj" : $(SOURCE) $(DEP_CPP_ASNPR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\buffer.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_BUFFE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\buffer.obj" : $(SOURCE) $(DEP_CPP_BUFFE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_BUFFE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_BUFFE=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\buffer.obj" : $(SOURCE) $(DEP_CPP_BUFFE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CHECK=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\checkin.obj" : $(SOURCE) $(DEP_CPP_CHECK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CHECK=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CHECK=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\checkin.obj" : $(SOURCE) $(DEP_CPP_CHECK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkout.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CHECKO=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\checkout.obj" : $(SOURCE) $(DEP_CPP_CHECKO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CHECKO=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CHECKO=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\checkout.obj" : $(SOURCE) $(DEP_CPP_CHECKO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\classify.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CLASS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\classify.obj" : $(SOURCE) $(DEP_CPP_CLASS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CLASS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CLASS=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\classify.obj" : $(SOURCE) $(DEP_CPP_CLASS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\client.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CLIEN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\md5.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hash.h"\
	".\src\log-buffer.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\rsh-client.h"\
	".\src\server.h"\
	".\src\socket-client.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\client.obj" : $(SOURCE) $(DEP_CPP_CLIEN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CLIEN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\md5.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\gssapi-client.h"\
	".\src\hash.h"\
	".\src\kerberos4-client.h"\
	".\src\log-buffer.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\rsh-client.h"\
	".\src\server.h"\
	".\src\socket-client.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CLIEN=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\client.obj" : $(SOURCE) $(DEP_CPP_CLIEN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\commit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_COMMI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\commit.obj" : $(SOURCE) $(DEP_CPP_COMMI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_COMMI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_COMMI=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\commit.obj" : $(SOURCE) $(DEP_CPP_COMMI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\create_adm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CREAT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\create_adm.obj" : $(SOURCE) $(DEP_CPP_CREAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CREAT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CREAT=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\create_adm.obj" : $(SOURCE) $(DEP_CPP_CREAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\cvsrc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_CVSRC=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\cvsrc.obj" : $(SOURCE) $(DEP_CPP_CVSRC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_CVSRC=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_CVSRC=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\cvsrc.obj" : $(SOURCE) $(DEP_CPP_CVSRC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_DIFF_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_DIFF_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_DIFF_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\edit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_EDIT_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\edit.obj" : $(SOURCE) $(DEP_CPP_EDIT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_EDIT_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_EDIT_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\edit.obj" : $(SOURCE) $(DEP_CPP_EDIT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\entries.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ENTRI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\entries.obj" : $(SOURCE) $(DEP_CPP_ENTRI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ENTRI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ENTRI=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\entries.obj" : $(SOURCE) $(DEP_CPP_ENTRI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\error.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ERROR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\error.obj" : $(SOURCE) $(DEP_CPP_ERROR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ERROR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ERROR=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\error.obj" : $(SOURCE) $(DEP_CPP_ERROR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\exithandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_EXITH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\exithandle.obj" : $(SOURCE) $(DEP_CPP_EXITH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_EXITH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_EXITH=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\exithandle.obj" : $(SOURCE) $(DEP_CPP_EXITH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\expand_path.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_EXPAN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\expand_path.obj" : $(SOURCE) $(DEP_CPP_EXPAN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_EXPAN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_EXPAN=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\expand_path.obj" : $(SOURCE) $(DEP_CPP_EXPAN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\fileattr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FILEA=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\fileattr.obj" : $(SOURCE) $(DEP_CPP_FILEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FILEA=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_FILEA=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\fileattr.obj" : $(SOURCE) $(DEP_CPP_FILEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\filesubr.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FILES=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\filesubr.obj" : $(SOURCE) $(DEP_CPP_FILES) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FILES=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_FILES=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\filesubr.obj" : $(SOURCE) $(DEP_CPP_FILES) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\find_names.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FIND_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\find_names.obj" : $(SOURCE) $(DEP_CPP_FIND_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FIND_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_FIND_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\find_names.obj" : $(SOURCE) $(DEP_CPP_FIND_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fncase.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FNCAS=\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\fncase.obj" : $(SOURCE) $(DEP_CPP_FNCAS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FNCAS=\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_FNCAS=\
	".\lib\tcpip.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\fncase.obj" : $(SOURCE) $(DEP_CPP_FNCAS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fnmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FNMAT=\
	".\lib\fnmatch.h"\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\fnmatch.obj" : $(SOURCE) $(DEP_CPP_FNMAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FNMAT=\
	".\lib\fnmatch.h"\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_FNMAT=\
	".\lib\tcpip.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\fnmatch.obj" : $(SOURCE) $(DEP_CPP_FNMAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fseeko.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FSEEK=\
	".\windows-NT\config.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\fseeko.obj" : $(SOURCE) $(DEP_CPP_FSEEK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FSEEK=\
	".\windows-NT\config.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\fseeko.obj" : $(SOURCE) $(DEP_CPP_FSEEK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\ftello.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_FTELL=\
	".\windows-NT\config.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\ftello.obj" : $(SOURCE) $(DEP_CPP_FTELL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_FTELL=\
	".\windows-NT\config.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\ftello.obj" : $(SOURCE) $(DEP_CPP_FTELL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\hash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_HASH_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\hash.obj" : $(SOURCE) $(DEP_CPP_HASH_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_HASH_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_HASH_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\hash.obj" : $(SOURCE) $(DEP_CPP_HASH_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\history.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_HISTO=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\history.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\history.obj" : $(SOURCE) $(DEP_CPP_HISTO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_HISTO=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\history.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_HISTO=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\history.obj" : $(SOURCE) $(DEP_CPP_HISTO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\ignore.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_IGNOR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\ignore.obj" : $(SOURCE) $(DEP_CPP_IGNOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_IGNOR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_IGNOR=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\ignore.obj" : $(SOURCE) $(DEP_CPP_IGNOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\import.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_IMPOR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\import.obj" : $(SOURCE) $(DEP_CPP_IMPOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_IMPOR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_IMPOR=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\import.obj" : $(SOURCE) $(DEP_CPP_IMPOR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\lock.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOCK_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\lock.obj" : $(SOURCE) $(DEP_CPP_LOCK_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOCK_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xselect.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_LOCK_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\lock.obj" : $(SOURCE) $(DEP_CPP_LOCK_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\log-buffer.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOG_B=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\log-buffer.obj" : $(SOURCE) $(DEP_CPP_LOG_B) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOG_B=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_LOG_B=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\log-buffer.obj" : $(SOURCE) $(DEP_CPP_LOG_B) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\log.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOG_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\log.obj" : $(SOURCE) $(DEP_CPP_LOG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOG_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_LOG_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\log.obj" : $(SOURCE) $(DEP_CPP_LOG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\login.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOGIN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\login.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOGIN=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_LOGIN=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\login.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\logmsg.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_LOGMS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\logmsg.obj" : $(SOURCE) $(DEP_CPP_LOGMS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_LOGMS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_LOGMS=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\logmsg.obj" : $(SOURCE) $(DEP_CPP_LOGMS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\main.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MAIN_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\main.obj" : $(SOURCE) $(DEP_CPP_MAIN_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MAIN_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_MAIN_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\main.obj" : $(SOURCE) $(DEP_CPP_MAIN_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\md5.c
DEP_CPP_MD5_C=\
	".\lib\md5.h"\
	".\windows-NT\config.h"\
	

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\md5.obj" : $(SOURCE) $(DEP_CPP_MD5_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\md5.obj" : $(SOURCE) $(DEP_CPP_MD5_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\mkdir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MKDIR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\mkdir.obj" : $(SOURCE) $(DEP_CPP_MKDIR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MKDIR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_MKDIR=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\mkdir.obj" : $(SOURCE) $(DEP_CPP_MKDIR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\mkmodules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MKMOD=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\history.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\mkmodules.obj" : $(SOURCE) $(DEP_CPP_MKMOD) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MKMOD=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\history.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_MKMOD=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\mkmodules.obj" : $(SOURCE) $(DEP_CPP_MKMOD) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\modules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MODUL=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\modules.obj" : $(SOURCE) $(DEP_CPP_MODUL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MODUL=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_MODUL=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\modules.obj" : $(SOURCE) $(DEP_CPP_MODUL) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\myndbm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_MYNDB=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\myndbm.obj" : $(SOURCE) $(DEP_CPP_MYNDB) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_MYNDB=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_MYNDB=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\myndbm.obj" : $(SOURCE) $(DEP_CPP_MYNDB) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\ndir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_NDIR_=\
	".\windows-NT\ndir.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\ndir.obj" : $(SOURCE) $(DEP_CPP_NDIR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_NDIR_=\
	".\windows-NT\ndir.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\ndir.obj" : $(SOURCE) $(DEP_CPP_NDIR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\no_diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_NO_DI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\no_diff.obj" : $(SOURCE) $(DEP_CPP_NO_DI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_NO_DI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_NO_DI=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\no_diff.obj" : $(SOURCE) $(DEP_CPP_NO_DI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\parseinfo.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_PARSE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\parseinfo.obj" : $(SOURCE) $(DEP_CPP_PARSE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_PARSE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_PARSE=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\parseinfo.obj" : $(SOURCE) $(DEP_CPP_PARSE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\patch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_PATCH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\patch.obj" : $(SOURCE) $(DEP_CPP_PATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_PATCH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_PATCH=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\patch.obj" : $(SOURCE) $(DEP_CPP_PATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\pwd.c"
DEP_CPP_PWD_C=\
	".\windows-NT\pwd.h"\
	

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\pwd.obj" : $(SOURCE) $(DEP_CPP_PWD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\pwd.obj" : $(SOURCE) $(DEP_CPP_PWD_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\rcmd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCMD_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\rcmd.obj" : $(SOURCE) $(DEP_CPP_RCMD_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCMD_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RCMD_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\rcmd.obj" : $(SOURCE) $(DEP_CPP_RCMD_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcs.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCS_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\rcs.obj" : $(SOURCE) $(DEP_CPP_RCS_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCS_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\getpagesize.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RCS_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\rcs.obj" : $(SOURCE) $(DEP_CPP_RCS_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcscmds.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RCSCM=\
	".\diff\diffrun.h"\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\rcscmds.obj" : $(SOURCE) $(DEP_CPP_RCSCM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RCSCM=\
	".\diff\diffrun.h"\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RCSCM=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\rcscmds.obj" : $(SOURCE) $(DEP_CPP_RCSCM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\recurse.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RECUR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\recurse.obj" : $(SOURCE) $(DEP_CPP_RECUR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RECUR=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RECUR=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\recurse.obj" : $(SOURCE) $(DEP_CPP_RECUR) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\release.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RELEA=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\release.obj" : $(SOURCE) $(DEP_CPP_RELEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RELEA=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RELEA=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\release.obj" : $(SOURCE) $(DEP_CPP_RELEA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\remove.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_REMOV=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\remove.obj" : $(SOURCE) $(DEP_CPP_REMOV) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_REMOV=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_REMOV=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\remove.obj" : $(SOURCE) $(DEP_CPP_REMOV) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\repos.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_REPOS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\repos.obj" : $(SOURCE) $(DEP_CPP_REPOS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_REPOS=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_REPOS=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\repos.obj" : $(SOURCE) $(DEP_CPP_REPOS) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\root.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ROOT_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\root.obj" : $(SOURCE) $(DEP_CPP_ROOT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ROOT_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ROOT_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\root.obj" : $(SOURCE) $(DEP_CPP_ROOT_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\rsh-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RSH_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\rsh-client.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\rsh-client.obj" : $(SOURCE) $(DEP_CPP_RSH_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RSH_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\rsh-client.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RSH_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\rsh-client.obj" : $(SOURCE) $(DEP_CPP_RSH_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\run.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_RUN_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\run.obj" : $(SOURCE) $(DEP_CPP_RUN_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_RUN_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_RUN_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\run.obj" : $(SOURCE) $(DEP_CPP_RUN_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\savecwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SAVEC=\
	".\lib\savecwd.h"\
	".\windows-NT\config.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\savecwd.obj" : $(SOURCE) $(DEP_CPP_SAVEC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SAVEC=\
	".\lib\savecwd.h"\
	".\windows-NT\config.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\savecwd.obj" : $(SOURCE) $(DEP_CPP_SAVEC) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\scramble.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SCRAM=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\scramble.obj" : $(SOURCE) $(DEP_CPP_SCRAM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SCRAM=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_SCRAM=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\scramble.obj" : $(SOURCE) $(DEP_CPP_SCRAM) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\server.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SERVE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getnline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\server.obj" : $(SOURCE) $(DEP_CPP_SERVE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SERVE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getnline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xselect.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\gssapi-client.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\socket-client.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_SERVE=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\server.obj" : $(SOURCE) $(DEP_CPP_SERVE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\sighandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SIGHA=\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\sighandle.obj" : $(SOURCE) $(DEP_CPP_SIGHA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SIGHA=\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_SIGHA=\
	".\lib\tcpip.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\sighandle.obj" : $(SOURCE) $(DEP_CPP_SIGHA) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\sockerror.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\sockerror.obj" : $(SOURCE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\sockerror.obj" : $(SOURCE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\socket-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SOCKE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\socket-client.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\socket-client.obj" : $(SOURCE) $(DEP_CPP_SOCKE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SOCKE=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\socket-client.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_SOCKE=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\socket-client.obj" : $(SOURCE) $(DEP_CPP_SOCKE) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\stack.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_STACK=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\stack.obj" : $(SOURCE) $(DEP_CPP_STACK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_STACK=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_STACK=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\stack.obj" : $(SOURCE) $(DEP_CPP_STACK) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\startserver.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_START=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\startserver.obj" : $(SOURCE) $(DEP_CPP_START) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_START=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\windows-NT\rcmd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_START=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\startserver.obj" : $(SOURCE) $(DEP_CPP_START) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\status.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_STATU=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\status.obj" : $(SOURCE) $(DEP_CPP_STATU) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_STATU=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_STATU=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\status.obj" : $(SOURCE) $(DEP_CPP_STATU) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\stripslash.c
DEP_CPP_STRIP=\
	".\windows-NT\config.h"\
	

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\stripslash.obj" : $(SOURCE) $(DEP_CPP_STRIP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\stripslash.obj" : $(SOURCE) $(DEP_CPP_STRIP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\subr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_SUBR_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\vasnprintf.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\subr.obj" : $(SOURCE) $(DEP_CPP_SUBR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_SUBR_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\vasnprintf.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xselect.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_SUBR_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\subr.obj" : $(SOURCE) $(DEP_CPP_SUBR_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\tag.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_TAG_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\tag.obj" : $(SOURCE) $(DEP_CPP_TAG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_TAG_C=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_TAG_C=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\tag.obj" : $(SOURCE) $(DEP_CPP_TAG_C) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\update.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_UPDAT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\update.obj" : $(SOURCE) $(DEP_CPP_UPDAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_UPDAT=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\md5.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\savecwd.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hardlink.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_UPDAT=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\update.obj" : $(SOURCE) $(DEP_CPP_UPDAT) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\valloc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VALLO=\
	".\lib\getpagesize.h"\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\valloc.obj" : $(SOURCE) $(DEP_CPP_VALLO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VALLO=\
	".\lib\getpagesize.h"\
	".\lib\gettext.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_VALLO=\
	".\lib\tcpip.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\valloc.obj" : $(SOURCE) $(DEP_CPP_VALLO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\vasnprintf.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VASNP=\
	".\lib\alloca.h"\
	".\lib\printf-args.h"\
	".\lib\printf-parse.h"\
	".\lib\vasnprintf.h"\
	".\lib\xsize.h"\
	".\windows-NT\config.h"\
	

"$(INTDIR)\vasnprintf.obj" : $(SOURCE) $(DEP_CPP_VASNP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VASNP=\
	".\lib\alloca.h"\
	".\lib\printf-args.h"\
	".\lib\printf-parse.h"\
	".\lib\vasnprintf.h"\
	".\lib\xsize.h"\
	".\windows-NT\config.h"\
	
NODEP_CPP_VASNP=\
	".\lib\vasnwprintf.h"\
	".\LIB\wprintf-parse.h"\
	

"$(INTDIR)\vasnprintf.obj" : $(SOURCE) $(DEP_CPP_VASNP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=.\src\vers_ts.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VERS_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\vers_ts.obj" : $(SOURCE) $(DEP_CPP_VERS_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VERS_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_VERS_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\vers_ts.obj" : $(SOURCE) $(DEP_CPP_VERS_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\version.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_VERSI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\version.obj" : $(SOURCE) $(DEP_CPP_VERSI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_VERSI=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_VERSI=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\version.obj" : $(SOURCE) $(DEP_CPP_VERSI) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\waitpid.c"
DEP_CPP_WAITP=\
	".\windows-NT\config.h"\
	

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\waitpid.obj" : $(SOURCE) $(DEP_CPP_WAITP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\waitpid.obj" : $(SOURCE) $(DEP_CPP_WAITP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\watch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WATCH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\watch.obj" : $(SOURCE) $(DEP_CPP_WATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WATCH=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\edit.h"\
	".\src\fileattr.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\src\watch.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_WATCH=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\watch.obj" : $(SOURCE) $(DEP_CPP_WATCH) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\woe32.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WOE32=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\woe32.obj" : $(SOURCE) $(DEP_CPP_WOE32) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WOE32=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_WOE32=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\woe32.obj" : $(SOURCE) $(DEP_CPP_WOE32) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\wrapper.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_WRAPP=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\wrapper.obj" : $(SOURCE) $(DEP_CPP_WRAPP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_WRAPP=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getline.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_WRAPP=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\wrapper.obj" : $(SOURCE) $(DEP_CPP_WRAPP) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\xgetwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_XGETW=\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\xgetwd.obj" : $(SOURCE) $(DEP_CPP_XGETW) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_XGETW=\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\xtime.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_XGETW=\
	".\lib\tcpip.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\xgetwd.obj" : $(SOURCE) $(DEP_CPP_XGETW) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\xmalloc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_XMALL=\
	".\lib\exitfail.h"\
	".\lib\gettext.h"\
	".\lib\xalloc.h"\
	".\windows-NT\config.h"\
	

"$(INTDIR)\xmalloc.obj" : $(SOURCE) $(DEP_CPP_XMALL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_XMALL=\
	".\lib\exitfail.h"\
	".\lib\gettext.h"\
	".\lib\xalloc.h"\
	".\windows-NT\config.h"\
	

"$(INTDIR)\xmalloc.obj" : $(SOURCE) $(DEP_CPP_XMALL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=.\lib\xstrdup.c
DEP_CPP_XSTRD=\
	".\lib\xalloc.h"\
	".\windows-NT\config.h"\
	

"$(INTDIR)\xstrdup.obj" : $(SOURCE) $(DEP_CPP_XSTRD) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\lib\yesno.c
DEP_CPP_YESNO=\
	".\windows-NT\config.h"\
	

!IF  "$(CFG)" == "cvsnt - Win32 Release"

INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\yesno.obj" : $(SOURCE) $(DEP_CPP_YESNO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\yesno.obj" : $(SOURCE) $(DEP_CPP_YESNO) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\zlib.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

DEP_CPP_ZLIB_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\zlib\zconf.h"\
	".\zlib\zlib.h"\
	
INTDIR_SRC=.\WinRel
CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src"\
 /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D\
 "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32"\
 /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD\
 /c 

".\WinRel\zlib.obj" : $(SOURCE) $(DEP_CPP_ZLIB_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

DEP_CPP_ZLIB_=\
	".\lib\exit.h"\
	".\lib\fnmatch.h"\
	".\lib\getopt.h"\
	".\lib\gettext.h"\
	".\lib\pathmax.h"\
	".\LIB\regex.h"\
	".\lib\system.h"\
	".\lib\unlocked-io.h"\
	".\lib\wait.h"\
	".\lib\xalloc.h"\
	".\lib\xtime.h"\
	".\src\buffer.h"\
	".\src\client.h"\
	".\src\cvs.h"\
	".\src\hash.h"\
	".\src\myndbm.h"\
	".\src\rcs.h"\
	".\src\root.h"\
	".\src\server.h"\
	".\src\stack.h"\
	".\src\update.h"\
	".\windows-NT\config.h"\
	".\windows-NT\ndir.h"\
	".\windows-NT\pwd.h"\
	".\zlib\zconf.h"\
	".\zlib\zlib.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"sys\utime.h"\
	
NODEP_CPP_ZLIB_=\
	".\lib\tcpip.h"\
	".\src\popen.h"\
	
INTDIR_SRC=.\WinDebug
CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I\
 ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D\
 "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR_SRC)\cvsnt.pch" /YX\
 /Fo"$(INTDIR_SRC)\\" /Fd"$(INTDIR_SRC)\\" /FD /c 

".\WinDebug\zlib.obj" : $(SOURCE) $(DEP_CPP_ZLIB_) "$(INTDIR_SRC)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

INTDIR_SRC=.\Release
"$(INTDIR_SRC)" :
    if not exist "$(INTDIR_SRC)/$(NULL)" mkdir "$(INTDIR_SRC)"

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

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"LIB - Win32 Release" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F .\LIB.mak CFG="LIB - Win32 Release" 
   cd ".."

"LIB - Win32 ReleaseCLEAN" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\LIB.mak CFG="LIB - Win32 Release" RECURSE=1\
 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"LIB - Win32 Debug" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F .\LIB.mak CFG="LIB - Win32 Debug" 
   cd ".."

"LIB - Win32 DebugCLEAN" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\LIB.mak CFG="LIB - Win32 Debug" RECURSE=1 
   cd ".."

!ENDIF 


!ENDIF 

