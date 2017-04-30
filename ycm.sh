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
#        File: ycm.sh
#        Date: Sat 14 Mar 2015 04:32:13 PM BRT
# Description:
#
# ----------------------------------------------------------------------------
#
# ----------------------------------------------------------------------------
__cansi__=0 # set OFF
__cpp11__=0 # set OFF
__cpp14__=0 # set OFF
__qt__=0 # set OFF
__gtk__=0 # set OFF
__gnome__=0 # set OFF
__help__=0 # set OFF

##############################################################################
##############################################################################
# ----------------------------------------------------------------------------
[ "$1" = '--cansi' ] && { __cansi__=1; shift; }
[ "$1" = '--cpp11' ] && { __cpp11__=1; shift; }
[ "$1" = '--cpp14' ] && { __cpp14__=1; shift; }
[ "$1" = '--qt'    ] && { __qt__=1; shift;    }
[ "$1" = '--gtk'   ] && { __gtk__=1; shift;   }
[ "$1" = '--gnome' ] && { __gnome__=1; shift; }
[ "$1" = '--help'  ] && { __help__=1; shift;  }

# ----------------------------------------------------------------------------
# Run!
# ----------------------------------------------------------------------------
if [ $__help__ -eq 1 ]; then
  #__help__ has value equal 1
  #__help__ ON
cat <<EOF
OPTIONS:
  --cansi
  --cpp11
  --cpp14
  --qt
  --gtk
  --gnome
  --help
EOF
  exit 1
fi

test -L ${HOME}/Dropbox/repos/.ycm_extra_conf.py &&
  echo rm ${HOME}/Dropbox/repos/.ycm_extra_conf.py

if [ $__cansi__ -eq 1 ]; then
  #__cansi__ has value equal 1
  #__cansi__ ON
  echo ln -s ${HOME}/Dropbox/repos/cansi.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi

if [ $__cpp11__ -eq 1 ]; then
  #__cpp11__ has value equal 1
  #__cpp11__ ON
  echo ln -s ${HOME}/Dropbox/repos/cpp11.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi

if [ $__cpp14__ -eq 1 ]; then
  #__cpp14__ has value equal 1
  #__cpp14__ ON
  echo ln -s ${HOME}/Dropbox/repos/cpp14.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi

if [ $__qt__ -eq 1 ]; then
  #__qt__ has value equal 1
  #__qt__ ON
  echo ln -s ${HOME}/Dropbox/repos/qt.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi

if [ $__gtk__ -eq 1 ]; then
  #__gtk__ has value equal 1
  #__gtk__ ON
  echo ln -s ${HOME}/Dropbox/repos/gtk.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi

if [ $__gnome__ -eq 1 ]; then
  #__gnome__ has value equal 1
  #__gnome__ ON
  echo ln -s ${HOME}/Dropbox/repos/gnome.py ${HOME}/Dropbox/repos/.ycm_extra_conf.py
fi
# ----------------------------------------------------------------------------
exit 0
