# Microsoft Developer Studio Generated NMAKE File, Based on libdiff.dsp
!IF "$(CFG)" == ""
CFG=libdiff - Win32 Release
!MESSAGE No configuration specified. Defaulting to libdiff - Win32 Release.
!ENDIF 

!IF "$(CFG)" != "libdiff - Win32 Release" && "$(CFG)" != "libdiff - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libdiff.mak" CFG="libdiff - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libdiff - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libdiff - Win32 Debug" (based on "Win32 (x86) Static Library")
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

!IF  "$(CFG)" == "libdiff - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

ALL : "$(OUTDIR)\libdiff.lib"


CLEAN :
	-@erase "$(INTDIR)\analyze.obj"
	-@erase "$(INTDIR)\cmpbuf.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\diff.obj"
	-@erase "$(INTDIR)\diff3.obj"
	-@erase "$(INTDIR)\dir.obj"
	-@erase "$(INTDIR)\ed.obj"
	-@erase "$(INTDIR)\ifdef.obj"
	-@erase "$(INTDIR)\io.obj"
	-@erase "$(INTDIR)\normal.obj"
	-@erase "$(INTDIR)\side.obj"
	-@erase "$(INTDIR)\util.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\version.obj"
	-@erase "$(OUTDIR)\libdiff.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "..\windows-NT" /I "..\lib" /D "_WINDOWS" /D "HAVE_TIME_H" /D "CLOSEDIR_VOID" /D "NDEBUG" /D "WIN32" /D "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR)\libdiff.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\libdiff.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libdiff.lib" 
LIB32_OBJS= \
	"$(INTDIR)\analyze.obj" \
	"$(INTDIR)\cmpbuf.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\diff.obj" \
	"$(INTDIR)\diff3.obj" \
	"$(INTDIR)\dir.obj" \
	"$(INTDIR)\ed.obj" \
	"$(INTDIR)\ifdef.obj" \
	"$(INTDIR)\io.obj" \
	"$(INTDIR)\normal.obj" \
	"$(INTDIR)\side.obj" \
	"$(INTDIR)\util.obj" \
	"$(INTDIR)\version.obj"

"$(OUTDIR)\libdiff.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

ALL : "$(OUTDIR)\libdiff.lib"


CLEAN :
	-@erase "$(INTDIR)\analyze.obj"
	-@erase "$(INTDIR)\cmpbuf.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\diff.obj"
	-@erase "$(INTDIR)\diff3.obj"
	-@erase "$(INTDIR)\dir.obj"
	-@erase "$(INTDIR)\ed.obj"
	-@erase "$(INTDIR)\ifdef.obj"
	-@erase "$(INTDIR)\io.obj"
	-@erase "$(INTDIR)\normal.obj"
	-@erase "$(INTDIR)\side.obj"
	-@erase "$(INTDIR)\util.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\version.obj"
	-@erase "$(OUTDIR)\libdiff.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /I "..\windows-NT" /I "..\lib" /I ".\WinDebug" /D "_DEBUG" /D "_WINDOWS" /D "WIN32" /D "HAVE_TIME_H" /D "CLOSEDIR_VOID" /Fp"$(INTDIR)\libdiff.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\libdiff.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libdiff.lib" 
LIB32_OBJS= \
	"$(INTDIR)\version.obj" \
	"$(INTDIR)\util.obj" \
	"$(INTDIR)\side.obj" \
	"$(INTDIR)\normal.obj" \
	"$(INTDIR)\io.obj" \
	"$(INTDIR)\ifdef.obj" \
	"$(INTDIR)\ed.obj" \
	"$(INTDIR)\dir.obj" \
	"$(INTDIR)\diff3.obj" \
	"$(INTDIR)\diff.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\cmpbuf.obj" \
	"$(INTDIR)\analyze.obj"

"$(OUTDIR)\libdiff.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
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
!IF EXISTS("libdiff.dep")
!INCLUDE "libdiff.dep"
!ELSE 
!MESSAGE Warning: cannot find "libdiff.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "libdiff - Win32 Release" || "$(CFG)" == "libdiff - Win32 Debug"
SOURCE=.\analyze.c

"$(INTDIR)\analyze.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\cmpbuf.c

"$(INTDIR)\cmpbuf.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\context.c

"$(INTDIR)\context.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\diff.c

"$(INTDIR)\diff.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\diff3.c

"$(INTDIR)\diff3.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\dir.c

"$(INTDIR)\dir.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\ed.c

"$(INTDIR)\ed.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=..\WinDebug\fnmatch.h

!IF  "$(CFG)" == "libdiff - Win32 Release"

!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

InputPath=..\WinDebug\fnmatch.h
USERDEP__FNMAT="..\lib\fnmatch.h.in"	

"$(INTDIR)\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)" $(USERDEP__FNMAT)
	<<tempfile.bat 
	@echo off 
	copy "..\lib\fnmatch.h.in" ".\WinDebug\fnmatch.h"
<< 
	

!ENDIF 

SOURCE=.\ifdef.c

"$(INTDIR)\ifdef.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\io.c

"$(INTDIR)\io.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\normal.c

"$(INTDIR)\normal.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\side.c

"$(INTDIR)\side.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\util.c

"$(INTDIR)\util.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\version.c

"$(INTDIR)\version.obj" : $(SOURCE) "$(INTDIR)"



!ENDIF 

