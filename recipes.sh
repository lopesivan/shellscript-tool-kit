#!/bin/bash
WITHLINES=0
INFILE=0
[ "$1" = '-c' ] && { shift; WITHLINES=1; }
[ "$1" = '-f' ] && { shift; INFILE=1; }

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
$(ls $SHELLSCRIPT_PKG/../dicas/dicas*.txt)
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
		if [ $INFILE -eq 1 ]; then
			cat ${files[num-1]}
		else
			cat ${files[num-1]}| most
		fi
		#cat ${files[num-1]}| nl |most -z -u
		#cat ${files[num-1]}| nl |less
	fi
} || {
for file in ${files[*]}; do
	#echo $((++i)) ${file##*.vim/}
	$cmd
	printf "%05d | %s\n" $((++i)) ${file##*/dicas/}
done|
fzf-tmux -l 100% --multi --reverse --query="$1" --select-1 --exit-0 |
sed 's=|.*==' | bc | (read n; recipes $n)
}

exit 0
