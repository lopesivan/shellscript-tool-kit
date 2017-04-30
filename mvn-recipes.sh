#!/bin/bash
WITHLINES=0
[ "$1" = '-c' ] && { shift; WITHLINES=1; }
[ "$1" = '-l' ] && { shift; WITHOUTMOST=1; }

# vi:set nu nowrap:
# bat.sh: .

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: bat.sh
#        Date: Tue 06 Jan 2009 03:01:10 PM BRST
# Description:
#
#
files=(
$(ls /home/ivan/archetype.generate/*)
)

#echo ${#files[*]}

if [ $WITHLINES -eq 1 ]; then
	cmd="printf %s\n ------+----------------------------------------------------"
else
	cmd=""
fi

[ "$1" ] && num=$1 && {
	if (( num > 0 && num <= ${#files[*]} ))
	then
		if [ $WITHOUTMOST -eq 1 ]; then
			cat ${files[num-1]}
		else
			cat ${files[num-1]}| most
		fi
		#cat ${files[num-1]}| nl |most -z -u
		#cat ${files[num-1]}| nl |less
	fi
} || {
for file in ${files[*]}; do
#	echo $((++i)) ${file##*.vim/}
	$cmd
	printf "%05d | %s\n" $((++i)) ${file##*/home/ivan/archetype.generate/}
done
}

exit 0
