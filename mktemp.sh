mktemp() {
	if test x"$1" = x-d; then
		tmp=`echo $2 |sed "s/XXXXXX/$$/"`
		(umask 077 && exec mkdir $tmp)
	else
		tmp=`echo $1 |sed "s/XXXXXX/$$/"`
		(umask 077 && touch $tmp)
	fi
	echo $tmp
}
		
