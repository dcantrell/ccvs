#! /bin/sh

# Test that a getdate executable meets its specification.
#
# Copyright (C) 2004 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

TZ=UTC; export TZ

cat >getdate-expected <<EOF
Enter date, or blank line to exit.
	> Bad format - couldn't convert.
	> Bad format - couldn't convert.
	> 1972-12-05 00:00:00.000000000
	> 1974-03-29 00:00:00.000000000
	> 1996-05-12 13:57:45.000000000
	> 2012-05-12 00:00:00.000000000
	> 1996-05-12 00:00:00.000000000
	> Bad format - couldn't convert.
	> Bad format - couldn't convert.
	> 1970-01-01 02:00:00.000000000
	> Bad format - couldn't convert.
	> 1969-12-31 22:00:00.000000000
	> Bad format - couldn't convert.
	> 1970-01-01 06:00:00.000000000
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
1969-12-32 2:00:00 UTC
1970-01-01 2:00:00 UTC
1969-12-32 2:00:00 +0400
1970-01-01 2:00:00 +0400
1969-12-32 2:00:00 -0400
1970-01-01 2:00:00 -0400
EOF

echo >>getdate-got

if diff -u getdate-expected getdate-got >getdate.diff; then :; else
	echo "Failed!  See getdate.diff for more!" >&2
	exit 1
fi

rm getdate-expected getdate-got getdate.diff
exit 0
