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
#       Author: Ivan carlos da Silva Lopes
#         Mail: ivanlopes (at) 42algoritimos (dot) com (dot) br
#      License: gpl
#        Site: http://www.42algoritmos.com.br
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: convert.sh
#        Date: Thu 23 Jan 2014 09:18:04 AM BRST
# Description:
#	`<  =description=  >`
# ----------------------------------------------------------------------------
#
# ----------------------------------------------------------------------------
basename=$(basename $0)
##############################################################################
##############################################################################
##############################################################################

# ----------------------------------------------------------------------------
# Run!
case $basename in
  b2to10)
    echo "ibase=2;obase=A;$1"| bc
  ;;
  b16to10)
    echo "ibase=16;obase=A;$1"| bc
  ;;
  b2to16)
    echo "ibase=A;obase=16;$(echo "ibase=2;obase=A;$1"| bc)"| bc
  ;;
  b10to16)
    echo "ibase=A;obase=16;$1"| bc
  ;;
  b16to2)
    echo "ibase=16;obase=2;$1"| bc
  ;;
  b10to2)
    echo "ibase=A;obase=2;$1"| bc
  ;;
esac

# ----------------------------------------------------------------------------
exit 0
