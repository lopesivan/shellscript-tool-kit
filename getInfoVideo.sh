#!/bin/bash
# vi:set nu nowrap:
# getInfoVideo.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: getInfoVideo.sh
#        Date: Sex 03 Set 2010 09:36:06 BRT
# Description:
#
#

# ----------------------------------------------------------------------------
mplayer -vo null -ao null -identify -frames 0 $1 | grep kbps
# ----------------------------------------------------------------------------
exit 0
