# Microsoft Developer Studio Generated NMAKE File, Based on zlib.dsp
!IF "$(CFG)" == ""
CFG=zlib - Win32 Debug
!MESSAGE No configuration specified. Defaulting to zlib - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "zlib - Win32 Release" && "$(CFG)" != "zlib - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "zlib.mak" CFG="zlib - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "zlib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "zlib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "zlib - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\zlib.lib"

!ELSE 

ALL : "$(OUTDIR)\zlib.lib"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\compress.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\example.obj"
	-@erase "$(INTDIR)\gzio.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\minigzip.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\uncompr.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\zlib.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)\zlib.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\zlib.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\zlib.lib" 
LIB32_OBJS= \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\compress.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\example.obj" \
	"$(INTDIR)\gzio.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\minigzip.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\uncompr.obj" \
	"$(INTDIR)\zutil.obj"

"$(OUTDIR)\zlib.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

OUTDIR=.\WinDebug
INTDIR=.\WinDebug
# Begin Custom Macros
OutDir=.\WinDebug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\zlib.lib"

!ELSE 

ALL : "$(OUTDIR)\zlib.lib"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\zlib.lib"
	-@erase ".\WinDebug\adler32.obj"
	-@erase ".\WinDebug\compress.obj"
	-@erase ".\WinDebug\crc32.obj"
	-@erase ".\WinDebug\deflate.obj"
	-@erase ".\WinDebug\example.obj"
	-@erase ".\WinDebug\gzio.obj"
	-@erase ".\WinDebug\infblock.obj"
	-@erase ".\WinDebug\infcodes.obj"
	-@erase ".\WinDebug\inffast.obj"
	-@erase ".\WinDebug\inflate.obj"
	-@erase ".\WinDebug\inftrees.obj"
	-@erase ".\WinDebug\infutil.obj"
	-@erase ".\WinDebug\minigzip.obj"
	-@erase ".\WinDebug\trees.obj"
	-@erase ".\WinDebug\uncompr.obj"
	-@erase ".\WinDebug\zutil.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

RSC=rc.exe
CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)\zlib.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\zlib.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\zlib.lib" 
LIB32_OBJS= \
	".\WinDebug\adler32.obj" \
	".\WinDebug\compress.obj" \
	".\WinDebug\crc32.obj" \
	".\WinDebug\deflate.obj" \
	".\WinDebug\example.obj" \
	".\WinDebug\gzio.obj" \
	".\WinDebug\infblock.obj" \
	".\WinDebug\infcodes.obj" \
	".\WinDebug\inffast.obj" \
	".\WinDebug\inflate.obj" \
	".\WinDebug\inftrees.obj" \
	".\WinDebug\infutil.obj" \
	".\WinDebug\minigzip.obj" \
	".\WinDebug\trees.obj" \
	".\WinDebug\uncompr.obj" \
	".\WinDebug\zutil.obj"

"$(OUTDIR)\zlib.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ENDIF 


!IF "$(CFG)" == "zlib - Win32 Release" || "$(CFG)" == "zlib - Win32 Debug"
SOURCE=.\adler32.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_ADLER=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\adler32.obj" : $(SOURCE) $(DEP_CPP_ADLER) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_ADLER=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\adler32.obj" : $(SOURCE) $(DEP_CPP_ADLER) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\compress.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_COMPR=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\compress.obj" : $(SOURCE) $(DEP_CPP_COMPR) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_COMPR=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\compress.obj" : $(SOURCE) $(DEP_CPP_COMPR) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\crc32.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_CRC32=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\crc32.obj" : $(SOURCE) $(DEP_CPP_CRC32) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_CRC32=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\crc32.obj" : $(SOURCE) $(DEP_CPP_CRC32) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\deflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_DEFLA=\
	".\deflate.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\deflate.obj" : $(SOURCE) $(DEP_CPP_DEFLA) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_DEFLA=\
	".\deflate.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\deflate.obj" : $(SOURCE) $(DEP_CPP_DEFLA) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\example.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_EXAMP=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\example.obj" : $(SOURCE) $(DEP_CPP_EXAMP) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_EXAMP=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\example.obj" : $(SOURCE) $(DEP_CPP_EXAMP) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\gzio.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_GZIO_=\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\gzio.obj" : $(SOURCE) $(DEP_CPP_GZIO_) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_GZIO_=\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\gzio.obj" : $(SOURCE) $(DEP_CPP_GZIO_) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\infblock.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFBL=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\infblock.obj" : $(SOURCE) $(DEP_CPP_INFBL) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFBL=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\infblock.obj" : $(SOURCE) $(DEP_CPP_INFBL) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\infcodes.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFCO=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inffast.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\infcodes.obj" : $(SOURCE) $(DEP_CPP_INFCO) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFCO=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inffast.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\infcodes.obj" : $(SOURCE) $(DEP_CPP_INFCO) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\inffast.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFFA=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inffast.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\inffast.obj" : $(SOURCE) $(DEP_CPP_INFFA) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFFA=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inffast.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\inffast.obj" : $(SOURCE) $(DEP_CPP_INFFA) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\inflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFLA=\
	".\infblock.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\inflate.obj" : $(SOURCE) $(DEP_CPP_INFLA) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFLA=\
	".\infblock.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\inflate.obj" : $(SOURCE) $(DEP_CPP_INFLA) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\inftrees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFTR=\
	".\inffixed.h"\
	".\inftrees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\inftrees.obj" : $(SOURCE) $(DEP_CPP_INFTR) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFTR=\
	".\inffixed.h"\
	".\inftrees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\inftrees.obj" : $(SOURCE) $(DEP_CPP_INFTR) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\infutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFUT=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\infutil.obj" : $(SOURCE) $(DEP_CPP_INFUT) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFUT=\
	".\infblock.h"\
	".\infcodes.h"\
	".\inftrees.h"\
	".\infutil.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\infutil.obj" : $(SOURCE) $(DEP_CPP_INFUT) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\minigzip.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_MINIG=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\minigzip.obj" : $(SOURCE) $(DEP_CPP_MINIG) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_MINIG=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\minigzip.obj" : $(SOURCE) $(DEP_CPP_MINIG) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\trees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_TREES=\
	".\deflate.h"\
	".\trees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\trees.obj" : $(SOURCE) $(DEP_CPP_TREES) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_TREES=\
	".\deflate.h"\
	".\trees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\trees.obj" : $(SOURCE) $(DEP_CPP_TREES) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\uncompr.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_UNCOM=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\uncompr.obj" : $(SOURCE) $(DEP_CPP_UNCOM) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_UNCOM=\
	".\zconf.h"\
	".\zlib.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\uncompr.obj" : $(SOURCE) $(DEP_CPP_UNCOM) "$(INTDIR_SRC)"


!ENDIF 

SOURCE=.\zutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_ZUTIL=\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\zutil.obj" : $(SOURCE) $(DEP_CPP_ZUTIL) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_ZUTIL=\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	{$(INCLUDE)}"sys\types.h"\
	
INTDIR_SRC=.\WinDebug

".\WinDebug\zutil.obj" : $(SOURCE) $(DEP_CPP_ZUTIL) "$(INTDIR_SRC)"


!ENDIF 


!ENDIF 

