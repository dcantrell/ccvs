/* listener.c - listen on a TCP port defined through environment
   variable SERVER_PORT, and only hostname defined in environment
   variable SERVER_ALLOW to connect. It then runs remainder of argv
   as a subprocess, redirecting it's output through the TCP port */

#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#define MAXHOSTNAME 256

main(argc, argv)
int argc;
char **argv;
{
  int s, t;
  int i;

  char *port_str;
  char *allowed_host;

  struct sockaddr_in sa, isa;
  struct hostent *lhptr;
  struct hostent *rhptr;
  char localhost[MAXHOSTNAME+1];
  char remotehost[MAXHOSTNAME+1];

  port_str = getenv("SERVER_PORT");
  if (!port_str)
     {
     fprintf (stderr, "SERVER_PORT not set.\n");
     exit(-1);
     }

  allowed_host = getenv("SERVER_ALLOW");
  if (!allowed_host)
     {
     fprintf (stderr, "SERVER_ALLOW not set.\n");
     exit(-1);
     }

  gethostname(localhost, MAXHOSTNAME);
  if((lhptr = gethostbyname(localhost)) == NULL)
     {
     fprintf(stderr, "%s: couldn't get host address\n", argv[0]);
     exit(-1);
     }

  bzero((char *) &sa, sizeof(sa));
  sa.sin_port = htons(atoi(port_str));
  bcopy((char *) lhptr->h_addr, (char *) &sa.sin_addr.s_addr, lhptr->h_length);
  sa.sin_family = lhptr->h_addrtype;

  fprintf (stderr, "Using port %d.\n", ntohs(sa.sin_port));

  /* Create a socket locally */
  if ((s = socket (sa.sin_family, SOCK_STREAM, 0)) < 0)
     {
     fprintf(stderr, "%s: error creating socket\n", argv[0]);
     exit(-2);
     }

  if ((i = bind(s, (struct sockaddr *) &sa, sizeof(sa))) < 0)
     {
     fprintf(stderr, "%s: error binding socket (i=%d, errno=%d)\n",
             argv[0], i, errno);
     close(s);
     exit(-2);
     }

  listen(s, 1);

  while(1)
     {
     int pid;

     int isalen = sizeof(isa);

     printf("Waiting for connection on port %d.\n", ntohs(sa.sin_port));

     if ((t = accept(s, (struct sockaddr *) &isa, &isalen)) < 0)
        {
        fprintf(stderr, "%s: error in accept\n", argv[0]);
        close(s);
        exit(-2);
        }

    if((rhptr = gethostbyaddr((char *) &isa.sin_addr.s_addr,
                              sizeof(isa.sin_addr.s_addr),
                              isa.sin_family)) == NULL)
       {
       fprintf(stderr, "%s: couldn't get remote host name\n", argv[0]);
       exit(-1);
       }

     fprintf(stderr, "Got a connection from: %s\n",
             rhptr->h_name);

     if (strcmp(allowed_host, rhptr->h_name) == 0)
        {
        pid = fork();
        if (pid < 0)
           {
           fprintf (stderr, "%s: cannot fork\n", argv[0]);
           exit(-3);
           }

        if(pid == 0)
           {
           /* As a matter of fact, my child DOES speak for me. */
           dup2(t, fileno(stdin));
           dup2(t, fileno(stdout));

           execvp(argv[1], &argv[1]);
           }

        /* Parent process sleeps until child completion */
        fprintf(stderr, "Parent waiting for child (pid %d)...", pid);
        wait(0);
        fprintf(stderr, "child has terminated.\n");
        }

     close(t);
     fprintf(stderr, "Connection terminated.\n");
     }

}
