#!/bin/bash
# vi:set nu nowrap:
# dev.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: dev.sh
#        Date: Sat 27 Sep 2008 08:19:39 AM BRT
# Description:
#
#

# ----------------------------------------------------------------------------

function makedev () {

	for dev in 0 1 2 3; do
		echo "/dev/$1$dev: char 81 $[ $2 + $dev ]"
		rm -f /dev/$1$dev
		mknod /dev/$1$dev c 81 $[ $2 + $dev ]
		chmod 666 /dev/$1$dev
	done

# symlink for default device io
	rm -f /dev/$1
	ln -s /dev/${1}0 /dev/$1
}

echo "*** new device names ***"
makedev video 0
makedev radio 64
makedev vtx 192
makedev vbi 224

# ----------------------------------------------------------------------------
exit 0
