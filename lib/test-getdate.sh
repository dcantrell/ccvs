#! /bin/sh

cat >getdate-expected <<EOF
Enter date, or blank line to exit.
	> 2003-03-01 00:00:00.000000000
	> 2005-01-09 00:00:00.000000000
	> 1972-12-05 00:00:00.000000000
	> 1974-03-29 00:00:00.000000000
	> 1996-05-12 13:57:45.000000000
	> 2012-05-12 00:00:00.000000000
	> 1996-05-12 00:00:00.000000000
	> Bad format - couldn't convert.
	> 
EOF

./getdate >getdate-got <<EOF
February 29, 2003
2004-12-40
Dec-5-1972
3/29/1974
1996/05/12 13:57:45
12-05-12
05/12/96
third tuesday in March, 2078
EOF

echo >>getdate-got

if diff -u getdate-expected getdate-got >getdate.diff; then :; else
	echo "Failed!  See getdate.diff for more!" >&2
	exit 1
fi

rm getdate-expected getdate-got getdate.diff
exit 0
