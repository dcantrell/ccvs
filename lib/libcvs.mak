# Microsoft Developer Studio Generated NMAKE File, Based on libcvs.dsp
!IF "$(CFG)" == ""
CFG=libcvs - Win32 Debug
!MESSAGE No configuration specified. Defaulting to libcvs - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "libcvs - Win32 Release" && "$(CFG)" != "libcvs - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
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
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libcvs - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"


CLEAN :
	-@erase "$(INTDIR)\exitfail.obj"
	-@erase "$(INTDIR)\getdate.obj"
	-@erase "$(INTDIR)\getline.obj"
	-@erase "$(INTDIR)\getndelim2.obj"
	-@erase "$(INTDIR)\getopt.obj"
	-@erase "$(INTDIR)\getopt1.obj"
	-@erase "$(INTDIR)\printf-args.obj"
	-@erase "$(INTDIR)\printf-parse.obj"
	-@erase "$(INTDIR)\realloc.obj"
	-@erase "$(INTDIR)\regex.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\libcvs.lib"
	-@erase ".\alloca.h"
	-@erase ".\fnmatch.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "..\windows-NT" /I "." /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\libcvs.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\libcvs.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libcvs.lib" 
LIB32_OBJS= \
	"$(INTDIR)\exitfail.obj" \
	"$(INTDIR)\getdate.obj" \
	"$(INTDIR)\getline.obj" \
	"$(INTDIR)\getndelim2.obj" \
	"$(INTDIR)\getopt.obj" \
	"$(INTDIR)\getopt1.obj" \
	"$(INTDIR)\printf-args.obj" \
	"$(INTDIR)\printf-parse.obj" \
	"$(INTDIR)\realloc.obj" \
	"$(INTDIR)\regex.obj"

"$(OUTDIR)\libcvs.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"


CLEAN :
	-@erase "$(INTDIR)\exitfail.obj"
	-@erase "$(INTDIR)\getdate.obj"
	-@erase "$(INTDIR)\getline.obj"
	-@erase "$(INTDIR)\getndelim2.obj"
	-@erase "$(INTDIR)\getopt.obj"
	-@erase "$(INTDIR)\getopt1.obj"
	-@erase "$(INTDIR)\printf-args.obj"
	-@erase "$(INTDIR)\printf-parse.obj"
	-@erase "$(INTDIR)\realloc.obj"
	-@erase "$(INTDIR)\regex.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\libcvs.lib"
	-@erase ".\alloca.h"
	-@erase ".\fnmatch.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /ZI /Od /I "..\windows-NT" /I "." /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\libcvs.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\libcvs.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libcvs.lib" 
LIB32_OBJS= \
	"$(INTDIR)\exitfail.obj" \
	"$(INTDIR)\getdate.obj" \
	"$(INTDIR)\getline.obj" \
	"$(INTDIR)\getndelim2.obj" \
	"$(INTDIR)\getopt.obj" \
	"$(INTDIR)\getopt1.obj" \
	"$(INTDIR)\printf-args.obj" \
	"$(INTDIR)\printf-parse.obj" \
	"$(INTDIR)\realloc.obj" \
	"$(INTDIR)\regex.obj"

"$(OUTDIR)\libcvs.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
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
!IF EXISTS("libcvs.dep")
!INCLUDE "libcvs.dep"
!ELSE 
!MESSAGE Warning: cannot find "libcvs.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "libcvs - Win32 Release" || "$(CFG)" == "libcvs - Win32 Debug"
SOURCE=.\exitfail.c

"$(INTDIR)\exitfail.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\getdate.c

"$(INTDIR)\getdate.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\getline.c

"$(INTDIR)\getline.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\getndelim2.c

"$(INTDIR)\getndelim2.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\getopt.c

"$(INTDIR)\getopt.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\getopt1.c

"$(INTDIR)\getopt1.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=".\printf-args.c"

"$(INTDIR)\printf-args.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=".\printf-parse.c"

"$(INTDIR)\printf-parse.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\realloc.c

"$(INTDIR)\realloc.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\regex.c

"$(INTDIR)\regex.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\alloca_.h

!IF  "$(CFG)" == "libcvs - Win32 Release"

InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\alloca_.h .\alloca.h
<< 
	

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\alloca_.h .\alloca.h
<< 
	

!ENDIF 

SOURCE=.\fnmatch_.h

!IF  "$(CFG)" == "libcvs - Win32 Release"

InputPath=.\fnmatch_.h

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\fnmatch_.h .\fnmatch.h
<< 
	

!ELSEIF  "$(CFG)" == "libcvs - Win32 Debug"

InputPath=.\fnmatch_.h

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\fnmatch_.h .\fnmatch.h
<< 
	

!ENDIF 


!ENDIF 

