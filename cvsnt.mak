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

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\cvs.exe"

!ELSE 

ALL : "LIB - Win32 Release" "zlib - Win32 Release" "libdiff - Win32 Release" "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 ReleaseCLEAN" "zlib - Win32 ReleaseCLEAN" "LIB - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\asnprintf.obj"
	-@erase "$(INTDIR)\vasnprintf.obj"
	-@erase "$(INTDIR)\vc60.idb"
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

CPP_PROJ=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"$(INTDIR)\cvsnt.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\WinRel\zlib.lib diff\WinRel\libdiff.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\cvs.pdb" /machine:I386 /nodefaultlib:"libcmtd.lib" /out:"$(OUTDIR)\cvs.exe" 
LINK32_OBJS= \
	".\WinRel\add.obj" \
	".\WinRel\admin.obj" \
	".\WinRel\annotate.obj" \
	".\WinRel\argmatch.obj" \
	"$(INTDIR)\asnprintf.obj" \
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
	"$(INTDIR)\vasnprintf.obj" \
	".\WinRel\vers_ts.obj" \
	".\WinRel\version.obj" \
	".\WinRel\waitpid.obj" \
	".\WinRel\watch.obj" \
	".\WinRel\woe32.obj" \
	".\WinRel\wrapper.obj" \
	".\WinRel\xgetwd.obj" \
	"$(INTDIR)\xmalloc.obj" \
	"$(INTDIR)\xstrdup.obj" \
	".\WinRel\yesno.obj" \
	".\WinRel\zlib.obj" \
	".\diff\WinRel\libdiff.lib" \
	".\zlib\WinRel\zlib.lib" \
	".\LIB\WinRel\libcvs.lib"

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

ALL : "LIB - Win32 Debug" "zlib - Win32 Debug" "libdiff - Win32 Debug" "$(OUTDIR)\cvs.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libdiff - Win32 DebugCLEAN" "zlib - Win32 DebugCLEAN" "LIB - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\asnprintf.obj"
	-@erase "$(INTDIR)\vasnprintf.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
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

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR)\cvsnt.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cvsnt.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib zlib\WinDebug\zlib.lib diff\WinDebug\libdiff.lib lib\WinDebug\libcvs.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\cvs.pdb" /debug /machine:I386 /nodefaultlib:"libcmtd.lib" /out:"$(OUTDIR)\cvs.exe" 
LINK32_OBJS= \
	".\WinDebug\add.obj" \
	".\WinDebug\admin.obj" \
	".\WinDebug\annotate.obj" \
	".\WinDebug\argmatch.obj" \
	"$(INTDIR)\asnprintf.obj" \
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
	"$(INTDIR)\vasnprintf.obj" \
	".\WinDebug\vers_ts.obj" \
	".\WinDebug\version.obj" \
	".\WinDebug\waitpid.obj" \
	".\WinDebug\watch.obj" \
	".\WinDebug\woe32.obj" \
	".\WinDebug\wrapper.obj" \
	".\WinDebug\xgetwd.obj" \
	"$(INTDIR)\xmalloc.obj" \
	"$(INTDIR)\xstrdup.obj" \
	".\WinDebug\yesno.obj" \
	".\WinDebug\zlib.obj" \
	".\diff\WinDebug\libdiff.lib" \
	".\zlib\WinDebug\zlib.lib" \
	".\LIB\WinDebug\libcvs.lib"

"$(OUTDIR)\cvs.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("cvsnt.dep")
!INCLUDE "cvsnt.dep"
!ELSE 
!MESSAGE Warning: cannot find "cvsnt.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "cvsnt - Win32 Release" || "$(CFG)" == "cvsnt - Win32 Debug"
SOURCE=.\src\add.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\add.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\add.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\admin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\admin.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\admin.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\annotate.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\annotate.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\annotate.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\argmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\argmatch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\argmatch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\asnprintf.c

"$(INTDIR)\asnprintf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\buffer.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\buffer.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\buffer.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkin.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\checkin.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\checkin.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\checkout.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\checkout.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\checkout.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\classify.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\classify.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\classify.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\client.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\commit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\commit.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\commit.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\create_adm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\create_adm.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\create_adm.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\cvsrc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\cvsrc.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\cvsrc.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\diff.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\diff.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\edit.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\edit.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\edit.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\entries.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\entries.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\entries.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\error.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\error.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\error.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\exithandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\exithandle.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\exithandle.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\expand_path.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\expand_path.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\expand_path.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\fileattr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\fileattr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\fileattr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\filesubr.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\filesubr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\filesubr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\find_names.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\find_names.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\find_names.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fncase.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\fncase.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\fncase.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fnmatch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\fnmatch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\fnmatch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\fseeko.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\fseeko.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\fseeko.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\ftello.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\ftello.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\ftello.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\hash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\hash.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\hash.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\history.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\history.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\history.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\ignore.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\ignore.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\ignore.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\import.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\import.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\import.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\lock.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\lock.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\lock.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\log-buffer.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\log-buffer.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\log-buffer.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\log.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\log.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\log.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\login.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\login.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\login.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\logmsg.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\logmsg.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\logmsg.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\main.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\main.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\main.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\md5.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\md5.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\md5.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\mkdir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\mkdir.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\mkdir.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\mkmodules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\mkmodules.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\mkmodules.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\modules.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\modules.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\modules.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\myndbm.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\myndbm.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\myndbm.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\ndir.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\ndir.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\ndir.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\no_diff.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\no_diff.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\no_diff.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\parseinfo.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\parseinfo.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\parseinfo.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\patch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\patch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\patch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\pwd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\pwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\pwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\rcmd.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\rcmd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\rcmd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcs.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\rcs.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\rcs.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\rcscmds.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\rcscmds.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\rcscmds.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\recurse.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\recurse.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\recurse.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\release.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\release.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\release.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\remove.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\remove.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\remove.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\repos.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\repos.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\repos.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\root.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\root.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\root.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\rsh-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\rsh-client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\rsh-client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\run.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\run.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\run.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\savecwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\savecwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\savecwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\scramble.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\scramble.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\scramble.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\server.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\server.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\server.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\sighandle.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\sighandle.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\sighandle.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\sockerror.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\sockerror.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\sockerror.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\src\socket-client.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\socket-client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\socket-client.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\stack.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\stack.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\stack.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\startserver.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\startserver.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\startserver.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\status.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\status.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\status.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\stripslash.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\stripslash.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\stripslash.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\subr.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\subr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\subr.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\tag.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\tag.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\tag.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\update.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\update.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\update.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\valloc.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\valloc.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\valloc.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\vasnprintf.c

"$(INTDIR)\vasnprintf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\src\vers_ts.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\vers_ts.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\vers_ts.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\version.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\version.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\version.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\waitpid.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\waitpid.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\waitpid.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\watch.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\watch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\watch.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=".\windows-NT\woe32.c"

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\woe32.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\woe32.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\wrapper.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\wrapper.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\wrapper.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\xgetwd.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\xgetwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\xgetwd.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\lib\xmalloc.c

"$(INTDIR)\xmalloc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\lib\xstrdup.c

"$(INTDIR)\xstrdup.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\lib\yesno.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\yesno.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\yesno.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\src\zlib.c

!IF  "$(CFG)" == "cvsnt - Win32 Release"

CPP_SWITCHES=/nologo /ML /W3 /GX /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /I ".\WinDebug" /D "NDEBUG" /D "WANT_WIN_COMPILER_VERSION" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /Fp"WinRel/cvsnt.pch" /YX /Fo"WinRel/" /Fd"WinRel/" /FD /c 

".\WinRel\zlib.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /W3 /Gm /GX /Zi /Ob1 /I ".\windows-NT" /I ".\lib" /I ".\src" /I ".\zlib" /I ".\diff" /D "_DEBUG" /D "_CONSOLE" /D "HAVE_CONFIG_H" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"WinDebug/cvsnt.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 

".\WinDebug\zlib.obj" : $(SOURCE)
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"libdiff - Win32 Release" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F ".\libdiff.mak" CFG="libdiff - Win32 Release" 
   cd ".."

"libdiff - Win32 ReleaseCLEAN" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F ".\libdiff.mak" CFG="libdiff - Win32 Release" RECURSE=1 CLEAN 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"libdiff - Win32 Debug" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F ".\libdiff.mak" CFG="libdiff - Win32 Debug" 
   cd ".."

"libdiff - Win32 DebugCLEAN" : 
   cd ".\diff"
   $(MAKE) /$(MAKEFLAGS) /F ".\libdiff.mak" CFG="libdiff - Win32 Debug" RECURSE=1 CLEAN 
   cd ".."

!ENDIF 

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"zlib - Win32 Release" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F ".\zlib.mak" CFG="zlib - Win32 Release" 
   cd ".."

"zlib - Win32 ReleaseCLEAN" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F ".\zlib.mak" CFG="zlib - Win32 Release" RECURSE=1 CLEAN 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"zlib - Win32 Debug" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F ".\zlib.mak" CFG="zlib - Win32 Debug" 
   cd ".."

"zlib - Win32 DebugCLEAN" : 
   cd ".\zlib"
   $(MAKE) /$(MAKEFLAGS) /F ".\zlib.mak" CFG="zlib - Win32 Debug" RECURSE=1 CLEAN 
   cd ".."

!ENDIF 

!IF  "$(CFG)" == "cvsnt - Win32 Release"

"LIB - Win32 Release" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F ".\LIB.mak" CFG="LIB - Win32 Release" 
   cd ".."

"LIB - Win32 ReleaseCLEAN" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F ".\LIB.mak" CFG="LIB - Win32 Release" RECURSE=1 CLEAN 
   cd ".."

!ELSEIF  "$(CFG)" == "cvsnt - Win32 Debug"

"LIB - Win32 Debug" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F ".\LIB.mak" CFG="LIB - Win32 Debug" 
   cd ".."

"LIB - Win32 DebugCLEAN" : 
   cd ".\LIB"
   $(MAKE) /$(MAKEFLAGS) /F ".\LIB.mak" CFG="LIB - Win32 Debug" RECURSE=1 CLEAN 
   cd ".."

!ENDIF 


!ENDIF 

