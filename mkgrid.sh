#!/bin/bash

# ----------------------------------------------------------------------------
__debug__=0;
# ----------------------------------------------------------------------------
[ "$1" = '-d'      ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

# vi:set nu nowrap:
# mkgrid.sh: Gera grid.

# $Id:$
# AppTech’s LiveCam technology.
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#        Site: http://www.apptechcorp.com
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: mkgrid.sh
#        Date: Sat 14 Jan 2012 02:05:32 PM BRST
# Description:
#
#

[ "$1" ] || {
cat <<EOF
mkgrid -r 16:9 -x \$((16*3)) | sh
mkgrid -r 16:9 -y \$((9*5 )) | sh
mkgrid -d -r 9:16 -x \$((9*5 ))
mkgrid  -r 1:1 -x $((9*20 )) -s  2
mkgrid  -r 1:1 -x $((9*20 )) -s  2
mkgrid  -r 1:4 -x $((1*20))  -s 20
mkgrid  -r 1:4 -x $((1*20))  -s 20
mkgrid  -r 4:1 -y $((1*20))  -s 20
mkgrid  -r 4:1 -y $((1*20))  -s 20
mkgrid  -r 1:1 -x $((9*20 )) -s 20
EOF
exit 1
}

while getopts 'r:x:y:s:t' optch; do
	case $optch in
 		r) numerator=${OPTARG%:*}; denominator=${OPTARG#*:} ;;
 		x) X=$OPTARG; xFirst=1     ;;
 		y) Y=$OPTARG  xFirst=0     ;;
 		t) T="-alpha Transparent"  ;;
 		s) SetStep=$OPTARG         ;;
		*) echo  "Unknown option!" ;;
	esac
done

used_up=$OPTIND
for ((;used_up <= $#;++used_up)); do
	echo "argv[$used_up] = '$(eval echo \$$used_up)'"
done

n=$numerator
d=$denominator

if [ $xFirst -eq 1 ]; then
	Y=$(echo "($d * $X)/$n" | bc)
else
	X=$(echo "($n * $Y)/$d" | bc)
fi

 width=$X
height=$Y

XFirst=0
 XLast=$((width -1))

YFirst=0
 YLast=$((height -1))

YStep=$denominator
XStep=$numerator

# 1:1
[ "$SetStep" ] && {
	YStep=$SetStep
	XStep=$YStep
}

debug() {
cat <<EOF >&2
=== DEBUG ===
YStep    = $YStep
XStep    = $XStep
width    = $X
height   = $Y
XFirst   = $XFirst
XLast    = $XLast
YFirst   = $YFirst
YLast    = $YLast
denominat= $denominator
numerator= $numerator
EOF
	exit 0
}

if [ $__debug__ -eq 1 ]; then
	#__debug__ has value equal 1
	#__debug__ ON

	debug
fi

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
#echo -n "convert -size ${width}x${height} xc:white -strokewidth 1"
echo -n "convert -size ${width}x${height} xc:white $T -strokewidth 1"
# ----------------------------------------------------------------------------

# X
for x in $(seq $XFirst $XStep $XLast); do
  echo -n " -draw 'line $x,0 $x,$Y'"
done

# Y
for y in $(seq $YFirst $YStep $YLast); do
  echo -n " -draw 'line 0,$y $X,$y'"
done

f="grid_${width}x${height}.png"
echo " $f; eog $f"

# ----------------------------------------------------------------------------
exit 0

