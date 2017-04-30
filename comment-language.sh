#!/bin/bash
# vi:set nu nowrap:
# comment-language.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: comment-language.sh
#        Date: Sat 08 Nov 2008 01:10:38 AM BRST
# Description:
#
#
_basename=${0##*/}

function Example()
{
	case $1 in
		1)
			echo "$ echo TEXT TEXT | $_basename  -tc;";
			echo TEXT TEXT | $_basename  -tc;
		;;
		2)
			echo "$ echo TEXT TEXT | $_basename  -tc -l";
			echo TEXT TEXT | $_basename  -tc -l
		;;
		3)
			echo "$ echo TEXT TEXT | $_basename  -tc -r";
			echo TEXT TEXT | $_basename  -tc -r
		;;
		4)
			echo "$ echo TEXT TEXT | $_basename  -tcpp -l";
			echo TEXT TEXT | $_basename  -tcpp -l
		;;
		5)
			echo "$ echo TEXT TEXT | $_basename  -tcpp -c";
			echo TEXT TEXT | $_basename  -tcpp -c
		;;
		6)
			echo "$ echo TEXT TEXT | $_basename  -tcpp -b";
			echo TEXT TEXT | $_basename  -tcpp -b
		;;
		all)
			for n in `seq 1 6`; do $_basename -e $n; done
		;;
		*)
			echo "$ echo  hello! Comment | $_basename  -tc  -b -l";
			echo  hello! Comment | $_basename  -tc  -b -l
		;;
	esac
}

function Usage()
{
cat << EOF
	A program to generate nice/simple comment language

	Usage: $_basename [ -e NUMBER | -t{[cpp|c|java|sh]} -[b] -[lr] ]

	Where the options include:
		-t  set language for comment
		-l  generate comment left
		-r  generate comment right
		-b  generate comment box
		-e  show examples

Example:

$ echo   | $_basename  -tc
/* x                                                                         */

$ echo  hello! Comment | $_basename  -tc  -b -l
/*****************************************************************************
 *                                                                           *
 * hello! Comment ---------------------------------------------------------- *
 *                                                                           *
 *****************************************************************************/

Edit the generated comment if nedeed.
EOF
}

##############################################################################

box=0; left=0; center=0; right=0
cmd=""

##############################################################################

while getopts de:ct:blr o
	do
	case "$o" in
		d) debug_on=1;
		;;
		e) Example $OPTARG;
		   exit 0
		;;
		t) code=$OPTARG;
		   : ${left:=0};
		   : ${right:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;

		c) center=1;
		   : ${right:=0};
		   : ${left:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;

		l) left=1;
		   : ${right:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;
		r) right=1;
		   : ${center:=0};
		   : ${left:=0};
		   : ${box:=0}
		;;
		b) box=1;
		   : ${left:=0};
		   : ${center:=0};
		   : ${right:=0}
		;;
		?) echo "Usage: ${0##*/} [ -e NUMBER | -t{[cpp|c|java|sh]} -[b] -[lr] ]";
		exit 1;;
	esac
done

#set -x

code_on=0

# cansi
#-----------------------------------------------------------------------------
if [ "$code" = 'c' ]; then

	cmd=comment.cansi
	code_on=1
	source ${SHELLSCRIPT_PAKAGES}/comment-cansi.sh
	source ${SHELLSCRIPT_PAKAGES}/comment-cansi.sh

	if [ $box = 1 ]; then
		flag=1;	cmd=${cmd}.box
	fi

	if [ $left = 1 ]; then
		flag=1;	right=0; cmd=${cmd}l
	fi

	if [ $right = 1 ]; then
		flag=1;	left=0;	cmd=${cmd}r
	fi

	if [ $center = 1 -a $box = 0 ]; then
		flag=1;	left=0; right=0; cmd=${cmd}c
	fi

	[ "$flag" ] || cmd=${cmd}.line

fi

# cpp
#-----------------------------------------------------------------------------
if [ "$code" = 'cpp' ]; then

	cmd=comment.cpp
	code_on=1
	source ${SHELLSCRIPT_PAKAGES}/comment-cpp.sh
	source ${SHELLSCRIPT_PAKAGES}/comment-cpp.sh

	if [ $box = 1 ]; then
		flag=1;	cmd=${cmd}.box
	fi

	if [ $left = 1 ]; then
		flag=1;	right=0; cmd=${cmd}l
	fi

	if [ $right = 1 ]; then
		flag=1;	left=0;	cmd=${cmd}r
	fi

	if [ $center = 1 -a $box = 0 ]; then
		flag=1;	left=0; right=0; cmd=${cmd}c
	fi

	[ "$flag" ] || cmd=${cmd}.line

fi

if [ "$code_on" = '1' ]; then

##############################################################################

while read line; do
	if [ $debug_on = 1 ]; then
		echo :$cmd \"$line\"
	fi
	eval $( echo $line | sed "s/.*/'&'/; s/^/$cmd /")
done

##############################################################################
else
	Usage $0
fi
#-----------------------------------------------------------------------------
exit 0
