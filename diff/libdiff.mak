# Microsoft Developer Studio Generated NMAKE File, Based on libdiff.dsp
!IF "$(CFG)" == ""
CFG=libdiff - Win32 Release
!MESSAGE No configuration specified. Defaulting to libdiff - Win32 Release.
!ENDIF 

!IF "$(CFG)" != "libdiff - Win32 Release" && "$(CFG)" !=\
 "libdiff - Win32 Debug"
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

!IF  "$(CFG)" == "libdiff - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\libdiff.lib"

!ELSE 

ALL : "LIB - Win32 Release" "$(OUTDIR)\libdiff.lib"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"LIB - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
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
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\version.obj"
	-@erase "$(OUTDIR)\libdiff.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "..\windows-NT" /I "..\lib" /D "_WINDOWS"\
 /D "HAVE_TIME_H" /D "CLOSEDIR_VOID" /D "NDEBUG" /D "WIN32" /D\
 "WANT_WIN_COMPILER_VERSION" /Fp"$(INTDIR)\libdiff.pch" /YX /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 
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
	"$(INTDIR)\version.obj" \
	"..\LIB\WinRel\libcvs.lib"

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

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\libdiff.lib"

!ELSE 

ALL : "LIB - Win32 Debug" "$(OUTDIR)\libdiff.lib"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"LIB - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
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
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\version.obj"
	-@erase "$(OUTDIR)\libdiff.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /I "..\windows-NT" /I "..\lib" /D\
 "_DEBUG" /D "_WINDOWS" /D "WIN32" /D "HAVE_TIME_H" /D "CLOSEDIR_VOID"\
 /Fp"$(INTDIR)\libdiff.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
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

BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\libdiff.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=..\lib\WinDebug\libcvs.lib /nologo /out:"$(OUTDIR)\libdiff.lib" 
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
	"$(INTDIR)\version.obj" \
	"..\LIB\WinDebug\libcvs.lib"

"$(OUTDIR)\libdiff.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ENDIF 


!IF "$(CFG)" == "libdiff - Win32 Release" || "$(CFG)" ==\
 "libdiff - Win32 Debug"
SOURCE=.\analyze.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_ANALY=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\cmpbuf.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\analyze.obj" : $(SOURCE) $(DEP_CPP_ANALY) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_ANALY=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\cmpbuf.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\analyze.obj" : $(SOURCE) $(DEP_CPP_ANALY) "$(INTDIR)"


!ENDIF 

SOURCE=.\cmpbuf.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_CMPBU=\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\cmpbuf.h"\
	".\system.h"\
	

"$(INTDIR)\cmpbuf.obj" : $(SOURCE) $(DEP_CPP_CMPBU) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_CMPBU=\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\cmpbuf.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\cmpbuf.obj" : $(SOURCE) $(DEP_CPP_CMPBU) "$(INTDIR)"


!ENDIF 

SOURCE=.\context.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_CONTE=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\context.obj" : $(SOURCE) $(DEP_CPP_CONTE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_CONTE=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\context.obj" : $(SOURCE) $(DEP_CPP_CONTE) "$(INTDIR)"


!ENDIF 

SOURCE=.\diff.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_DIFF_=\
	"..\lib\fnmatch.h"\
	"..\lib\getopt.h"\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_DIFF_=\
	"..\lib\fnmatch.h"\
	"..\lib\getopt.h"\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\diff.obj" : $(SOURCE) $(DEP_CPP_DIFF_) "$(INTDIR)"


!ENDIF 

SOURCE=.\diff3.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_DIFF3=\
	"..\lib\getopt.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\diff3.obj" : $(SOURCE) $(DEP_CPP_DIFF3) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_DIFF3=\
	"..\lib\getopt.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\diff3.obj" : $(SOURCE) $(DEP_CPP_DIFF3) "$(INTDIR)"


!ENDIF 

SOURCE=.\dir.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_DIR_C=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\dir.obj" : $(SOURCE) $(DEP_CPP_DIR_C) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_DIR_C=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\dir.obj" : $(SOURCE) $(DEP_CPP_DIR_C) "$(INTDIR)"


!ENDIF 

SOURCE=.\ed.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_ED_Cc=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\ed.obj" : $(SOURCE) $(DEP_CPP_ED_Cc) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_ED_Cc=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\ed.obj" : $(SOURCE) $(DEP_CPP_ED_Cc) "$(INTDIR)"


!ENDIF 

SOURCE=.\ifdef.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_IFDEF=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\ifdef.obj" : $(SOURCE) $(DEP_CPP_IFDEF) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_IFDEF=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\ifdef.obj" : $(SOURCE) $(DEP_CPP_IFDEF) "$(INTDIR)"


!ENDIF 

SOURCE=.\io.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_IO_C10=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\io.obj" : $(SOURCE) $(DEP_CPP_IO_C10) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_IO_C10=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\io.obj" : $(SOURCE) $(DEP_CPP_IO_C10) "$(INTDIR)"


!ENDIF 

SOURCE=.\normal.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_NORMA=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\normal.obj" : $(SOURCE) $(DEP_CPP_NORMA) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_NORMA=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\normal.obj" : $(SOURCE) $(DEP_CPP_NORMA) "$(INTDIR)"


!ENDIF 

SOURCE=.\side.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_SIDE_=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\side.obj" : $(SOURCE) $(DEP_CPP_SIDE_) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_SIDE_=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\side.obj" : $(SOURCE) $(DEP_CPP_SIDE_) "$(INTDIR)"


!ENDIF 

SOURCE=.\util.c

!IF  "$(CFG)" == "libdiff - Win32 Release"

DEP_CPP_UTIL_=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	

"$(INTDIR)\util.obj" : $(SOURCE) $(DEP_CPP_UTIL_) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

DEP_CPP_UTIL_=\
	"..\LIB\regex.h"\
	"..\windows-NT\config.h"\
	"..\windows-NT\ndir.h"\
	".\diff.h"\
	".\diffrun.h"\
	".\system.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\util.obj" : $(SOURCE) $(DEP_CPP_UTIL_) "$(INTDIR)"


!ENDIF 

SOURCE=.\version.c
DEP_CPP_VERSI=\
	"..\windows-NT\config.h"\
	

"$(INTDIR)\version.obj" : $(SOURCE) $(DEP_CPP_VERSI) "$(INTDIR)"


!IF  "$(CFG)" == "libdiff - Win32 Release"

"LIB - Win32 Release" : 
   cd "..\LIB"
   $(MAKE) /$(MAKEFLAGS) /F .\LIB.mak CFG="LIB - Win32 Release" 
   cd "..\diff"

"LIB - Win32 ReleaseCLEAN" : 
   cd "..\LIB"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\LIB.mak CFG="LIB - Win32 Release" RECURSE=1\
 
   cd "..\diff"

!ELSEIF  "$(CFG)" == "libdiff - Win32 Debug"

"LIB - Win32 Debug" : 
   cd "..\LIB"
   $(MAKE) /$(MAKEFLAGS) /F .\LIB.mak CFG="LIB - Win32 Debug" 
   cd "..\diff"

"LIB - Win32 DebugCLEAN" : 
   cd "..\LIB"
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\LIB.mak CFG="LIB - Win32 Debug" RECURSE=1 
   cd "..\diff"

!ENDIF 


!ENDIF 

