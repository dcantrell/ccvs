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

CPP=cl.exe

!IF  "$(CFG)" == "zlib - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
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

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)\zlib.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
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

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
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

CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)\zlib.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
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
	

"$(INTDIR)\adler32.obj" : $(SOURCE) $(DEP_CPP_ADLER) "$(INTDIR)"


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
	

"$(INTDIR)\compress.obj" : $(SOURCE) $(DEP_CPP_COMPR) "$(INTDIR)"


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
	

"$(INTDIR)\crc32.obj" : $(SOURCE) $(DEP_CPP_CRC32) "$(INTDIR)"


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
	

"$(INTDIR)\deflate.obj" : $(SOURCE) $(DEP_CPP_DEFLA) "$(INTDIR)"


!ENDIF 

SOURCE=.\example.c
DEP_CPP_EXAMP=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\example.obj" : $(SOURCE) $(DEP_CPP_EXAMP) "$(INTDIR)"


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
	

"$(INTDIR)\gzio.obj" : $(SOURCE) $(DEP_CPP_GZIO_) "$(INTDIR)"


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
	

"$(INTDIR)\infblock.obj" : $(SOURCE) $(DEP_CPP_INFBL) "$(INTDIR)"


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
	

"$(INTDIR)\infcodes.obj" : $(SOURCE) $(DEP_CPP_INFCO) "$(INTDIR)"


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
	

"$(INTDIR)\inffast.obj" : $(SOURCE) $(DEP_CPP_INFFA) "$(INTDIR)"


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
	

"$(INTDIR)\inflate.obj" : $(SOURCE) $(DEP_CPP_INFLA) "$(INTDIR)"


!ENDIF 

SOURCE=.\inftrees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_INFTR=\
	".\inftrees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\inftrees.obj" : $(SOURCE) $(DEP_CPP_INFTR) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_INFTR=\
	".\inftrees.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\inftrees.obj" : $(SOURCE) $(DEP_CPP_INFTR) "$(INTDIR)"


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
	

"$(INTDIR)\infutil.obj" : $(SOURCE) $(DEP_CPP_INFUT) "$(INTDIR)"


!ENDIF 

SOURCE=.\minigzip.c
DEP_CPP_MINIG=\
	".\zconf.h"\
	".\zlib.h"\
	

"$(INTDIR)\minigzip.obj" : $(SOURCE) $(DEP_CPP_MINIG) "$(INTDIR)"


SOURCE=.\trees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

DEP_CPP_TREES=\
	".\deflate.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\trees.obj" : $(SOURCE) $(DEP_CPP_TREES) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

DEP_CPP_TREES=\
	".\deflate.h"\
	".\zconf.h"\
	".\zlib.h"\
	".\zutil.h"\
	

"$(INTDIR)\trees.obj" : $(SOURCE) $(DEP_CPP_TREES) "$(INTDIR)"


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
	

"$(INTDIR)\uncompr.obj" : $(SOURCE) $(DEP_CPP_UNCOM) "$(INTDIR)"


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
	

"$(INTDIR)\zutil.obj" : $(SOURCE) $(DEP_CPP_ZUTIL) "$(INTDIR)"


!ENDIF 


!ENDIF 

