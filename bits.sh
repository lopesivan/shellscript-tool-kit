#!/bin/bash
# vi:set nu nowrap:
# g_opt.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: bits.sh
#        Date: Sat 27 Jun 2009 06:00:47 PM EDT
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
SHELLSCRIPT_PAKAGES=$(dirname $(readlink -f $(which bits)))
source ${SHELLSCRIPT_PAKAGES}/getoptx.sh
#
# commun functions
#
source ${SHELLSCRIPT_PAKAGES}/util.sh
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
			echo "$ $_basename  -c1";
			$_basename  -c 1;
		;;
		2)
			echo "$ $_basename  -c2";
			$_basename  -c 2;
		;;
		3)
			echo "$ $_basename  -c3";
			$_basename  -c 3;
		;;
		4)
			echo "$ $_basename  -c4";
			$_basename  -c 4;
		;;
		all)
			for n in `seq 1 4`; do $_basename -e$n; done
		;;
		*)
			echo "$ $_basename  -c2";
			$_basename  -c 2;
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
-e.| --example.        |
-c:| --columns:        |
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
		[ "$OPTARG" ] && eval let flag_${OPTOPT//-/_}_val=${OPTARG}
	else
		eval let flag_${OPTOPT}=1
		[ "$OPTARG" ] && eval let flag_${OPTOPT}_val=${OPTARG}
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
else
	:
#	_debug flag_help OFF
fi

if [ "$flag_version" = 1 ]; then
#	_debug flag_version ON
	_version
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
    _debug "flag_e          = $flag_e"
    _debug "flag_example    = $flag_example"
    _debug "flag_e_val      = $flag_e_val"
    _debug "flag_example_val= $flag_example_val"

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
: ${flag_c:=0}
: ${flag_columns:=0}
: ${flag_c_val:=0}
: ${flag_columns_val:=0}

if [ "$flag_c" = "1" -o "$flag_columns" = "1" ];
then
	:
    _debug "flag_c          = $flag_c"
    _debug "flag_columns    = $flag_columns"
    _debug "flag_c_val      = $flag_c_val"
    _debug "flag_columns_val= $flag_columns_val"

	if [ "$flag_c_val" = "0" ]
	then
		nColumns=$flag_columns_val
		is_OK=1;
	fi

	if [ "$flag_columns_val" = "0" ]
	then
		nColumns=$flag_c_val
		is_OK=1;
	fi

fi

# ============================================================================
# ============================================================================
# ============================================================================

if [ "$is_OK" = "1" ];
    then
        eval echo `seq $nColumns   |
            tr "\n" "@"            |
            sed 's/[0-9]\+/{0,1}/g'|
            sed 's/@//g'`          |
            tr " " "\n"
fi

#-----------------------------------------------------------------------------
exit 0
