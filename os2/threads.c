/* Thread testing stuff, w/ EMX pipe code commented out below. */

#define INCL_DOS
#include <os2.h>
#include <stdio.h>
#include <stdlib.h>

int wait = 1;

void bonjour (void *arg)
{
	int i;
	while (wait);
	printf ("Thread Heads Rule!\n");
	for (i = 0; i < 1000; i++)
		printf ("... in BONJOUR ... %d.\n", i);

	return;
}

int main ()
{
	unsigned long int tid;
	int i;
	
	tid = _beginthread (bonjour, NULL, 8192, NULL);

	if (tid == -1)
	{
		printf ("Unable to start thread.\n");
		return -1;
	}
	else
	{
		printf ("Thread's id is %d.\n", tid);
		wait = 0;
	}

	for (i = 0; i < 1000; i++)
		printf ("... in main ... %d.\n", i);

	DosWaitThread (&tid, DCWW_WAIT);
	return 0;
}



#if 0 /* pipe stuff */
#include <stdio.h>

/* popen.c (emx+gcc) -- Copyright (c) 1992-1993 by Eberhard Mattes */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <process.h>
/* #include <unistd.h> */
#include <io.h>
#include <fcntl.h>
#include <errno.h>

#define STDIN_FILENO 0
#define STDOUT_FILENO 1

#define F_SETFD 0
#define F_GETFD 0

int fcntl (int fd, int prop, int setting)
{
	/* A dummy function. */
	return 0;
}


static void restore (int org_handle, int org_private, int handle)
{
  int saved_errno;

  saved_errno = errno;
  close (handle);
  dup (org_handle);
  close (org_handle);
  fcntl (handle, F_SETFD, org_private);
  errno = saved_errno;
}

static FILE *make_pipe (int pipe_local, int pipe_remote, int handle,
                        const char *command, const char *mode)
{
  int i, org_handle, org_private;
  FILE *f;
  const char *sh, *opt;

  fcntl (pipe_local, F_SETFD, 1);
  org_private = fcntl (handle, F_GETFD, 0);
  if (org_private == -1)
    return (NULL);
  org_handle = dup (handle);
  if (org_handle == -1)
    return (NULL);
  fcntl (org_handle, F_SETFD, 1);
  if (close (handle) == -1)
    return (NULL);
  i = dup (pipe_remote);
  if (i != handle)
    {
      restore (org_handle, org_private, handle);
      errno = EBADF;
      return (NULL);
    }
  if (close (pipe_remote) == -1)
    {
      restore (org_handle, org_private, handle);
      return (NULL);
    }
  f = fdopen (pipe_local, mode);
  if (f == NULL)
    {
      restore (org_handle, org_private, handle);
      return (NULL);
    }
  sh = getenv ("EMXSHELL");
  if (sh == NULL)
    sh = getenv ("COMSPEC");
  if (sh == NULL)
    {
      fclose (f);
      restore (org_handle, org_private, handle);
      errno = ENOENT;
      return (NULL);
    }
  i = spawnlp (P_NOWAIT, command, command, NULL);
  if (i == -1)
    {
      fclose (f);
      f = NULL;
    }
#if 0
  else
	  f->pid = i;
#endif
  restore (org_handle, org_private, handle);
  return (f);
}


FILE *popen (const char *command, const char *mode)
{
  int ph[2];
  FILE *stream;
  int saved_errno;

  if (mode[0] != 'r' && mode[0] != 'w')
    {
      errno = EINVAL;
      return (NULL);
    }
  if (pipe (ph) == -1)
    return (NULL);
  if (fcntl (ph[0], F_SETFD, 1) == -1)
    return (NULL);
  if (fcntl (ph[1], F_SETFD, 1) == -1)
    return (NULL);
  if (mode[0] == 'r')
    stream = make_pipe (ph[0], ph[1], STDOUT_FILENO, command, mode);
  else
    stream = make_pipe (ph[1], ph[0], STDIN_FILENO, command, mode);
  if (stream == NULL)
    {
      saved_errno = errno;
      close (ph[0]);
      close (ph[1]);
      errno = saved_errno;
    }
  return (stream);
}


int main ()
{
	FILE *fp;
	int c;

	fp = popen ("rsh -?", "r");
	while ((c = getc (fp)) != EOF)
	{
		printf ("%c", c);
	}

	printf ("\n*** Done. ***\n");
	return 0;
}
#endif /* 0 -- pipe stuff */
