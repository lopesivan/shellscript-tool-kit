#!/bin/bash
# ----------------------------------------------------------------------------
__debug__=0; __help__=0
__usage__=0
__clean__=0
# ----------------------------------------------------------------------------
[ "$1" = '-h'      ] && { __help__=1; shift;  }
[ "$1" = '--help'  ] && { __help__=1; shift;  }
[ "$1" = '-d'      ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--usage' ] && { __usage__=1; shift; }
[ "$1" = '--clean' ] && { __clean__=1; shift; }
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

# vi:set nu nowrap:
# table.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: table.sh
#        Date: Sex 29 Out 2010 14:40:10 BRST
# Description:
#
#

if [ $__usage__ -eq 1 ]; then
	#__usage__ has value equal 1
	#__usage__ ON
	echo "seq 3 | table -b 1 -c 2 | w3m -dump -cols 2000 -T 'text/html'"
	seq 3 | table -b 1 -c 2 | w3m -dump -cols 2000 -T 'text/html'

	echo "seq 6 | table -b 1 -c 8 | w3m -dump -cols 2000 -T 'text/html'"
	seq 3 | table -b 1 -c 2 | w3m -dump -cols 2000 -T 'text/html'
	exit 1
fi

if [ $__help__ -eq 1 ]; then
	#__help__ has value equal 1
	#__help__ ON
	echo "seq 3 | table -b 1 -c 2 | w3m -dump -cols 2000 -T 'text/html'"
	seq 3 | table -b 1 -c 2 | w3m -dump -cols 2000 -T 'text/html'
	exit 1
fi

#-----------------------------------------------------------------------------
__border__=0
[ "$1" = '--border' ] && { __border__=1; shift; }
[ "$1" = '-b' ]       && { __border__=1; shift; }

if [ $__border__ -eq 1 ]; then
	border=$1
	shift
	start_table="table border=\"$border\""
else
	border=0
	start_table="table border=\"$border\""
fi

#-----------------------------------------------------------------------------
__columns__=0
[ "$1" = '--columns' ] && { __columns__=1; shift; }
[ "$1" = '-c' ]        && { __columns__=1; shift; }

if [ $__columns__ -eq 1 ]; then
	columns=$1
	shift
else
	columns=0
fi

# ----------------------------------------------------------------------------
echo "<$start_table>"

    count=0
 open_tag=true
close_tag=false

cat - |
while read LINE; do
	[ "$LINE" ] || continue

	if $open_tag; then
		echo '<tr>'
		close_tag=false
	fi

	if (( count < columns )); then
		let count++
		open_tag=false
	else
		count=0
		close_tag=true
	fi

	echo $LINE | sed 's/.*/<td>&<td>/'

	if $close_tag; then
		echo '</tr>'
		open_tag=true
	fi

done

echo '</tr>'
echo '</table>'

# ----------------------------------------------------------------------------
exit 0
