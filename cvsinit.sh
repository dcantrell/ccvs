#! /bin/sh
:
#
# Copyright (c) 1992, Brian Berliner
#
# You may distribute under the terms of the GNU General Public License as
# specified in the README file that comes with the CVS 1.4 kit.
#
# $CVSid: @(#)cvsinit.sh 1.1 94/10/22 $
#
# This script should be run once to help you setup your site for CVS.

# this line is edited by Makefile when creating cvsinit.inst
CVSLIB="xLIBDIRx"

CVS_VERSION="xVERSIONx"

echo "Initialising a $CVS_VERSION repository...."
echo ""

# Make sure that the CVSROOT variable is set
if [ "x$CVSROOT" = x ]; then
    echo "The CVSROOT environment variable is not set."
    echo ""
    echo "You should choose a location for your source repository"
    echo "that can be shared by many developers.  It also helps to"
    echo "place the source repository on a file system that has"
    echo "plenty of free space."
    echo ""
    echo "Please enter the full path for your CVSROOT source repository:"
    read CVSROOT
    remind_cvsroot=yes
else
    echo "Using $CVSROOT as the source repository."
    remind_cvsroot=no
fi
echo ""

# Now, create the $CVSROOT if it is not already there
if [ ! -d $CVSROOT ]; then
    echo "Hmmm... $CVSROOT does not exist; trying to make it..."
    path=
    for comp in `echo $CVSROOT | sed -e 's,/, ,g'`; do
	path=$path/$comp
	if [ ! -d $path ]; then
	    mkdir $path
	fi
    done
else
    echo "Good... $CVSROOT already exists."
fi

# Next, check for $CVSROOT/CVSROOT
if [ ! -d $CVSROOT/CVSROOT ]; then
    if [ -d $CVSROOT/CVSROOT.adm ]; then
	echo "You have the old $CVSROOT/CVSROOT.adm directory."
	echo "I will rename it to $CVSROOT/CVSROOT for you..."
	mv $CVSROOT/CVSROOT.adm $CVSROOT/CVSROOT
    else
	echo "Making the $CVSROOT/CVSROOT directory..."
	mkdir $CVSROOT/CVSROOT
    fi
else
    echo "Wow!... so does $CVSROOT/CVSROOT."
fi
echo ""
if [ ! -d $CVSROOT/CVSROOT ]; then
    echo "You still don't have a $CVSROOT/CVSROOT directory."
    echo "I give up."
    exit 1
fi

# Create the special *info files within $CVSROOT/CVSROOT

# Trump up a simple modules file, if one doesn't exist
if [ -f $CVSROOT/CVSROOT/modules,v ]; then
    if [ ! -f $CVSROOT/CVSROOT/modules ]; then
	echo "You have a $CVSROOT/CVSROOT/modules,v file,"
	echo "But no $CVSROOT/CVSROOT/modules file.  This is OK."
	echo "I'll checkout a fresh copy..."
	(cd $CVSROOT/CVSROOT; co -q modules)
	echo ""
    fi
else
    if [ -f $CVSROOT/CVSROOT/modules ]; then
	echo "You have a $CVSROOT/CVSROOT/modules file,"
	echo "But no $CVSROOT/CVSROOT/modules,v file."
	echo "I'll create one for you, but otherwise leave it alone..."
    else
	echo "The $CVSROOT/CVSROOT/modules file does not exist."
	echo "Making a simple one for you..."
	sed -n -e '/END_REQUIRED_CONTENT/q' -e p $CVSLIB/examples/modules > $CVSROOT/CVSROOT/modules

    fi
    (cd $CVSROOT/CVSROOT; ci -q -u -t/dev/null -m'initial checkin of modules' modules)
    echo ""
fi

# check to see if there are any references to the old CVSROOT.adm directory
if grep CVSROOT.adm $CVSROOT/CVSROOT/modules >/dev/null 2>&1; then
    echo "Warning: your $CVSROOT/CVSROOT/modules file still"
    echo "	contains references to the old CVSROOT.adm directory"
    echo "	You should really change these to the new CVSROOT directory"
    echo ""
fi

# loginfo, like modules, is special-cased
if [ -f $CVSROOT/CVSROOT/loginfo,v ]; then
    if [ ! -f $CVSROOT/CVSROOT/loginfo ]; then
	echo "You have a $CVSROOT/CVSROOT/loginfo,v file,"
	echo "But no $CVSROOT/CVSROOT/loginfo file.  This is OK."
	echo "I'll checkout a fresh copy..."
	(cd $CVSROOT/CVSROOT; co -q loginfo)
	echo ""
    fi
else
    if [ -f $CVSROOT/CVSROOT/loginfo ]; then
	echo "You have a $CVSROOT/CVSROOT/loginfo file,"
	echo "But no $CVSROOT/CVSROOT/loginfo,v file."
	echo "I'll create one for you, but otherwise leave it alone..."
    else
	echo "The $CVSROOT/CVSROOT/loginfo file does not exist."
	echo "Making a simple one for you..."
	# try to find perl; use fancy log script if we can
	for perlpath in `echo $PATH | sed -e 's/:/ /g'` x; do
	    if [ -f $perlpath/perl ]; then
		echo "#!$perlpath/perl" > $CVSROOT/CVSROOT/log.pl
		cat $CVSLIB/contrib/log.pl >> $CVSROOT/CVSROOT/log.pl
		chmod 755 $CVSROOT/CVSROOT/log.pl
		cp $CVSLIB/examples/loginfo $CVSROOT/CVSROOT/loginfo
		break
	    fi
	done
	if [ $perlpath = x ]; then
	    # we did not find perl anywhere, so make a simple loginfo file
	    grep '^#' $CVSLIB/examples/loginfo > $CVSROOT/CVSROOT/loginfo
	    cat >> $CVSROOT/CVSROOT/loginfo <<"END_HERE_DOC"
DEFAULT		(echo ""; echo $USER; date; cat) >> $CVSROOT/CVSROOT/commitlog
END_HERE_DOC
	fi
    fi
    (cd $CVSROOT/CVSROOT; ci -q -u -t/dev/null -m'initial checkin of loginfo' loginfo)
    echo ""
fi

# These files are generated from the examples files.
for info in commitinfo rcsinfo editinfo rcstemplate checkoutlist; do
    if [ -f $CVSROOT/CVSROOT/${info},v ]; then
	if [ ! -f $CVSROOT/CVSROOT/$info ]; then
	    echo "You have a $CVSROOT/CVSROOT/${info},v file,"
	    echo "But no $CVSROOT/CVSROOT/$info file.  This is OK."
	    echo "I'll checkout a fresh copy..."
	    (cd $CVSROOT/CVSROOT; co -q $info)
	    echo ""
	fi
    else
	if [ -f $CVSROOT/CVSROOT/$info ]; then
	    echo "You have a $CVSROOT/CVSROOT/$info file,"
	    echo "But no $CVSROOT/CVSROOT/${info},v file."
	    echo "I'll create one for you, but otherwise leave it alone..."
	else
	    echo "The $CVSROOT/CVSROOT/$info file does not exist."
	    echo "Making a simple one for you..."
	    sed -e 's/^\([^#]\)/#\1/' $CVSLIB/examples/$info > $CVSROOT/CVSROOT/$info
	fi
	(cd $CVSROOT/CVSROOT; ci -q -u -t/dev/null -m"initial checkin of $info" $info)
	echo ""
    fi
done

# These files are generated from the contrib files.
for contrib in log commit_prep log_accum cln_hist; do
    echo "Copying the new version of '${contrib}' to $CVSROOT/CVSROOT for you..."
    cp $CVSLIB/contrib/$contrib $CVSROOT/CVSROOT/$contrib
done
echo "Remember, to install these files you must run 'cvsinit' for each repository!"

# XXX - also add a stub for the cvsignore file

# Turn on history logging by default
if [ ! -f $CVSROOT/CVSROOT/history ]; then
    echo "Enabling CVS history logging..."
    touch $CVSROOT/CVSROOT/history
    echo ""
fi

# finish up by running mkmodules
echo "All done!  Running 'mkmodules' as my final step..."
mkmodules $CVSROOT/CVSROOT

# and, if necessary, remind them about setting CVSROOT
if [ $remind_cvsroot = yes ]; then
    echo "Remember to set the CVSROOT environment variable in your login script"
fi

exit 0
