
#!/bin/bash
while true; do
clear
echo ==================================================================
echo  Choose the number corresponding to the channel you want to see :
echo ==================================================================
echo "."
echo "."
echo "(1)  = pop"                                  
echo "(2)  = rock"              
echo "(3)  = jazz"                 
echo "(4)  = classics"                 
echo "(5)  = onehd"            
echo "(6)  = dance"       
echo "(7)  = legend1"          
echo "(8)  = charts1"    
echo "(9)  = rmc1"     
echo "(10) = nrj_pure"        
echo "(11) = nrj_dance"        
echo "(12) = nrj_urban" 
echo "(13) = utv"        
echo "(14) = party"        
echo "(15) = kiss"  
echo "(16) = Italy"
echo "(17) = Viva"
echo "(18) = Balkanika"    
echo "(19) = Jungle TV"
echo "(20) = Music Box Slovacia"
echo "(21) = Play TV Slovenia" 
echo "(22) = MTV"  
echo "(23) = Music Box online" 
echo "(24) = Dance TV" 
echo "(25) = VIVA CEHIA"
echo "(26) = MTV Turcia"
echo "(27) = Deluxe Music"
echo "(28) = Etno TV"
echo "(29) = Muz TV MD"
echo "(30) = Mynele"
echo "(31) = Party Patrol TV"
echo "(32) = Taraf TV"
echo "(33) = VH1 Europe"

echo "."
echo "(0) = EXIT"
echo "."
echo "."
rm -rf null.tv

echo -n "Enter your choice, or 0 for exit: "
read input
case $input in
1) rtmpdump -v -r "rtmp://93.114.43.3:1935/live/pop" -W "http://live.1hd.ro/player5.3.swf" | vlc -  ;;
2) rtmpdump -v -r "rtmp://93.114.43.3:1935/live//rock" -W "http://live.1hd.ro/player5.3.swf" | vlc - ;;
3) rtmpdump -v -r "rtmp://93.114.43.3:1935/live/jazz" -W "http://live.1hd.ro/player5.3.swf" | vlc -  ;;
4) rtmpdump -v -r "rtmp://93.114.43.3:1935/live/classics" -W "http://live.1hd.ro/player5.3.swf" | vlc - ;;
5) rtmpdump -v -r "rtmp://93.114.43.3/rtplive/vlc.sdp" -W "http://live.prahovahd.ro/player.swf" | vlc - ;;
6) rtmpdump -v -r "rtmp://93.114.43.3:1935/live/dance" -W "http://live.1hd.ro/player5.3.swf" | vlc - ;;
7) rtmpdump -v -r "rtmp://fms.105.net:1935/live/legend1" | vlc - ;;
8) rtmpdump -v -r "rtmp://fms.105.net:1935/live/charts1" | vlc - ;;
9) rtmpdump -v -r "rtmp://fms.105.net:1935/live/rmc1" | vlc - ;;
10) rtmpdump -v -r "rtmp://nrjlivefs.fplive.net/nrjlive-live/nrjpure" | vlc - ;;
11) rtmpdump -v -r "rtmp://nrjlivefs.fplive.net/nrjlive-live/nrjdance" | vlc - ;;
12) rtmpdump -v -r "rtmp://nrjlivefs.fplive.net/nrjlive-live/nrjurban" | vlc -  ;;
13) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/utv/utv" | vlc - ;;
14) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/party/party" | vlc - ;;
15) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/kiss/kiss" | vlc - ;;
16) rtmpdump -v -W "http://www.freeetv.com/script/mediaplayer/player.swf" -r rtmp://fms.105.net:1935/live/italytv1 -q | vlc - ;;
17) rtmpdump -v -r "rtmp://80.94.85.180/live/stream22" | vlc - ;;
18) vlc mms://85.17.159.104/96853317?WMCache=1&WMTime=10000&Token=&MSWMExt=.asf ;;
19) vlc mms://62.162.58.41/JUNGLE_TV ;;
20) vlc mms://81.89.49.210/musicbox ;;
21) vlc mms://93.103.4.16/playtv ;;
22) vlc http://tv.x-lan.net.ua:8015/mtvu ;;
23) vlc http://iptv.klfree.cz:8006 ;;
24) vlc mms://stream02.gtk.hu/dance_tvd ;;
25) vlc http://iptv.klfree.cz:8007 ;;
26) rtmpdump -v -r "rtmp://edge10-3.nar.tv/dvrm/mtv/mtv" -W "http://www.yildiz.tv/dvr/dvrAd.swf?" -p "http://www.yildiz.tv/?act=dvr&chan=mtv" | vlc - ;;
27) rtmpdump -v -r "rtmp://deluxe.fms-live.eviscomedia.com/eviscoaglive-live/eviscoag_tv_video" -W "http://project.eviscomedia.com/deluxemusic-tv/player_tv_video.swf" -p "http://project.eviscomedia.com/deluxemusic-tv/player_tv_video.swf" -q | vlc - ;;
28) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/etno/etno" -W "http://myfreetv.ucoz.net/mediaplayer-3.swf" -q | vlc - ;;
29) vlc http://webtv.moldtelecom.md:81/muztv.flv ;;
30) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/mynele/mynele" -W "http://myfreetv.ucoz.net/mediaplayer-3.swf" -q | vlc - ;;
31) vlc mmsh://partypatrol.streaming.true.nl/partypatrol?.wma&MSWMExt=.asf ;;
32) rtmpdump -v -r "rtmp://fms1.mediadirect.ro/live/taraf/taraf" -W "http://myfreetv.ucoz.net/mediaplayer-3.swf" -q | vlc - ;;
33) rtmpdump -v -r "rtmp://live.thetvathome.com/estadio54/vh1" -W "http://www.televisaofutebol.com/player8.swf" -p "http://www.televisaofutebol.com/iframe.php" -q | vlc - ;;
0) exit
esac
shift
done
