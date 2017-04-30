#!/bin/bash
while true; do
clear
echo ========================================================================
echo  Alegeți canalul pe care doriți să-l vizionați :
echo ========================================================================
echo "(1) Arts & Entertainment   (Q) FOX 13                   (A) Spike TV"                        
echo "(2) ABC Family             (W) FX                       (S) MTV"              
echo "(3) ABC                    (E) Hallmark"
echo "(4) Animal Planet          (R) HBO East Coast"
echo "(5) Bravo TV               (T) History"
echo "(6) Cartoon Network East   (Y) Lifetime Movie Network"
echo "(7) CMT                    (U) National Geographic"
echo "(8) CW Austin              (I) NBC 8"
echo "(9) Discovery Channel      (O) Nickleodeon"
echo "(0) IEȘIRE                 (P) Nick Jr."
echo ========================================================================
echo 
rm -rf null.tv

echo -n "Apăsați tasta corespunzătoare canalului, sau 0 pentru a ieși: "
read input
case $input in
1) rtmpdump -v -r rtmp://live2.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/1261 -y c6kalwcnuh4lnda 2>null.tv | vlc - 2>/dev/null ;;
2) rtmpdump -v -r rtmp://live4.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12315 -y sr8z8d3qvnjdg4l 2>null.tv | vlc - 2>/dev/null ;;
3) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11089 -y pk0jje65a5bk592 2>null.tv | vlc - 2>/dev/null ;;
4) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11868 -y phtzfwm91xprx3n 2>null.tv | vlc - 2>/dev/null ;;
5) rtmpdump -v -r rtmp://live3.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11078 -y vdw9az9oprvj7tt 2>null.tv | vlc - 2>/dev/null ;;
6) rtmpdump -v -r rtmp://live8.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/3819 -y oma27ofv0du83rp 2>null.tv | vlc - 2>/dev/null ;;
7) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12463/CMT -y 91457291u7flt3t 2>null.tv | vlc - 2>/dev/null ;;
8) rtmpdump -v -r rtmp://live8.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11204/ross -y gcq9cjis2nbe2d3 2>null.tv | vlc - 2>/dev/null ;;
9) rtmpdump -v -r rtmp://live4.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/117 -y z78vu2irprzsvix 2>null.tv | vlc - 2>/dev/null ;;
Q) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12898 -y 8uqw68dw8a4z2mk 2>null.tv | vlc - 2>/dev/null ;;
W) rtmpdump -v -r rtmp://live5.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12839 -y w10uf83t64hyrhs 2>null.tv | vlc - 2>/dev/null ;;
E) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11861 -y 349fc65vqm6rrka 2>null.tv | vlc - 2>/dev/null ;;
R) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11938 -y hrz1re3i86wn2wq 2>null.tv | vlc - 2>/dev/null ;;
T) rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/395 -y 4z9g62afzm90wub 2>null.tv | vlc - 2>/dev/null ;;
Y) rtmpdump -v -r rtmp://live3.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/3820 -y mlumxp4awbq9un7 2>null.tv | vlc - 2>/dev/null ;;
U) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/118 -y 2hfoqaynv5zu706 2>null.tv | vlc - 2>/dev/null ;;
I)  rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/3809 -y uijs8reafi8i2ay 2>null.tv | vlc - 2>/dev/null ;;
O) rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/10007 -y vdoycrdqyxtmac5 2>null.tv | vlc - 2>/dev/null ;;
P) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11884 -y 19bm78dqa4wy845 2>null.tv | vlc - 2>/dev/null ;;
A) rtmpdump -v -r rtmp://live8.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/9435 -y byblfb50flghld4 2>null.tv | vlc - 2>/dev/null ;;
S) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/9554/Music_Television -y e4wbmi656z19lqw 2>null.tv | vlc - 2>/dev/null ;;


q) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12898 -y 8uqw68dw8a4z2mk 2>null.tv | vlc - 2>/dev/null ;;
w) rtmpdump -v -r rtmp://live5.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/12839 -y w10uf83t64hyrhs 2>null.tv | vlc - 2>/dev/null ;;
e) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11861 -y 349fc65vqm6rrka 2>null.tv | vlc - 2>/dev/null ;;
r) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11938 -y hrz1re3i86wn2wq 2>null.tv | vlc - 2>/dev/null ;;
t) rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/395 -y 4z9g62afzm90wub 2>null.tv | vlc - 2>/dev/null ;;
y) rtmpdump -v -r rtmp://live3.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/3820 -y mlumxp4awbq9un7 2>null.tv | vlc - 2>/dev/null ;;
u) rtmpdump -v -r rtmp://live7.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/118 -y 2hfoqaynv5zu706 2>null.tv | vlc - 2>/dev/null ;;
i)  rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/3809 -y uijs8reafi8i2ay 2>null.tv | vlc - 2>/dev/null ;;
o) rtmpdump -v -r rtmp://live1.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/10007 -y vdoycrdqyxtmac5 2>null.tv | vlc - 2>/dev/null ;;
p) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/11884 -y 19bm78dqa4wy845 2>null.tv | vlc - 2>/dev/null ;;
a) rtmpdump -v -r rtmp://live8.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/9435 -y byblfb50flghld4 2>null.tv | vlc - 2>/dev/null ;;
s) rtmpdump -v -r rtmp://live6.seeon.tv/edge -W http://www.seeon.tv/jwplayer/player.swf -p http://www.seeon.tv/view/9554/Music_Television -y e4wbmi656z19lqw 2>null.tv | vlc - 2>/dev/null ;;



0) exit
esac
shift
done
