/* waitpid.c --- waiting for process termination, under OS/2
   Karl Fogel <kfogel@cyclic.com> --- November 1995  */

#include <assert.h>
#include <stdio.h>
#include <process.h>
#include <errno.h>

#include "config.h"

/* Wait for the process PID to exit.  Put the return status in *statusp.
   OPTIONS is not supported yet under OS/2.  We hope it's always zero.  */
pid_t waitpid (pid, statusp, options)
     pid_t pid;
     int *statusp;
     int options;
{
  int *local_statusp;
  pid_t rc;

  /* We don't know how to deal with any options yet.  */
  assert (options == 0);
  
  rc = _cwait (local_statusp, pid, WAIT_CHILD);
  
  /* 
   * We only want the least-significant byte of the status, since the
   * rest of it may be operating-system dependent.  We'll know if the
   * child exited normally, but not whether it exited with status 0.
   * Since gzip appears to exit with status 1 even after everything
   * goes right, this is how we deal.  Ick.
   */
  *statusp = (char) *local_statusp;

  if (rc == -1)
    {
      if (errno == ECHILD)
        return pid;
      else
        return -1;
    }
  else if (rc == pid)
    return pid;
  else
    return -1;
}
