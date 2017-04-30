#!/bin/bash
__debug__=0; __help__=0
__usage__=0
# ----------------------------------------------------------------------------
[ "$1" = '-d'      ] && {   ECHO=echo; shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '-h'      ] && { __help__=1; shift;  }
[ "$1" = '--help'  ] && { __help__=1; shift;  }
[ "$1" = '--usage' ] && { __usage__=1; shift; }
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

# vi:set nu nowrap:
# last-email.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: last-email.sh
#        Date: Ter 19 Out 2010 14:43:13 BRST
# Description:
#
#
user=lopesivan.ufrj@gmail.com
pass=
# ----------------------------------------------------------------------------
curl -u ${user}:${pass} --silent \
	"https://mail.google.com/mail/feed/atom" \
	| sed '1,/\<entry\>/d' \
		| awk -F '[<>]' \
'   	/<title>/ 
			{ print "msg",$3 }
		/<name>/
			{ print "\t-",$3  }
		BEGIN {
			print ":::GMAIL by Ivan:::"
		}
'
# ----------------------------------------------------------------------------
exit 0
