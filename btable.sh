#!/bin/bash
# vi:set nu nowrap:
# g_opt.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: b.sh
#        Date: Sat 27 Jun 2009 06:11:23 PM EDT
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
SHELLSCRIPT_PAKAGES=$(dirname $(readlink -f $(which btable)))
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
         echo "$ $_basename -c2 -m1";
         $_basename -c2 -m1
      ;;
      2)
         echo "$ $_basename -c3 -m 1| nl  -i1  -nrz  -s'|'  -v1  -w2";
         $_basename -c3 -m 1| nl  -i1  -nrz  -s'|'  -v1  -w2
      ;;
      3)
         echo "$ $_basename -c3 -m 1,5| nl  -i1  -nrz  -s'|'  -v1  -w2| sed '1i\  \ a b c f'";
         $_basename -c3 -m 1,5| nl  -i1  -nrz  -s'|'  -v1  -w2| sed '1i\  \ a b c f'
      ;;
      all)
         for n in `seq 1 3`; do $_basename -e$n; done
      ;;
      *)
         echo "$ $_basename -c3 -m1";
         $_basename -c3 -m1
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
-c:| --columns: |
-m:| --minterm: |
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
      [ "$OPTARG" ] &&
         eval flag_${OPTOPT//-/_}_val="${OPTARG}"
   else
      eval let flag_${OPTOPT}=1
      [ "$OPTARG" ] && eval flag_${OPTOPT}_val=${OPTARG}
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
#   _debug flag_help ON
   _help
else
   :
#   _debug flag_help OFF
fi

if [ "$flag_version" = 1 ]; then
#   _debug flag_version ON
   _version
else
   :
#   _debug flag_version OFF
fi

if [ "$flag_usage" = 1 ]; then
#   _debug flag_usage ON
   _usage
   exit 0
else
   :
#   _debug flag_usage OFF
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
   _debug "flag_e = $flag_e"
   _debug "flag_example = $flag_example"
   _debug "flag_e_val = $flag_e_val"
   _debug "flag_example_val = $flag_example_val"

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
      is_minterm_ok=1
   fi

   if [ "$flag_columns_val" = "0" ]
   then
      nColumns=$flag_c_val
      is_minterm_ok=1
   fi
fi
#-----------------------------------------------------------------------------
: ${flag_m:=0}
: ${flag_minterm:=0}
: ${flag_m_val:=0}
: ${flag_minterm_val:=0}

if [ "$flag_m" = "1" -o "$flag_minterm" = "1" ];
then
   :
    _debug "flag_m          = $flag_m"
    _debug "flag_minterm    = $flag_minterm"
    _debug "flag_m_val      = $flag_m_val"
    _debug "flag_minterm_val= $flag_minterm_val"

   if [ "$flag_m_val" = "0" ]
   then
      nMinterms=$flag_minterm_val
      is_columns_ok=1
   fi

   if [ "$flag_minterm_val" = "0" ]
   then
      nMinterms=$flag_m_val
      is_columns_ok=1
   fi

fi

#-----------------------------------------------------------------------------

if [ "$is_columns_ok"="1" -a "$is_minterm_ok"="1" ]; then

   for i in $( echo $nMinterms | sed 's/,/ /g' ); do
      cmd=${cmd}$((i+1))s/0$/1/";"
   done

        eval echo `seq $nColumns   |
            tr "\n" "@"            |
            sed "s/[0-9]\+/{0,1}/g"|
            sed 's/@//g'`          |
            tr " " "\n"        |
               sed '1{x;p;x;}; s/./& /g; s/$/0/'|
                  sed "$cmd" |
                     sed '1d'
fi

#-----------------------------------------------------------------------------
exit 0
