#!/bin/bash
# vi:set nu nowrap:
# cbn.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: cbn.sh
#        Date: Sex 08 Out 2010 04:22:19 BRT
# Description:
#
#
mp3Dir=/tmp/zacarias
mp3Dir=${HOME}/Podcasts

# ----------------------------------------------------------------------------
pods=(
http://imagens.globoradio.globo.com/cbn/podcast/comentaristas/cony-xexeo-viviane-mose.xml
http://imagens.globoradio.globo.com/cbn/podcast/comentaristas/arnaldo-jabor.xml
http://imagens.globoradio.globo.com/cbn/podcast/comentaristas/merval-pereira.xml
http://imagens.globoradio.globo.com/cbn/podcast/comentaristas/max-gehringer.xml
)

for pod in ${pods[*]}; do

	dirName=$( echo ${pod%.xml} | sed 's=.*/==' )
	url=$pod

	echo URL: $pod
	echo DIR: $dirName
	d=$mp3Dir/$dirName
	test -e $d || mkdir -p $d

	urlarr=(
		$( curl $url | grep '<media:content url='| sed 's/.*="\(.\+\).mp3".*/\1.mp3/')
	)

	for urlMp3 in ${urlarr[*]}; do

		mp3=$( echo $urlMp3 | sed 's=.*/==' )
		echo MP3: $mp3
		test -e $d/$mp3 || {
			echo "=>"$mp3;
			wget -O $d/$mp3 $urlMp3
		}

	done
done
# ----------------------------------------------------------------------------
exit 0
