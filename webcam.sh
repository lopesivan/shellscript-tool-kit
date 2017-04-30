#!/bin/bash
# vi:set nu nowrap:
# webcam.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: webcam.sh
#        Date: Fri 05 Sep 2008 01:34:52 AM BRT
# Description:
#
#

# ----------------------------------------------------------------------------

mplayer_webcam()
{

	local  input=tv://
	local driver=v4l
	local  width=640
	local height=480
	local device=/dev/video0
	local mplayerflags="-fs -tv"

	mplayer $input         \
	        $mplayerflags  \
		driver=$driver \
	       :width=$width :height=$height \
	       :device=$device
}

#mplayer_webcam

vlc_screencast_file_flv()
{

        local   open='screen:// :screen-fps=5:dshow-fps=29.9001:nooverlay'
	local target=':sout=#transcode{vcodec=h264,vb=2048,scale=1,acodec=mp3,ab=192,channels=2}:duplicate{dst=std{access=file,mux=mp4,dst="'$1'"}}'

	echo vlc $open $target
	vlc $open $target
}

#vlc_screencast_file_flv /tmp/sample.flv

vlc_webcam_file_mpg()
{

	echo vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=640 :v4l-height=480 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100 --sout "#transcode{vcodec=mp1v,vb=1024,scale=1,acodec=mpga,ab=192,channels=2}:duplicate{dst=std{access=file,mux=mpeg1,dst=/tmp/webcam.mpg}}"
	vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=640 :v4l-height=480 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100 --sout "#transcode{vcodec=mp1v,vb=1024,scale=1,acodec=mpga,ab=192,channels=2}:duplicate{dst=std{access=file,mux=mpeg1,dst=/tmp/webcam.mpg}}"

}

vlc_webcam_file_mpg

#vlc screen:// :screen-fps=5:dshow-fps=29.9001:nooverlay:sout="#transcode{vcodec=h264,vb=2048,scale=1,acodec=mp3,ab=192,channels=1}" :duplicate{dst=std{access=file,mux=mp4,dst=/tmp/test.flv}}

# 'mplayer tv:// -tv driver=v4l:width=640:height=480:device=/dev/video0'
# 'mencoder tv:// -tv driver=v4l:width=320:height=240:device=/dev/video0 -ovc lavc -o webcam.avi'
# 'mencoder tv:// -tv driver=v4l:width=320:height=240:device=/dev/video0:forceaudio:adevice=/dev/dsp -ovc lavc -oac mp3lame -lameopts cbr:br=64:mode=3 -o webcam.avi'
# 'vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=640 :v4l-height=480 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100'
# 'vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=640 :v4l-height=480 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100 --sout "#transcode{vcodec=mp1v,vb=1024,scale=1,acodec=mpga,ab=192,channels=2}:duplicate{dst=std{access=file,mux=mpeg1,dst=/tmp/test.mpg}}"'
# ----------------------------------------------------------------------------
exit 0
