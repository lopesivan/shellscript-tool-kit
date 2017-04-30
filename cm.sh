#!/bin/bash
# vi:set nu nowrap:
# g_opt.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: cm.sh
#        Date: Sat 27 Jun 2009 04:22:18 PM EDT
# Description:
#
#

# ----------------------------------------------------------------------------
nversion=2.1
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
[ "$1" = '-d' ] && { DEBUG=1; shift; }
_debug(){ [ "$DEBUG" = 1 ] && echo "$*" ; }
_basename=${0##*/}

#
# opt
#
source ${SHELLSCRIPT_PAKAGES}//getoptx.sh
source ${SHELLSCRIPT_PAKAGES}//getoptx.sh
#
# commun functions
#
source ${SHELLSCRIPT_PAKAGES}//util.sh
source ${SHELLSCRIPT_PAKAGES}//util.sh

#
#=============================================================================
#

#
# Version
#
function _version()
{
	# Verify command cat
	#
	have cat &&
	{
         cat <<EOF
$_basename (ice tools) $nversion
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by ${_author}.
EOF
	} || { _error 'bash: cat: command not found'; _abort_now; }
	# End have cat
}

#
#=============================================================================
#

#
# Usage
#
function _usage()
{
	# Verify command cat
	#
	have cat &&
	{
         cat <<EOF
Usage: $_basename [-DIGITS] [OPTION]... [FILE]...
Reformat each paragraph in the FILE(s), writing to standard output.
If no FILE or if FILE is \`-', read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --crown-margin        preserve indentation of first two lines
  -p, --prefix=STRING       reformat only lines beginning with STRING,
                              reattaching the prefix to reformatted lines
  -s, --split-only          split long lines, but do not refill
  -t, --tagged-paragraph    indentation of first line different from second
  -u, --uniform-spacing     one space between words, two after sentences
  -w, --width=WIDTH         maximum line width (default of 75 columns)
      --help     display this help and exit
      --version  output version information and exit

With no FILE, or when FILE is -, read standard input.

Report bugs to <${_mail}>.
EOF
	} || { _error 'bash: cat: command not found'; _abort_now; }
	# End have cat
}

#
#=============================================================================
#

#
# Help
#
function _help()
{
	# Verify command cat
	#
	have cat &&
	{
         cat <<EOF
Usage: $_basename [-DIGITS] [OPTION]... [FILE]...
Reformat each paragraph in the FILE(s), writing to standard output.
If no FILE or if FILE is \`-', read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --crown-margin        preserve indentation of first two lines
  -p, --prefix=STRING       reformat only lines beginning with STRING,
                              reattaching the prefix to reformatted lines
  -s, --split-only          split long lines, but do not refill
  -t, --tagged-paragraph    indentation of first line different from second
  -u, --uniform-spacing     one space between words, two after sentences
  -w, --width=WIDTH         maximum line width (default of 75 columns)
      --help     display this help and exit
      --version  output version information and exit

With no FILE, or when FILE is -, read standard input.

Report bugs to <${_mail}>.
EOF
	} || { _error 'bash: cat: command not found'; _abort_now; }
	# End have cat
}

#
#=============================================================================
#

function _example()
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
		7)
			echo "$ echo TEXT TEXT | $_basename --type=cpp -bl";
			echo TEXT TEXT | $_basename --type=cpp -bl
		;;
		8)
			echo "$ echo TEXT TEXT | $_basename --type=c -b --left";
			echo TEXT TEXT | $_basename --type=c -b --left
		;;
		all)
			for n in `seq 1 7`; do $_basename -e$n; done
		;;
		*)
			echo "$ echo  hello! Comment | $_basename  -tc  -b -l";
			echo  hello! Comment | $_basename  -tc  -b -l
		;;
	esac
}

##############################################################################
##############################################################################
##############################################################################
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
################################# My options. ################################
_opt=\
"
-e.| --example. |
-t:| --type:    |
-b | --box      |
-r | --right    |
-l | --left     |
-c | --center   |
"
##############################################################################
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
_opt=\
`echo $_opt| \
sed \
'\
s/ //g                          ;\
s/-\(.[:.]\?\)\s*|/\1  /g       ;\
:b                              ;\
s/--\(.[^ .]\+[:.]\)\s*|/ \1 /  ;\
tb                              ;\
s/--\(.[^ |]\+\)\s*|/ \1 /g     ;\
s/--\(.[^ |]\+\)\s*/ \1 /
'`
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
_debug Using getoptex to parse arguments:
_debug $_opt

while getoptex "$_opt usage help version" "$@"
do
	_debug "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
	echo $OPTOPT | grep '-' 1> /dev/null
	if [ $? = 0 ]; then
		eval let flag_${OPTOPT//-/_}=1
		if [ ! -z "$OPTARG" ]
		then
			_debug eval let flag_${OPTOPT//-/_}_val=${OPTARG}
			eval flag_${OPTOPT//-/_}_val=${OPTARG}
		fi
	else
		eval let flag_${OPTOPT}=1
		if [ ! -z "$OPTARG" ]
		then
			_debug eval let flag_${OPTOPT}_val=${OPTARG}
			eval flag_${OPTOPT}_val=$OPTARG
		fi
	fi

	case ${OPTOPT} in
	help     ) eval flag_${OPTOPT}=1
	;;

	version  ) eval flag_${OPTOPT}=1
	;;

	usage    ) eval flag_${OPTOPT}=1
	;;
	esac

done
shift $[OPTIND-1]
for arg in "$@"
do
	echo "Non option argument <$arg>"
done
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
if [ "$flag_help" = 1 ]; then
#	_debug flag_help ON
	_help
	exit 0
else
	:
#	_debug flag_help OFF
fi

if [ "$flag_version" = 1 ]; then
#	_debug flag_version ON
	_version
	exit 0
else
	:
#	_debug flag_version OFF
fi

if [ "$flag_usage" = 1 ]; then
#	_debug flag_usage ON
	_usage
	exit 0
else
	:
#	_debug flag_usage OFF
fi

#-----------------------------------------------------------------------------
box=0; left=0; center=0; right=0
cmd=""
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
: ${flag_e:=0}
: ${flag_example:=0}
: ${flag_e_val:=0}
: ${flag_example_val:=0}

if [ "$flag_e" = "1" -o "$flag_example" = "1" ];
then
	:
	_debug "flag_e" = "$flag_e"
	_debug "flag_example" = "$flag_example"
	_debug "flag_e_val" = "$flag_e_val"
	_debug "flag_example_val" = "$flag_example_val"

	if [ "$flag_e_val" = "0" ]
	then
		code=$flag_example_val
	fi

	if [ "$flag_example_val" = "0" ]
	then
		code=$flag_e_val
	fi

	_example $code
	exit 0
fi
#-----------------------------------------------------------------------------
: ${flag_t:=0}
: ${flag_type:=0}
: ${flag_t_val:=0}
: ${flag_type_val:=0}

if [ "$flag_t" = "1" -o "$flag_type" = "1" ];
then
	:
	_debug "flag_t        = $flag_t"
	_debug "flag_type     = $flag_type"
	_debug "flag_t_val    = $flag_t_val"
	_debug "flag_type_val = $flag_type_val"
#-----------------------------------------------------------------------------
	if [ "$flag_t_val" = "0" ]
	then
		code=$flag_type_val
	fi

	if [ "$flag_type_val" = "0" ]
	then
		code=$flag_t_val
	fi

	if [ "$code" = 'c' ];
	then

		cmd=comment.cansi
		code_on=1
		source ${SHELLSCRIPT_PAKAGES}/comment-cansi.sh
		source ${SHELLSCRIPT_PAKAGES}/comment-cansi.sh
	fi

	if [ "$code" = 'cpp' ]
	then

		cmd=comment.cpp
		code_on=1
		source ${SHELLSCRIPT_PAKAGES}/comment-cpp.sh
		source ${SHELLSCRIPT_PAKAGES}/comment-cpp.sh
	fi
fi
#-----------------------------------------------------------------------------
: ${flag_b:=0}
: ${flag_box:=0}

if [ "$flag_b" = "1" -o "$flag_box" = "1" ];
then
	:
	_debug "flag_b   = $flag_b"
	_debug "flag_box = $flag_box"

	flag=1

	cmd=${cmd}.box
fi
#-----------------------------------------------------------------------------
: ${flag_r:=0}
: ${flag_right:=0}

if [ "$flag_r" = "1" -o "$flag_right" = "1" ];
then
	:
	_debug "flag_r     = $flag_r"
	_debug "flag_right = $flag_right"

	flag=1

	flag_r=1; flag_right=1;
	flag_l=0; flag_left=0;
	flag_c=0; flag_center=0;

	cmd=${cmd}r
fi
#-----------------------------------------------------------------------------
: ${flag_l:=0}
: ${flag_left:=0}

if [ "$flag_l" = "1" -o "$flag_left" = "1" ];
then
	:
	_debug "flag_l    = $flag_l"
	_debug "flag_left = $flag_left"

	flag=1

	flag_r=0; flag_right=0;
	flag_c=0; flag_center=0;
	flag_l=1; flag_left=1;

	cmd=${cmd}l
fi
#-----------------------------------------------------------------------------
: ${flag_c:=0}
: ${flag_center:=0}

if [ "$flag_c" = "1" -o "$flag_center" = "1" ];
then
	:
	_debug "flag_c      = $flag_c"
	_debug "flag_center = $flag_center"

	flag=1

	flag_r=0; flag_right=0;
	flag_c=1; flag_center=1;
	flag_l=0; flag_left=0;

	if [ "$flag_b" = "1" -o "$flag_box" = "1" ]
	then
		:
	else
		cmd=${cmd}c
	fi
fi

#-----------------------------------------------------------------------------
[ "$flag" ] || cmd=${cmd}.line

if [ "$code_on" = '1' ]; then
##############################################################################

while read line; do
	_debug :$cmd \"$line\"
	eval $( echo $line | sed "s/.*/'&'/; s/^/$cmd /")
done
##############################################################################
else
	_usage
fi
#-----------------------------------------------------------------------------
exit 0
