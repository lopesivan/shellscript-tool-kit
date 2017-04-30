#!/bin/bash
# vi:set nu nowrap:
# |n|: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: |n|
#        Date: |d|
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
source ${SHELLSCRIPT_PAKAGES}/getoptx.sh
source ${SHELLSCRIPT_PAKAGES}/getoptx.sh
#
# commun functions
#
source ${SHELLSCRIPT_PAKAGES}/util.sh
source ${SHELLSCRIPT_PAKAGES}/util.sh

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
If no FILE or if FILE is \`-\', read standard input.

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

##############################################################################

# ";" (default) -- no argument
# ":" -- required argument
# "." -- optional argument {join arg in option}

# define: "opt:"
# --opt=Value
# --opt Value
#
# define: "opt."
# --opt=Value
# --opt
#
# define: "o."
# -oValue
# -o
# define: "o:"
# -oValue
# -o Value

_opt=\
"
-e.| --example.        |
-k:| --key-word:       |
-s | --show-title      |
-b | --show-base       |
     --help            |
     --version
"
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

_debug Using getoptex to parse arguments:
echo _debug $_opt
FLAG=88
while getoptex "$_opt" "$@"
do
	_debug "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
	echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
	eval let flag_${OPTOPT//-/_}=1
	eval let flag_${OPTOPT//-/_}_val=${OPTARG}

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

if [ "$flag_help" = 1 ]; then
	_debug flag_help ON
else
	_debug flag_help OFF
fi

if [ "$flag_version" = 1 ]; then
	_debug flag_version ON
	_version
else
	_debug flag_version OFF
fi

if [ "$flag_usage" = 1 ]; then
	_debug flag_usage ON
	_usage
	exit 0
else
	_debug flag_usage OFF
fi

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

#
# -e.| --example.
#
if [ "$flag_e" = 1 -o "$flag_example" = 1 ]; then
	_debug "flag_e      = $flag_e"
	_debug "flag_example= $flag_example"
	exit 0
else
	_debug flag_example OFF
fi
#
# -k:| --key-word:
#
if [ "$flag_k" = 1 -o "$flag_key_word" = 1 ]; then
	_debug "flag_k       = $flag_k"
	_debug "flag_key_word= $flag_key_word"
	exit 0
else
	_debug flag_key_word OFF
fi
#
# -s | --show-title
#
if [ "$flag_s" = 1 -o "$flag_show_title" = 1 ]; then
	_debug "flag_s         = $flag_s"
	_debug "flag_show_title= $flag_show_title"
	exit 0
else
	_debug flag_show_title OFF
fi
#
# -b | --show-base
#
if [ "$flag_b" = 1 -o "$flag_wdth" = 1 ]; then
	_debug "flag_b    = $flag_b"
	_debug "flag_width= $flag_width"
	exit 0
else
	_debug flag_usage OFF
fi

# ----------------------------------------------------------------------------
exit 0
