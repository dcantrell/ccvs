This is an experimental attempt to interface to the SCC API.

Here is as far as I got:  I could open the DLL using some
code (hacked up) that Microsoft distributes along with the
SCC API.  However, Developer Studio didn't seem to want to
recognize it (that is, SccInitialize never got called or so
it seemed because DEBUG.SCC never got written.  I'm not
sure how to debug this).

Note that even if that problem is solved, this code won't do anything
useful.  I said experimental, and I mean that in a very extreme sense.

To install it, build scc.dll and then add the following
to the registry using the registry editor:

key/value                what to put there
HKEY_LOCAL_MACHINE
  SOFTWARE
    CVS
      CVS
        SCCServerName    Concurrent Versions System
        SCCServerPath    <full pathname of scc.dll>
    SourceCodeControlProvider
      ProviderRegKey     "SOFTWARE\CVS\CVS"
      InstalledSCCProviders
        Concurrent Versions System   "SOFTWARE\CVS\CVS"

Note that ProviderRegKey is the default source control
system, and InstalledSCCProviders list _all_ installed
source control systems.  A development environment is allowed
to use either or both, so you should set both of them.

Note also that we are using "CVS" as the supplier of CVS.
CVS is not owned by any one company, so CVS seems like the
most appropriate string to put there.
