/*
 * CVSLOGIN -- a program that shouldn't have to exist.
 *
 * It's difficult to keep secrets under OS/2.  Apparently, files are
 * either readable or not -- you don't pick and choose which users can
 * read them and which can't.
 *
 * This is a problem for the authenticated CVS client, because it
 * needs to store cleartext passwords between invocations of CVS.
 * Under Unix, we just keep them in ~/.cvspass, which is group- and
 * other-unreadable.  Under OS/2, no file is safe.  So we use a
 * shared-memory block.  This is still not great, but at least
 * exporting parts of the filesystem won't compromise your CVS
 * passwords.  The shared-memory block can only be read by processes
 * running on the same machine.
 *
 * But how to keep that shared memory block alive?  Once its creator
 * process goes away, the memory disappears too (I confirmed this
 * experimentally).  The utter^H^H^H^H^H crock^H^H^H^H^H solution is
 * to start up a small process, "cvslogin", that maintains the memory
 * block.  When the machine is shut off, the process dies and the
 * password disappears.
 *
 * "cvslogin" is called every time "cvs login" is invoked.  It first
 * checks to see if the block already exists (i.e., there's another
 * "cvslogin" process running already).  If so, it just uses it.  If
 * not, it creates the block, stores the password, and then (most
 * importantly) fails to die.
 * 
 * The block stores one password at a time.
 */

#define INCL_DOSMEMMGR
#define INCL_DOSPROCESS
#include <os2.h>
#include <bsememf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void
record_first_time (char **p, char *name,
                   unsigned long size, char *passwd)
{
  int rc;

  rc = DosAllocSharedMem (p, name, size,
                          PAG_READ | PAG_WRITE | PAG_COMMIT);
  if (rc != 0)
    {
      fprintf (stderr, "DosAllocSharedMem() failed: %d\n", rc);
      exit (1);
    }

  strcpy (*p, passwd);

  /* Wait forever.  We need to stay alive so the memory is still there
     when other processes try to read it. */
  while (1)
    DosSleep (60000);
}


int
main (int argc, char **argv)
{
    char *addr = NULL;
    char *name = "\\SHAREMEM\\CVSPASS.WRD";
    /* Sizes always get rounded up to a multiple of 4k anyway. */
    unsigned long size = 4096;
    int rc, i;

    if (argc != 2)
    {
      fprintf (stderr,
               "cvslogin: wrong number of arguments: %d",
               argc);
      exit (1);
    }

    rc = DosGetNamedSharedMem (&addr, name, PAG_READ | PAG_WRITE);
    if (rc != 0)
      {
        /*
         * No problem -- just means this is the first time we've been
         * called, so the block has not been allocated yet.
         */

        /* This will never return -- it sleeps forever after creating
           the block. */
        record_first_time (&addr, name, size, passwd);
      }
    else
      {
        /* Else we got the block, so put the new password into it. */
        strcpy (addr, argv[1]);
      }
}
