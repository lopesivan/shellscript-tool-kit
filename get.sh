#!/bin/bash
# vi:set nu nowrap:
# get.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: get.sh
#        Date: Ter 07 Set 2010 01:19:57 BRT
# Description:
#
#

get=$1
opt=$2
#================================= functions =================================

function getIp() {

	[ "$1" ] && local ethx=eth$1

	# cmd
	ifconfig ${ethx:=eth0} \
	| sed 's/.*inet [^ :]\+:\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/'
}

# ----------------------------------------------------------------------------
case $get in
	ip)
		shift;
		getIp $1;
	;;

	*) echo default ...

	;;
esac

# ----------------------------------------------------------------------------
exit 0
