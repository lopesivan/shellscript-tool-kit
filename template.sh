#!/usr/bin/env bash
#                      __ __       ___
#                     /\ \\ \    /'___`\
#                     \ \ \\ \  /\_\ /\ \
#                      \ \ \\ \_\/_/// /__
#                       \ \__ ,__\ // /_\ \
#                        \/_/\_\_//\______/
#                           \/_/  \/_____/
#                                         Algoritimos
#
#
#      Author: Ivan Lopes
#        Mail: ivan (at) 42algoritmos (dot) com (dot) br
#        Site: http://www.42algoritmos.com.br
#     License: gpl
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: a.sh
#        Date: Sáb 04 Mar 2017 02:44:39 BRT
# Description:
#	`<  =description=  >`
# ----------------------------------------------------------------------------
#`<  =variables=  >`
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################
nversion=2.1

# ----------------------------------------------------------------------------
# Run!
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

Criando novo repositório \`kiko'
  template git --name kiko
Deletando  repositório \`kiko'
  template git --name kiko --rm

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
Usage: $_basename [COMMAND] [OPTION]...
Cria templates de projetos ou imprime modelo.

Mandatory arguments to long options are mandatory for short options too.
  -j, --java                preserve indentation of first two lines
  -c, --ansic               preserve indentation of first two lines
  -C, --cpp                 preserve indentation of first two lines
      --bash                preserve indentation of first two lines
      --ruby                preserve indentation of first two lines
      --python              preserve indentation of first two lines

  -l, --list                preserve indentation of first two lines
  -f, --function            preserve indentation of first two lines
  -b, --builder=STRING      preserve indentation of first two lines
  -n, --name=STRING         preserve indentation of first two lines
  -m, --model=STRING        preserve indentation of first two lines
  -y, --yaml=STRING         preserve indentation of first two lines
  -L, --language=STRING     preserve indentation of first two lines

      --vim      preserve indentation of first two lines
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
   | --rm        |
   | --vim       |
-l | --list      |
   | --bash      |
   | --ruby      |
   | --python    |
-j | --java      |
-c | --ansic     |
-C | --cpp       |
-f | --function  |
-b:| --builder:  |
-n:| --name:     |
-m:| --model:    |
-y:| --yaml:     |
-L:| --language: |
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
s/--\(.[^ |]\+\)\s*/ \1 /       ;\
s/|//g
'`
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
shift $[OPTIND-1]
for arg in "$@"
do
  case x$arg in
xcommands)
      echo gof git class file project|
      sed 's/ /\n/g'| sort
      exit $?
      ;;
xcompletions)
      echo \
      --vi --vim -l --list --bash --ruby \
      --python -j  --java -c  --ansic -C --cpp -g  --gof -f  --function -b \
      --builder -n --name -m --model -y --yaml |
      sed 's/ /\n/g'
      exit $?
      ;;
xlsgof)
      if [ "$#" -eq 2 ]; then
        ls ~/developer/generation/gof
        exit $?
      fi
      ;;
xlscriacionais)
      if [ "$#" -eq 3 ]; then
        ls ~/developer/generation/gof/criacionais
        exit $?
      fi
      ;;
xlsestruturais)
      if [ "$#" -eq 3 ]; then
        ls ~/developer/generation/gof/estruturais
        exit $?
      fi
      ;;
xlscomportamentais)
      if [ "$#" -eq 3 ]; then
        ls ~/developer/generation/gof/comportamentais
        exit $?
      fi
      ;;
xgof)
      __gof=1
      shift
      ;;
xcriacionais)
      __design_pattern=$2
      echo = gof criacionais "$design_pattern"=
      shift
      shift
      break
      ;;
xestruturais)
      __design_pattern=$2
      echo = gof estruturais "$design_pattern"=
      shift
      shift
      break
      ;;
xcomportamentais)
      __design_pattern=$2
      echo = gof comportamentais "$design_pattern"=
      shift
      shift
      break
      ;;
xgit|xfile|xproject|xclass)
      eval __${1}=1
      shift
      break
      ;;
xclass)
      echo = create class =
      shift
      break
      ;;
xusage)
      $_basename --usage
      exit 0
      ;;
    # x*)
    #   echo "Non option argument <$arg>"
    #   ;;
  esac
done

_debug End commnad parse: "$@"
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
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
if [ "$flag_help" = 1 ]; then
# _debug flag_help ON
  _help
  exit 0
else
  :
# _debug flag_help OFF
fi

if [ "$flag_version" = 1 ]; then
# _debug flag_version ON
  _version
  exit 0
else
  :
# _debug flag_version OFF
fi

if [ "$flag_usage" = 1 ]; then
# _debug flag_usage ON
  _usage
  exit 0
else
  :
# _debug flag_usage OFF
fi

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
: ${flag_vim:=0}

if [ "$flag_vim" = "1" ];
then
  :

  if [ "$flag_vim" = "1" ]; then
    flag_vi=${flag_vim}
  fi
  _debug "flag_vim = $flag_vim"
fi
#-----------------------------------------------------------------------------
: ${flag_rm:=0}

if [ "$flag_rm" = "1" ];
then
  :

  if [ "$flag_rm" = "1" ]; then
    flag_vi=${flag_rm}
  fi
  _debug "flag_rm = $flag_rm"
fi
#-----------------------------------------------------------------------------
: ${flag_l:=0}
: ${flag_list:=0}

if [ "$flag_l" = "1" -o "$flag_list" = "1" ];
then
  :
  if [ "$flag_l" = "1" ]; then
    flag_list=${flag_l}
  fi

  if [ "$flag_list" = "1" ]; then
    flag_l=${flag_list}
  fi
  _debug "flag_l = $flag_l"
  _debug "flag_list = $flag_list"
fi
#-----------------------------------------------------------------------------
: ${flag_bash:=0}

if [ "$flag_bash" = "1" ];
then
  :

  if [ "$flag_bash" = "1" ]; then
    flag_sh=${flag_bash}
  fi
  _debug "flag_bash = $flag_bash"
fi
#-----------------------------------------------------------------------------
: ${flag_ruby:=0}

if [ "$flag_ruby" = "1" ];
then
  :

  if [ "$flag_ruby" = "1" ]; then
    flag_rb=${flag_ruby}
  fi
  _debug "flag_ruby = $flag_ruby"
fi
#-----------------------------------------------------------------------------
: ${flag_python:=0}

if [ "$flag_python" = "1" ];
then
  :

  if [ "$flag_python" = "1" ]; then
    flag_py=${flag_python}
  fi
  _debug "flag_python = $flag_python"
fi
#-----------------------------------------------------------------------------
: ${flag_j:=0}
: ${flag_java:=0}

if [ "$flag_j" = "1" -o "$flag_java" = "1" ];
then
  :
  if [ "$flag_j" = "1" ]; then
    flag_java=${flag_j}
  fi

  if [ "$flag_java" = "1" ]; then
    flag_j=${flag_java}
  fi
  _debug "flag_j = $flag_j"
  _debug "flag_java = $flag_java"
fi
#-----------------------------------------------------------------------------
: ${flag_c:=0}
: ${flag_ansic:=0}

if [ "$flag_c" = "1" -o "$flag_ansic" = "1" ];
then
  :
  if [ "$flag_c" = "1" ]; then
    flag_ansic=${flag_c}
  fi

  if [ "$flag_ansic" = "1" ]; then
    flag_c=${flag_ansic}
  fi
  _debug "flag_c = $flag_c"
  _debug "flag_ansic = $flag_ansic"
fi
#-----------------------------------------------------------------------------
: ${flag_C:=0}
: ${flag_cpp:=0}

if [ "$flag_C" = "1" -o "$flag_cpp" = "1" ];
then
  :
  if [ "$flag_C" = "1" ]; then
    flag_cpp=${flag_C}
  fi

  if [ "$flag_cpp" = "1" ]; then
    flag_C=${flag_cpp}
  fi
  _debug "flag_C = $flag_C"
  _debug "flag_cpp = $flag_cpp"
fi
#-----------------------------------------------------------------------------
: ${flag_f:=0}
: ${flag_function:=0}

if [ "$flag_f" = "1" -o "$flag_function" = "1" ];
then
  :
  if [ "$flag_f" = "1" ]; then
    flag_function=${flag_f}
  fi

  if [ "$flag_function" = "1" ]; then
    flag_f=${flag_function}
  fi
  _debug "flag_f = $flag_f"
  _debug "flag_function = $flag_function"
fi
#-----------------------------------------------------------------------------
: ${flag_b:=0}
: ${flag_builder:=0}
: ${flag_b_val:=0}
: ${flag_builder_val:=0}

if [ "$flag_b" = "1" -o "$flag_builder" = "1" ];
then
  :
  if [ "$flag_b" = "1" ]; then
    flag_builder=${flag_b}
  fi

  if [ "$flag_builder" = "1" ]; then
    flag_b=${flag_builder}
  fi

  if [ "$flag_b" = "1" ]; then
    flag_builder_val=${flag_b_val}
  fi

  if [ "$flag_builder" = "1" ]; then
    flag_b_val=${flag_builder_val}
  fi

  _debug "flag_b = $flag_b"
  _debug "flag_builder = $flag_builder"
  _debug "flag_b_val = $flag_b_val"
  _debug "flag_builder_val = $flag_builder_val"
fi
#-----------------------------------------------------------------------------
: ${flag_n:=0}
: ${flag_name:=0}
: ${flag_n_val:=0}
: ${flag_name_val:=0}

if [ "$flag_n" = "1" -o "$flag_name" = "1" ];
then
  :
  if [ "$flag_n" = "1" ]; then
    flag_name=${flag_n}
  fi

  if [ "$flag_n" = "1" ]; then
    flag_name_val=${flag_n_val}
  fi

  if [ "$flag_name" = "1" ]; then
    flag_n=${flag_name}
  fi

  if [ "$flag_name" = "1" ]; then
    flag_n_val=${flag_name_val}
  fi

  _debug "flag_n = $flag_n"
  _debug "flag_name = $flag_name"
  _debug "flag_n_val = $flag_n_val"
  _debug "flag_name_val = $flag_name_val"
fi
#-----------------------------------------------------------------------------
: ${flag_m:=0}
: ${flag_model:=0}
: ${flag_m_val:=0}
: ${flag_model_val:=0}

if [ "$flag_m" = "1" -o "$flag_model" = "1" ];
then
  :
  if [ "$flag_m" = "1" ]; then
    flag_model=${flag_m}
  fi

  if [ "$flag_m" = "1" ]; then
    flag_model_val=${flag_m_val}
  fi

  if [ "$flag_model" = "1" ]; then
    flag_m=${flag_model}
  fi


  if [ "$flag_model" = "1" ]; then
    flag_m_val=${flag_model_val}
  fi

  _debug "flag_m = $flag_m"
  _debug "flag_model = $flag_model"
  _debug "flag_m_val = $flag_m_val"
  _debug "flag_model_val = $flag_model_val"
fi
#-----------------------------------------------------------------------------
: ${flag_y:=0}
: ${flag_yaml:=0}
: ${flag_y_val:=0}
: ${flag_yaml_val:=0}

if [ "$flag_y" = "1" -o "$flag_yaml" = "1" ];
then
  :
  if [ "$flag_y" = "1" ]; then
    flag_yaml=${flag_y}
  fi

  if [ "$flag_y" = "1" ]; then
    flag_yaml_val=${flag_y_val}
  fi

  if [ "$flag_yaml" = "1" ]; then
    flag_y=${flag_yaml}
  fi


  if [ "$flag_yaml" = "1" ]; then
    flag_y_val=${flag_yaml_val}
  fi

  _debug "flag_y = $flag_y"
  _debug "flag_yaml = $flag_yaml"
  _debug "flag_y_val = $flag_y_val"
  _debug "flag_yaml_val = $flag_yaml_val"
fi
#-----------------------------------------------------------------------------
: ${flag_L:=0}
: ${flag_language:=0}
: ${flag_L_val:=0}
: ${flag_language_val:=0}

if [ "$flag_L" = "1" -o "$flag_language" = "1" ];
then
  :
  if [ "$flag_L" = "1" ]; then
    flag_language=${flag_L}
  fi

  if [ "$flag_L" = "1" ]; then
    flag_language_val=${flag_L_val}
  fi

  if [ "$flag_language" = "1" ]; then
    flag_L=${flag_language}
  fi


  if [ "$flag_language" = "1" ]; then
    flag_L_val=${flag_language_val}
  fi

  _debug "flag_L = $flag_L"
  _debug "flag_language = $flag_language"
  _debug "flag_L_val = $flag_L_val"
  _debug "flag_language_val = $flag_language_val"
fi

#-----------------------------------------------------------------------------
# main
: ${__git:=0}
if [ "$__git" -eq 1 ]; then
  if [ "$flag_rm" = "1" ]; then
    echo delete ~/git/${flag_name_val}.git
    # if exist path `~/git/${flag_name_val}.git' then remove.
    _d=~/git/${flag_name_val}.git
    test -d $_d && rm -rf $_d
  else
    if [ "$flag_n" -eq "1" ]; then
      echo git create new repository: $flag_name_val
      git novo-repositorio-local $flag_name_val
    else
      echo define name: \``tput bold`$_basename git -n name\'
    fi
  fi
fi

#-----------------------------------------------------------------------------
exit 0
