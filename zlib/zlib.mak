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
RSC=rc.exe

!IF  "$(CFG)" == "zlib - Win32 Release"

OUTDIR=.\WinRel
INTDIR=.\WinRel
# Begin Custom Macros
OutDir=.\WinRel
# End Custom Macros

ALL : "$(OUTDIR)\zlib.lib"


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
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\zlib.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /Fp"$(INTDIR)\zlib.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
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

ALL : ".\WinDebug\zlib.lib"


CLEAN :
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
	-@erase ".\WinDebug\vc60.idb"
	-@erase ".\WinDebug\zlib.lib"
	-@erase ".\WinDebug\zutil.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /Fp"WinDebug/zlib.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"WinDebug/zlib.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"WinDebug\zlib.lib" 
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

".\WinDebug\zlib.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
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
!IF EXISTS("zlib.dep")
!INCLUDE "zlib.dep"
!ELSE 
!MESSAGE Warning: cannot find "zlib.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "zlib - Win32 Release" || "$(CFG)" == "zlib - Win32 Debug"
SOURCE=.\adler32.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\adler32.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\adler32.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\compress.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\compress.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\compress.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\crc32.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\crc32.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\crc32.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\deflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\deflate.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\example.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\example.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\example.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\gzio.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\gzio.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\gzio.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\infblock.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\infblock.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\infblock.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\infcodes.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\infcodes.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\infcodes.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\inffast.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\inffast.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\inffast.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\inflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\inflate.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\inflate.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\inftrees.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\inftrees.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\inftrees.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\infutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\infutil.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\infutil.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\minigzip.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\minigzip.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\minigzip.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\trees.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\trees.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\trees.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\uncompr.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\uncompr.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\uncompr.obj" : $(SOURCE)


!ENDIF 

SOURCE=.\zutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"


"$(INTDIR)\zutil.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"


".\WinDebug\zutil.obj" : $(SOURCE)


!ENDIF 


!ENDIF 

