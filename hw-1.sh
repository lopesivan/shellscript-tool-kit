#!/bin/bash
# vi:set nu nowrap:
# g_opt.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: hw-1.sh
#        Date: Tue 13 Oct 2009 02:49:47 AM BRT
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
-e.| --example. |
-l:| --lang:    |
-c | --cansi    |
-C | --cpp      |
-t | --tex      |
-H | --html     |
-p | --py       |
-a | --auto:    |
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
		eval flag_${OPTOPT//-/_}=1
		[ "$OPTARG" ] && eval flag_${OPTOPT//-/_}_val=${OPTARG}
	else
		eval flag_${OPTOPT}=1
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

cat << _EOF
$_basename -l C           # hello.cpp
$_basename --lang cpp     # hello.cpp
$_basename --lang cansi   # hello.c
$_basename -l c           # hello.c
$_basename --lang tex     # hello.tex
$_basename --tex          # hello.tex
$_basename -l t           # hello.tex
$_basename --lang html    # hello.html
$_basename -l H           # hello.html
$_basename --lang py      # hello.py
$_basename -l py          # hello.py
$_basename --py           # hello.py
$_basename --auto prjName # autotools project
$_basename -a             # autotools project
_EOF

fi
#-----------------------------------------------------------------------------
: ${flag_l:=0}
: ${flag_lang:=0}
: ${flag_l_val:=0}
: ${flag_lang_val:=0}

if [ "$flag_l" = "1" -o "$flag_lang" = "1" ];
then
	:
	_debug "flag_l = $flag_l"
	_debug "flag_lang = $flag_lang"
	_debug "flag_l_val = $flag_l_val"
	_debug "flag_lang_val = $flag_lang_val"

	if [ "$flag_l_val" = "c" -o "$flag_lang_val" = "c" ];
	then
		flag_c=1
	fi

	if [ "$flag_l_val" = "C" -o "$flag_lang_val" = "cpp" ];
	then
		flag_C=1
	fi

	if [ "$flag_l_val" = "t" -o "$flag_lang_val" = "tex" ];
	then
		flag_t=1
	fi

	if [ "$flag_l_val" = "py" -o "$flag_lang_val" = "python" ];
	then
		flag_p=1
	fi

	if [ "$flag_l_val" = "H" -o "$flag_lang_val" = "html" ];
	then
		flag_H=1
	fi
fi
#-----------------------------------------------------------------------------
: ${flag_c:=0}
: ${flag_cansi:=0}

if [ "$flag_c" = "1" -o "$flag_cansi" = "1" ];
then
	:
	_debug "flag_c = $flag_c"
	_debug "flag_cansi = $flag_cansi"

# get source here!

cat << _EOF
/* hello.c: A standard "Hello, world!" program */

#include <stdio.h>

int
main (int argc, char *argv[])
{
    printf ("Hello, world!\n");

    return 0;
}
_EOF
fi
#-----------------------------------------------------------------------------
: ${flag_C:=0}
: ${flag_cpp:=0}

if [ "$flag_C" = "1" -o "$flag_cpp" = "1" ];
then
	:
	_debug "flag_C = $flag_C"
	_debug "flag_cpp = $flag_cpp"

# get source here!

cat << _EOF
/* hello.cpp: A standard "Hello, world!" program */
#include <iostream>

using namespace std;

//
// main
//

int main()
{
    cout << "hello, world" << endl;

    return 0; // success return
}
_EOF
fi
#-----------------------------------------------------------------------------
: ${flag_t:=0}
: ${flag_tex:=0}

if [ "$flag_t" = "1" -o "$flag_tex" = "1" ];
then
	:
	_debug "flag_t = $flag_t"
	_debug "flag_tex = $flag_tex"

# get source here!

cat << _EOF
\documentclass[a4paper,12]{article}
%%% --------------------------------------------------------------------------
\\begin{document}
%-----------------------------------------------------------------------------

Ol\\'{a} Mundo.

%%% --------------------------------------------------------------------------
\\end{document}
%-----------------------------------------------------------------------------
_EOF
fi
#-----------------------------------------------------------------------------
: ${flag_H:=0}
: ${flag_html:=0}

if [ "$flag_H" = "1" -o "$flag_html" = "1" ];
then
	:
	_debug "flag_H = $flag_H"
	_debug "flag_html = $flag_html"

# get source here!

cat << _EOF
<html>
	<body>

		<h1>My First Heading</h1>

		<p>My first paragraph.</p>

	</body>
</html>
_EOF
fi
#-----------------------------------------------------------------------------
: ${flag_p:=0}
: ${flag_py:=0}

if [ "$flag_p" = "1" -o "$flag_py" = "1" ];
then
	:
	_debug "flag_p = $flag_p"
	_debug "flag_py = $flag_py"

# get source here!

cat << _EOF
# -*- coding: utf-8 -*-

'''
Os itens contidos em objetos da classe Lista podem ser acessados pelos
ordinais de 'primeiro' até 'decimo', ou por abreviaturas de três letras
destes ordinais:

>>> l = Lista([11, 22, 33, 44, 55])
>>> l.primeiro
11
>>> l.ter
33

'''

# A implementação ficou assim:

from itertools import count

class Lista(list):

    __ordinais = ('primeiro segundo terceiro quarto quinto sexto setimo'
                  ' oitavo nono decimo').split()
    __abrevs   = [s[:3] for s in __ordinais]

    def __getattr__(self, atrib):
        atr = atrib[:3]
        for i, ordinal, abrev in zip(count(), self.__ordinais, self.__abrevs):
            if atrib == ordinal or atr == abrev:
                return self[i]
            else:
                msg = "'%s' object has no attribute '%s'"
                raise AttributeError(msg % (self.__class__.__name__, atrib))

    @property
    def ultimo(self):
        return self[-1]

    ult = ultimo
_EOF
fi
#-----------------------------------------------------------------------------
: ${flag_a:=0}
: ${flag_auto:=0}
: ${flag_auto_val:=autodemo}

if [ "$flag_a" = "1" -o "$flag_auto" = "1" ];
then
	:
	_debug "flag_a = $flag_a"
	_debug "flag_auto = $flag_auto"
	_debug "flag_a_val = $flag_a_val"
	_debug "flag_auto_val = $flag_auto_val"

# get source here!
if [ "$flag_auto_val" = "autodemo" ];
then
	autodemo=autodemo
else
	autodemo=$flag_auto_val
fi

if [ -e $autodemo ];
	then rm -r $autodemo;
fi

mkdir -p $autodemo
cd $autodemo

cat > hello.c <<_EOF
#include <stdio.h>
int main()
{
	printf("Hi.\n");
}
_EOF

cat > Makefile.am <<_EOF
bin_PROGRAMS=hello
hello_SOURCES=hello.c
_EOF

touch NEWS README AUTHORS ChangeLog #still cheating

autoscan
pwd
sed \
-e 's/FULL-PACKAGE-NAME/hello/' \
-e 's/VERSION/1/' \
-e 's|BUG-REPORT-ADDRESS|/dev/null|' \
-e '10i\
AM_INIT_AUTOMAKE' \
< configure.scan > configure.ac

autoreconf -iv
./configure
make distcheck

fi
#-----------------------------------------------------------------------------
exit 0

