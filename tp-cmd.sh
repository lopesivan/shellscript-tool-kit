#!/bin/bash
#set -x
_usage()
{
	echo "Usage: `basename $0` [debug|list|help] [--option|n]"
	exit 1
}

[ "$1" ] || _usage

##############################################################################

templatedir=~/.template/cmd

##############################################################################

# isdigit
expr "$1" : '[[:digit:]]\{1,\}' > /dev/null

if [ $? -eq 0 ]; then

		[ $1 -gt $(wc -l ${templatedir}/.lastoption| cut -d" " -f1) -o $1 -eq 0 ] &&
			echo the value $1 out of range &&
				exit 1

		source ${templatedir}/.lastoption

		[ "$2" ] && {
				case $2 in
						debug)
							cat  ${templatedir}/.lastoption
							echo "option: ${OLDOPTION[$1]}"
							echo "file  : ${OLDOPTION[$1]#--}.txt"
						;;
						file)
							echo ${templatedir}/${OLDOPTION[$1]#--}.txt
						;;
						*)
							echo "Usage: `basename $0` number [file|debug]"
						;;
				esac
		} || {

			echo "`basename $0` ${OLDOPTION[$1]}" | sh
		}

	exit 0
fi

##############################################################################

opt=( `ls ${templatedir} | grep 'txt$' | sed "s/\.txt//g; s/^/--/"` )

IFS=@
if [ "$1" = 'debug' -o "$1" = 'help' -o "$1" = 'list' ];
then
	[ "$2" ] && {

		# box message.
		echo "${opt[*]}" |
		sed 's/@/\n/g' |
		grep -e "^$2.*"| sort -n -t. -k3 |
		cat -n|
		grep --color "${2#--}"

		echo "${opt[*]}" | sed 's/@/\n/g' | grep -e "^$2.*"| sort -n -t. -k3 | cat -n |
		sed -r 's/$/;/; s/\s+([0-9]+)\s/OLDOPTION[\1]=/' > ${templatedir}/.lastoption

		echo option: $2

	} || _usage
else

	case $1 in
		--*)
			o=${1#--}
			file=${templatedir}/`expr "${opt[*]}" : ".*--\($o\)@\?.*"`.txt
                        test -e $file     &&
                        	cat $file ||
				{ echo $1: not found; _usage; }
			;;

		*)	echo $1: is not option
			echo ":("
			_usage
		;;
	esac

fi

exit 0
