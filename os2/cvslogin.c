#define INCL_DOSMEMMGR
#include <os2.h>
#include <stdio.h>
#include <bsememf.h>

#include <stdlib.h>
#include <string.h>

/*
 * void *base_address;
 * char *name;
 * unsigned long size;
 * int flags;
 */

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
