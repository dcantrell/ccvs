#########################################################
##
##	TCPIP.MAK	- Include file for TCPIP stuff
##
##				Use .include $(TCPIP_MAK)
##
##	$Revision$
##
#########################################################


##
##	Setup the tcp/ip stuff
##
##	Legal values for TCPIP_VERSION
##		IBM_		- 16 bit IBM			(default for MICROSOFT compiler)
##		IBM_32		- 32 bit IBM			(default for IBM C compiler)
##

##
##	Example usage
##
##		SRV_TCP.IBM_    = srv_ibm.dll
##		SRV_TCP.IBM_32  = srv_ibm.dll
##		SRV_TCP_DLL		= $(SRV_TCP.$(TCPIP_VERSION))

%if !%defined(TCPIP_VERSION)
	TCPIP_VERSION = IBM_$(BITS)
%endif

%if $(TCPIP_VERSION)=="LANWP"
%echo NOVELL LAN-WORKPLACE no longer supported
any:
		%abort 1

%elseif $(TCPIP_VERSION)=="IBM_"
%echo USING IBM 16 BIT TCP/IP
TCPIPLIB = s:\ibmtcp16\lib\tcpipdll.lib	porttcp.lib
RPCLIB   = s:\ibmtcp16\lib\rpcdll.lib
FTPLIB   = s:\ibmtcp16\lib\ftpapi.lib
CFLAGS 	 += -DTCPIP_IBM -Is:\ibmtcp16\include

%elseif $(TCPIP_VERSION)=="IBM_32"
%echo USING IBM 32 BIT TCP/IP
TCPIPLIB = s:\ibmtcpip\lib\tcp32dll.lib	s:\ibmtcpip\lib\so32dll.lib porttcp.lib
RPCLIB   = s:\ibmtcpip\lib\rpc32dll.lib
FTPLIB   = s:\ibmtcpip\lib\ftpapi.lib
CFLAGS 	 += -DTCPIP_IBM -Is:\ibmtcpip\include

%endif
