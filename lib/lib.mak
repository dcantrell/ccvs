# Microsoft Developer Studio Generated NMAKE File, Based on LIB.dsp
!IF "$(CFG)" == ""
CFG=LIB - Win32 Debug
!MESSAGE No configuration specified. Defaulting to LIB - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "LIB - Win32 Release" && "$(CFG)" != "LIB - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "LIB.mak" CFG="LIB - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "LIB - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "LIB - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "LIB - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"


CLEAN :
	-@erase "$(INTDIR)\alloca.obj"
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

CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "..\windows-NT" /I "." /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\LIB.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\LIB.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libcvs.lib" 
LIB32_OBJS= \
	"$(INTDIR)\alloca.obj" \
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

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"


CLEAN :
	-@erase "$(INTDIR)\alloca.obj"
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

CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /Gm /GX /ZI /Od /I "..\windows-NT" /I "." /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\LIB.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\LIB.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\libcvs.lib" 
LIB32_OBJS= \
	"$(INTDIR)\alloca.obj" \
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


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("LIB.dep")
!INCLUDE "LIB.dep"
!ELSE 
!MESSAGE Warning: cannot find "LIB.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "LIB - Win32 Release" || "$(CFG)" == "LIB - Win32 Debug"
SOURCE=.\alloca.c

"$(INTDIR)\alloca.obj" : $(SOURCE) "$(INTDIR)"


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

!IF  "$(CFG)" == "LIB - Win32 Release"

InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\alloca_.h .\alloca.h
<< 
	

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

InputPath=.\alloca_.h

".\alloca.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\alloca_.h .\alloca.h
<< 
	

!ENDIF 

SOURCE="..\lib\fnmatch_.h"

!IF  "$(CFG)" == "LIB - Win32 Release"

InputPath="..\lib\fnmatch_.h"

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\fnmatch_.h .\fnmatch.h
<< 
	

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

InputPath="..\lib\fnmatch_.h"

".\fnmatch.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy .\fnmatch_.h .\fnmatch.h
<< 
	

!ENDIF 


!ENDIF 

