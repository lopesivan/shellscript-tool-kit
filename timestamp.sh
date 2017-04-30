#!/bin/bash
# vi:set nu nowrap:
# timestamp.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: timestamp.sh
#        Date: Sat 13 Sep 2008 02:52:12 AM BRT
# Description:
#
#

# ----------------------------------------------------------------------------

file=$1
timestamp=$(date  +"%y%m%d%s" -r $file)

while true; do
	test $timestamp -eq $(date  +"%y%m%d%s" -r $file) && break
	
	ls -s $file	
	
	timestamp=$(date  +"%y%m%d%s" -r $file)
done

# ----------------------------------------------------------------------------
exit 0
