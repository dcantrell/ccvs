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

!IF "$(RECURSE)" == "0" 

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"

!ELSE 

ALL : ".\fnmatch.h" ".\alloca.h" "$(OUTDIR)\libcvs.lib"

!ENDIF 

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
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\libcvs.lib"
	-@erase ".\alloca.h"
	-@erase ".\fnmatch.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "..\windows-NT" /I "." /D "WIN32" /D\
 "NDEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\LIB.pch" /YX\
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

BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\LIB.bsc" 
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

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : ".\fnmatch.h" "$(OUTDIR)\libcvs.lib"

!ELSE 

ALL : ".\fnmatch.h" "$(OUTDIR)\libcvs.lib"

!ENDIF 

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
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\libcvs.lib"
	-@erase ".\fnmatch.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /GX /Od /I "..\windows-NT" /I "." /D "WIN32" /D\
 "_DEBUG" /D "_MBCS" /D "_LIB" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\LIB.pch" /YX\
 /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /ZI /GZ /c 
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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\LIB.bsc" 
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


!IF "$(CFG)" == "LIB - Win32 Release" || "$(CFG)" == "LIB - Win32 Debug"
SOURCE=.\exitfail.c
DEP_CPP_EXITF=\
	"..\windows-NT\config.h"\
	".\exit.h"\
	".\exitfail.h"\
	

"$(INTDIR)\exitfail.obj" : $(SOURCE) $(DEP_CPP_EXITF) "$(INTDIR)"


SOURCE=.\getdate.c

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_GETDA=\
	"..\windows-NT\config.h"\
	".\xtime.h"\
	

"$(INTDIR)\getdate.obj" : $(SOURCE) $(DEP_CPP_GETDA) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_GETDA=\
	"..\windows-NT\config.h"\
	".\xtime.h"\
	{$(INCLUDE)}"sys\timeb.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\getdate.obj" : $(SOURCE) $(DEP_CPP_GETDA) "$(INTDIR)"


!ENDIF 

SOURCE=.\getline.c

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_GETLI=\
	"..\windows-NT\config.h"\
	".\getline.h"\
	".\getndelim2.h"\
	

"$(INTDIR)\getline.obj" : $(SOURCE) $(DEP_CPP_GETLI) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_GETLI=\
	"..\windows-NT\config.h"\
	".\getline.h"\
	".\getndelim2.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\getline.obj" : $(SOURCE) $(DEP_CPP_GETLI) "$(INTDIR)"


!ENDIF 

SOURCE=.\getndelim2.c

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_GETND=\
	"..\windows-NT\config.h"\
	".\getndelim2.h"\
	".\unlocked-io.h"\
	

"$(INTDIR)\getndelim2.obj" : $(SOURCE) $(DEP_CPP_GETND) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_GETND=\
	"..\windows-NT\config.h"\
	".\getndelim2.h"\
	".\unlocked-io.h"\
	{$(INCLUDE)}"sys\types.h"\
	

"$(INTDIR)\getndelim2.obj" : $(SOURCE) $(DEP_CPP_GETND) "$(INTDIR)"


!ENDIF 

SOURCE=.\getopt.c

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_GETOP=\
	"..\windows-NT\config.h"\
	".\getopt.h"\
	".\gettext.h"\
	

"$(INTDIR)\getopt.obj" : $(SOURCE) $(DEP_CPP_GETOP) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_GETOP=\
	"..\windows-NT\config.h"\
	".\getopt.h"\
	".\gettext.h"\
	

"$(INTDIR)\getopt.obj" : $(SOURCE) $(DEP_CPP_GETOP) "$(INTDIR)"


!ENDIF 

SOURCE=.\getopt1.c
DEP_CPP_GETOPT=\
	"..\windows-NT\config.h"\
	".\getopt.h"\
	

"$(INTDIR)\getopt1.obj" : $(SOURCE) $(DEP_CPP_GETOPT) "$(INTDIR)"


SOURCE=".\printf-args.c"

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_PRINT=\
	"..\windows-NT\config.h"\
	".\printf-args.h"\
	

"$(INTDIR)\printf-args.obj" : $(SOURCE) $(DEP_CPP_PRINT) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_PRINT=\
	"..\windows-NT\config.h"\
	".\printf-args.h"\
	

"$(INTDIR)\printf-args.obj" : $(SOURCE) $(DEP_CPP_PRINT) "$(INTDIR)"


!ENDIF 

SOURCE=".\printf-parse.c"

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_PRINTF=\
	"..\windows-NT\config.h"\
	".\printf-args.h"\
	".\printf-parse.h"\
	".\xsize.h"\
	

"$(INTDIR)\printf-parse.obj" : $(SOURCE) $(DEP_CPP_PRINTF) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_PRINTF=\
	"..\windows-NT\config.h"\
	".\printf-args.h"\
	".\printf-parse.h"\
	".\xsize.h"\
	
NODEP_CPP_PRINTF=\
	".\wprintf-parse.h"\
	

"$(INTDIR)\printf-parse.obj" : $(SOURCE) $(DEP_CPP_PRINTF) "$(INTDIR)"


!ENDIF 

SOURCE=.\realloc.c
DEP_CPP_REALL=\
	"..\windows-NT\config.h"\
	

"$(INTDIR)\realloc.obj" : $(SOURCE) $(DEP_CPP_REALL) "$(INTDIR)"


SOURCE=.\regex.c

!IF  "$(CFG)" == "LIB - Win32 Release"

DEP_CPP_REGEX=\
	"..\windows-NT\config.h"\
	".\regex.h"\
	

"$(INTDIR)\regex.obj" : $(SOURCE) $(DEP_CPP_REGEX) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

DEP_CPP_REGEX=\
	"..\windows-NT\config.h"\
	".\alloca.h"\
	".\regex.h"\
	{$(INCLUDE)}"sys\types.h"\
	
NODEP_CPP_REGEX=\
	".\buffer.h"\
	".\category.h"\
	".\charset.h"\
	".\lisp.h"\
	".\syntax.h"\
	

"$(INTDIR)\regex.obj" : $(SOURCE) $(DEP_CPP_REGEX) "$(INTDIR)" ".\alloca.h"


!ENDIF 

SOURCE=.\alloca_.h

!IF  "$(CFG)" == "LIB - Win32 Release"

InputPath=.\alloca_.h

".\alloca.h"	 : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\alloca_.h .\alloca.h

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

InputPath=.\alloca_.h

".\alloca.h"	 : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\alloca_.h .\alloca.h

!ENDIF 

SOURCE="..\lib\fnmatch.h.in"

!IF  "$(CFG)" == "LIB - Win32 Release"

InputPath=.\fnmatch.h.in

".\fnmatch.h"	 : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\fnmatch.h.in .\fnmatch.h

!ELSEIF  "$(CFG)" == "LIB - Win32 Debug"

InputPath=.\fnmatch.h.in

".\fnmatch.h"	 : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	copy .\fnmatch.h.in .\fnmatch.h

!ENDIF 


!ENDIF 

