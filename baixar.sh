# !/bin/bash


BROWSER=lynx
OPTIONS=-dump

while read URL
do
#	http://webtools.live2support.com/linux/rcp.php -> rpc.php
	with_extension=${URL//*\//}
#
#	echo 'debug: with_extension=' $with_extension

#	rpc.php -> rpc
	without_extension=${with_extension//\.php/}
#
#	echo 'debug: without_extension=' $without_extension

	$BROWSER $OPTIONS $URL| \
		sed '/Other Linux Commands:/,$d' > $without_extension.txt

done < url.tmp
