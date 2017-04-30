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
    Br=1240
   fps=30
output=screencast__$$
outDir=${HOME}/screencast

test -d $outDir || mkdir -p $outDir

ffmpeg \
	-y                      \
	-f alsa -ac 2 -i pulse  \
	-f x11grab -r $fps      \
	-s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` \
	-i :0.0 -acodec pcm_s16le audio.${output}.wav       \
	-an -sameq -threads 0 mute.${output}.avi

mplayer                                  \
	-nosound                             \
	-benchmark                           \
	-vo yuv4mpeg:file=mute.${output}.y4m \
	mute.${output}.avi

x264Pass.sh \
	1                          \
	$Br                        \
	$fps                       \
	mute.${output}.${Br}k.h264 \
	mute.${output}.y4m         \
	`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`

x264Pass.sh \
	2                          \
	$Br                        \
	$fps                       \
	mute.${output}.${Br}k.h264 \
	mute.${output}.y4m         \
	`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`

neroAacEnc \
	-ignorelength           \
	-lc                     \
	-q                      \
	0.6                     \
	-if audio.${output}.wav \
	-of	audio.${output}.aac

ffmpeg -i mute.${output}.${Br}k.h264 -i audio.${output}.aac -acodec copy -vcodec copy -y ${output}.mp4

exit 0

echo ffmpeg -i ${output}.mp4  -i $ $outDir/${output}.ogg
     mv ${output}.ogv $outDir/${output}.ogg

# ----------------------------------------------------------------------------
exit 0
