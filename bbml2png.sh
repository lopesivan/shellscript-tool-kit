#!/bin/bash
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
#        File: bbml2png.sh
#        Date: Mon 01 Jul 2013 01:33:57 PM BRT
# Description:
#	

# ----------------------------------------------------------------------------
__debug__=0; __help__=0
__usage__=0
__clean__=0
# ----------------------------------------------------------------------------
[ "$1" = '--gui'   ] && { __gui__=1; shift;   }
[ "$1" = '-h'      ] && { __help__=1; shift;  }
[ "$1" = '--help'  ] && { __help__=1; shift;  }
[ "$1" = '-d'      ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--usage' ] && { __usage__=1; shift; }
[ "$1" = '--clean' ] && { __clean__=1; shift; }
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

# ----------------------------------------------------------------------------

mockupsApp="/usr/local/bin/balsamiq_mockups" 

cdir=`pwd`; 
for f in `find . -name "*.bmml" | awk '{gsub(/ /,"%20");print}'`; 
do 
	infile=`echo ${cdir}/${f} | awk '{gsub(/%20/, "\ ");print}'`; 
	outfile=`echo $infile | awk '{sub(/bmml/,"png");print}'`; 
	echo "Converting $infile to $outfile"; 
	`"$mockupsApp" export "$infile" "$outfile"`; 
done 

# ----------------------------------------------------------------------------
exit 0
