This is an experimental attempt to interface to the SCC API.

Note that although Developer Studio does recognize this code (it
should show a grayed out "Source Control" item on the Tools menu if
you install it right), it doesn't (yet) do anything useful.

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

TOOLS IMPLEMENTING THE SCC

I'm not sure whether we'll want to try to make this a comprehensive
list, but at least for the moment it seems worthwhile to list a few of
the programs which implement the Integrated Development Environment
(IDE) side of the SCC.  Some of this information is based on rumor or,
worse yet, usenet posting, so it probably should be verified before
relying on it.

* Microsoft Developer Studio 4.x Professional (not Standard, not 2.x)
* Powersoft's Optima++
* CodeWright editor
