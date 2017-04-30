#!/bin/bash
# vi:set nu nowrap:
# g_opt.sh: <+ =Short Description= +>.

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
-c | --crown-margin    |
-p:| --prefix:         |
-s | --split-only      |
-t | --tagged-paragraph|
-u | --uniform-spacing |
-w:| --width:          |
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
	_debug "flag_e" = "$flag_e"
	_debug "flag_example" = "$flag_example"
	_debug "flag_e_val" = "$flag_e_val"
	_debug "flag_example_val" = "$flag_example_val"
fi
#-----------------------------------------------------------------------------
: ${flag_c:=0}
: ${flag_crown_margin:=0}

if [ "$flag_c" = "1" -o "$flag_crown_margin" = "1" ];
then
	:
	_debug "flag_c" = "$flag_c"
	_debug "flag_crown_margin" = "$flag_crown_margin"
fi
#-----------------------------------------------------------------------------
: ${flag_p:=0}
: ${flag_prefix:=0}
: ${flag_p_val:=0}
: ${flag_prefix_val:=0}

if [ "$flag_p" = "1" -o "$flag_prefix" = "1" ];
then
	:
	_debug "flag_p" = "$flag_p"
	_debug "flag_prefix" = "$flag_prefix"
	_debug "flag_p_val" = "$flag_p_val"
	_debug "flag_prefix_val" = "$flag_prefix_val"
fi
#-----------------------------------------------------------------------------
: ${flag_s:=0}
: ${flag_split_only:=0}

if [ "$flag_s" = "1" -o "$flag_split_only" = "1" ];
then
	:
	_debug "flag_s" = "$flag_s"
	_debug "flag_split_only" = "$flag_split_only"
fi
#-----------------------------------------------------------------------------
: ${flag_t:=0}
: ${flag_tagged_paragraph:=0}

if [ "$flag_t" = "1" -o "$flag_tagged_paragraph" = "1" ];
then
	:
	_debug "flag_t" = "$flag_t"
	_debug "flag_tagged_paragraph" = "$flag_tagged_paragraph"
fi
#-----------------------------------------------------------------------------
: ${flag_u:=0}
: ${flag_uniform_spacing:=0}

if [ "$flag_u" = "1" -o "$flag_uniform_spacing" = "1" ];
then
	:
	_debug "flag_u" = "$flag_u"
	_debug "flag_uniform_spacing" = "$flag_uniform_spacing"
fi
#-----------------------------------------------------------------------------
: ${flag_w:=0}
: ${flag_width:=0}
: ${flag_w_val:=0}
: ${flag_width_val:=0}

if [ "$flag_w" = "1" -o "$flag_width" = "1" ];
then
	:
	_debug "flag_w" = "$flag_w"
	_debug "flag_width" = "$flag_width"
	_debug "flag_w_val" = "$flag_w_val"
	_debug "flag_width_val" = "$flag_width_val"
fi
#-----------------------------------------------------------------------------
exit 0
