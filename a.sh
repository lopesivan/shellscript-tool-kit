#!/bin/bash
# vi:set nu nowrap:
# a.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: a.sh
#        Date: Fri 26 Jun 2009 09:25:06 AM EDT
# Description:
#
#

# ----------------------------------------------------------------------------
value=20

ref=value

eval echo \$$ref

for i in alpha beta teta; do
	echo $i;
	eval $i=\$$RANDOM
done

echo --//--
echo $alpha
echo $beta
echo $teta

# ----------------------------------------------------------------------------
exit 0
