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
number=$$

videoName=screencast__$number
outDir=${HOME}/screencast

test -d $outDir || mkdir -p $outDir

main() {
	ffmpeg \
	-y                      \
	-f x11grab -r $fps      \
	-s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` \
	-an -qscale 1 -i :0.0 -sameq -threads 0 ${videoName}.mkv
}

clean() {
	echo cp ${videoName}.mkv $outDir
    cp ${videoName}.mkv $outDir

	echo nautilus $outDir/
	echo mplayer -ao alsa -fs -idx  $outDir/${videoName}.mkv
}

#=================================== main ====================================
trap clean 0 1 2 15
main
# ----------------------------------------------------------------------------
exit 0



mplayer                                  \
	-nosound                             \
	-benchmark                           \
	-vo yuv4mpeg:file=mute.${videoName}.y4m \
	${videoName}.mkv

mplayer \
	-nocorrect-pts \
	-vo null       \
	-vc null       \
	-ao pcm:file=audio.${videoName}.wav \
	${videoName}.mkv

x264Pass.sh \
	1                          \
	$Br                        \
	$fps                       \
	mute.${videoName}.${Br}k.h264 \
	mute.${videoName}.y4m         \
	`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`

x264Pass.sh \
	2                          \
	$Br                        \
	$fps                       \
	mute.${videoName}.${Br}k.h264 \
	mute.${videoName}.y4m         \
	`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`

neroAacEnc \
	-ignorelength           \
	-lc                     \
	-q                      \
	0.6                     \
	-if audio.${videoName}.wav \
	-of	audio.${videoName}.aac

ffmpeg \
	-i mute.${videoName}.${Br}k.h264 \
	-i audio.${videoName}.aac        \
	-acodec copy -vcodec copy        \
	-y ${videoName}.mp4

# ----------------------------------------------------------------------------
exit 0
