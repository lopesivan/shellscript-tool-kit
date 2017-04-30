#!/usr/bin/env bash
#
#      Author:
#        Mail:
#        Site:
#     License:
#       Phone:
#    Language: Shell Script
#        File:
#        Date:
# Description:
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

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
$_basename (42algoritmos tools) $nversion
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
Usage: $_basename [commnads] [-a|--add] [-l|--list] [-n|--name=<name>]...
Manipula Template de arquivos.

commands: [add|ls|x|cp|rm]

exemplos:
  cp \$($_basename  -l -n wx.2.8 ) .
  $_basename add Makefile
  $_basename cp x-exemplo .
  $_basename -a -n wx.2.8
  $_basename cp x-kibe .
  $_basename ln x-kibe /tmp
  $_basename -d -a -n wx.2.8
  $_basename -d -l
  $_basename -d -l -n wx.2.8
  $_basename -d -n kibe
  $_basename -d -n kibe -l
  $_basename --help
  $_basename ls
  $_basename ls command
  $_basename rm x-exemplo
  $_basename copy arquivo.txt
  $_basename x

Neste exemplo criamos o template x-sed
  $_basename -n sed -a # adicionamos os arquivos
  $_basename x         # mostrando x-sed ou x-prpojects ...
  $_basename -n sed -l # listando conteúdo
  $_basename rm x-sed  # removendo x-sed

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
Usage: $_basename [commnads] [options]

Options: Manipula Template de arquivos.
  -a, --add              adiciona path dos arquivos presentes no diretório,
  -l, --list             lista os paths dos x-projects,
  -n, --name=NomeProjeto especificamos o nome do Zarray do redis, com os
                         paths.
      --help     display this help and exit
      --version  output version information and exit

commands: [add|ls|ln|link|x|cp|rm]
   add                   adiciona path de um único arquivo, usando como
                         key o nome do arquivo,
   ls                    lista as keys do redis,
   x                     lista apenas os x-projects,
   cp                    copia todos os arquivos contidos em um x-project
   ln                    linka de forma simbolica todos os arquivos contidos
                         em um x-project,
                         para um diretório específico,
   copy                  copia um path único que foi adicionado com add,
   link                  linka um path único que foi adicionado com add,
   rm                    remove um key.

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
-a | --add             |
-l | --list            |
-n:| --name:           |
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
  case x$arg in
xcommands)
      echo add ls x cp ln copy link rm completions commands keys|
      sed 's/ /\n/g'| sort
      exit $?
      ;;
xkeys)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      redis-cli keys \*
      exec 6>&- # close the connection
      exit $?
      ;;
xcompletions)
      # echo --help --version --usage -a --add -l --list -n --name|
      # sed 's/ /\n/g'
      redis-cli KEYS \* | grep -v vimmru
      exit $?
      ;;
    xrm)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      [ $2 ] && redis-cli del $2
      exec 6>&- # close the connection
      exit $?
      ;;
    xcopy)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      src=$2
      dest=$3
      [ $2 ] && redis-cli get $src | xargs cp -t ${dest:=.}
      exec 6>&- # close the connection
      exit $?
      ;;
    xlink)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      src=$2
      dest=$3
      [ $2 ] && redis-cli get $src | xargs -n1 -I{} ln -s {} ${dest:=.}
      exec 6>&- # close the connection
      exit $?
      ;;
    xcp)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      [ $2 ] && redis-cli ZRANGE $2 0 -1 | xargs cp -t $3
      exec 6>&- # close the connection
      exit $?
      ;;
    xln)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      [ $2 ] && redis-cli ZRANGE $2 0 -1 | xargs -n1 -I{} ln -s {} $3
      exec 6>&- # close the connection
      exit $?
      ;;
    xx)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      redis-cli keys \* | grep 'x-'| sort
      #sed -e "s/[0-9]\+\s\+/&`tput bold`/" -e "s/$/`tput rmso`/"
      exec 6>&- # close the connection
      exit $?
      ;;
    xe)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      [ $2 ] && { redis-cli get $2 | xargs vim ; }
      exec 6>&- # close the connection
      exit $?
      ;;
    xls)
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
      if [ $# -eq 2 ]; then
        redis-cli TYPE $2| grep -q 'zset'
        if [ $? -eq 0 ]; then
          redis-cli ZRANGE $2 0 -1
        else
          redis-cli get $2 | sed "s/^/`tput bold` /";
        fi
      else
        redis-cli keys \* | sed "s/^/`tput bold` /" | cat -n
      fi
      exec 6>&- # close the connection
      exit $?
      ;;
    xadd)
      echo Adicionando arquivo: $2
      source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
      exec 6<>/dev/tcp/localhost/6379 # open the connection
        redis-client 6 SET $2 $PWD/$2
      exec 6>&- # close the connection
      exit $?
    ;;
    x*)
      echo "Non option argument <$arg>"
    ;;
  esac
done
#-----------------------------------------------------------------------------
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
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
: ${flag_a:=0}
: ${flag_add:=0}

if [ "$flag_a" = "1" -o "$flag_add" = "1" ];
then
  :
  if [ "$flag_a" = "1" ]; then
    flag_add=${flag_a}
  fi

  if [ "$flag_add" = "1" ]; then
    flag_a=${flag_add}
  fi
  _debug "flag_a = $flag_a"
  _debug "flag_add = $flag_add"
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

  if [ "$flag_name" = "1" ]; then
    flag_n=${flag_name}
  fi

  if [ "$flag_n" = "1" ]; then
    flag_name_val=${flag_n_val}
  fi

  if [ "$flag_name" = "1" ]; then
    flag_n_val=${flag_name_val}
  fi

  _debug "flag_n = $flag_n"
  _debug "flag_name = $flag_name"
  _debug "flag_n_val = $flag_n_val"
  _debug "flag_name_val = $flag_name_val"
fi

# ----------------------------------------------------------------------------
# Run!

if [ "$flag_n" = "1" -a "$flag_a" = "1" ];
then
  source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
  exec 6<>/dev/tcp/localhost/6379 # open the connection
  for f in *; do
    test -f $f && redis-client 6 ZADD x-$flag_name_val 1 $PWD/$f
  done| wc -l| sed 's/^.*/add: & files/'
  exec 6>&- # close the connection
fi

if [ "$flag_n" = "1" -a "$flag_l" = "1" ];
then
  source ${HOME}/developer/redis-bash/redis-bash-lib # include the library
  exec 6<>/dev/tcp/localhost/6379 # open the connection
  redis-cli ZRANGE x-$flag_name_val 0 -1
  exec 6>&- # close the connection
fi

#-----------------------------------------------------------------------------
exit 0
