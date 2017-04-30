#!/bin/bash
# vi:set nu nowrap:
# gravador.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: gravador.sh
#        Date: Sun 08 Nov 2009 05:02:11 PM BRST
# Description:
#
#

# ----------------------------------------------------------------------------
record=recordmydesktop
wxh=$(xdpyinfo | grep 'dimensions:'|awk '{print $2}')
 width=${wxh%x*}
height=${wxh#*x}
   fps=60
output=screencast__$$
outDir=${HOME}/screencast

#./recordmydesktop --width $width --height $height --fps $fps -o $output

test -d $outDir || mkdir -p $outDir

$record  --no-sound --width $width --height $height --fps $fps -o $output
#$record --no-sound --fps $fps -o $output
echo mv ${output}.ogv $outDir/${output}.ogg
     mv ${output}.ogv $outDir/${output}.ogg

# ----------------------------------------------------------------------------
exit 0
