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
 * "cvslogin" process running already).  If so, it just uses it like
 * any other client.  If not, it creates the block, does whatever was
 * requested, and then (most importantly) fails to die.
 * 
 * The block stores one password at a time.
 */

#define INCL_DOSMEMMGR
#include <os2.h>
#include <bsememf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int
main (int argc, char **argv)
{
    void *addr;
    char *p;
    char *name = "\\SHAREMEM\\MYMEM";
    unsigned long size = 40;
    int rc, i;

    addr = 0;

    if (argc < 2)
    {
        /* Set up the mem. */
        printf ("*** addr before alloc: %p\n", addr); fflush (stdout);
        rc = DosAllocSharedMem (&addr, name, size,
                                PAG_READ | PAG_WRITE | PAG_COMMIT);
        printf ("*** addr after alloc: %p\n", addr); fflush (stdout);
        if (rc != 0)
        {
            fprintf (stderr,
                     "DosAllocSharedMem() failed: %d\n",
                     rc);
            exit (1);
        }
    }

    addr = NULL;

    printf ("*** addr before get: %p\n", addr); fflush (stdout);
    rc = DosGetNamedSharedMem (&addr, name, PAG_READ | PAG_WRITE);
    printf ("*** addr after get: %p\n", addr); fflush (stdout);
    if (rc != 0)
    {
        fprintf (stderr,
                 "DosGetNamedSharedMem() failed: %d\n",
                 rc);
        exit (1);
    }

    p = addr;
    if (argc < 2)
    {
        printf ("*** before strcpy\n"); fflush (stdout);
        strcpy (p, "this is what I wrote\n");
        printf ("*** after strcpy\n"); fflush (stdout);

        DosSleep (30);
    }
    else
    {
        for (i = 0; p[i]; i++)
            printf ("| %c", p[i]);
    }

    printf ("\nDone.\n");
    return 0;
}
