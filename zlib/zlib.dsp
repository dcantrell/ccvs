# Microsoft Developer Studio Project File - Name="zlib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=zlib - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "zlib.mak".
!MESSAGE 
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

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "zlib - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /Fp"WinDebug/zlib.pch" /YX /Fo"WinDebug/" /Fd"WinDebug/" /FD /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"WinDebug/zlib.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"WinDebug\zlib.lib"

!ENDIF 

# Begin Target

# Name "zlib - Win32 Release"
# Name "zlib - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "*.c"
# Begin Source File

SOURCE=.\adler32.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\compress.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\crc32.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\deflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\example.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\gzio.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\infblock.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\infcodes.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\inffast.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\inflate.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\inftrees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\infutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\minigzip.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\trees.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\uncompr.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\zutil.c

!IF  "$(CFG)" == "zlib - Win32 Release"

!ELSEIF  "$(CFG)" == "zlib - Win32 Debug"

# PROP Intermediate_Dir "WinDebug"

!ENDIF 

# End Source File
# End Group
# End Target
# End Project
