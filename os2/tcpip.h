/****************************************************************
 *
 * TCPIP.H - Portable TCP/IP header file
 *
 * TCP/IP on OS/2 is an add-on and thus is not fully integrated
 * with the operating system. To ensure portability, follow
 * these rules:
 *
 *  * Always call SockInit() at the beginning of your program
 *    and check that it returns TRUE.
 *
 *  * Use SockSend() & SockRecv() instead of read(), write(),
 *    send(), or recv() when working with sockets.
 *
 *  * Use SockClose() instead of close() with sockets.
 *
 *  * Use SOCK_ERRNO when using functions that use or return
 *    sockets, such as SockSend() or accept().
 *
 *  * Use HOST_ERRNO when using gethostbyname() or gethostbyaddr()
 *    functions.
 *
 *  * As far as I can tell, getservbyname() and related functions
 *    never set any error variable.
 *
 *  * Use SockStrError() & HostStrError() to convert SOCK_ERRNO
 *    and HOST_ERRNO to error strings.
 *
 *  * In .MAK files, include $(TCPIP_MAK) & use $(TCPIPLIB)
 *    when linking applications using TCP/IP.
 *
 ****************************************************************/

#if !defined( IN_TCPIP_H )
#define IN_TCPIP_H

#if defined( TCPIP_IBM )
#	include	<types.h>
#	if !defined( TCPIP_IBM_NOHIDE )
#		define send IbmSockSend
#		define recv IbmSockRecv
#	endif
#endif

#include	<sys/types.h>
#include	<sys/stat.h>
#include	<sys/socket.h>
#include	<sys/ioctl.h>
#include	<netinet/in.h>
#include	<netdb.h>
#include	<errno.h>

#if defined( TCPIP_IBM )
#	define	BSD_SELECT
#	include	<sys/select.h>
#	include	<sys/time.h>
#	include <nerrno.h>
#	include <utils.h>
#	if defined( MICROSOFT )
#		define	SOCK_ERRNO		(tcperrno())
#	else
#		define	SOCK_ERRNO		(sock_errno())
#	endif
#	define	HOST_ERRNO		(h_errno)
#	define	SockClose(S)	soclose(S)
#	define	SockInit()		(!sock_init())
#	define	SockSend		IbmSockSend
#	define	SockRecv		IbmSockRecv

const char *HostStrError(int HostErrno);
const char *SockStrError(int SockErrno);

int IbmSockSend (int Socket, char *Data, int Len, int Flags);
int IbmSockRecv (int Socket, char *Data, int Len, int Flags);

#if !defined( h_errno )
extern int h_errno; /* IBM forgot to declare this in current header files */
#endif

#elif defined( __unix )
#	if defined( sgi ) /* SGI incorrectly defines FD_ZERO in sys/select.h */
#		include <bstring.h>
#	endif
#	if defined( sunos )
extern int select(int, fd_set *, fd_set *, fd_set *, struct timeval *);
#	else
#		include <sys/select.h>
#	endif
#	include <sys/time.h>
#	include <errno.h>
#	include <arpa/inet.h>
#	define	SOCK_ERRNO		errno
#	define	HOST_ERRNO		h_errno
#	define	SockClose(S)	close(S)
#	define	SockInit()		TRUE
#	define	SockSend		send
#	define	SockRecv		recv
#	define	SockStrError(E) strerror(E)

const char *HostStrError( int HostErrno );

#else
#	error Undefined version of TCP/IP specified

#endif

#endif
