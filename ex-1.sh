
#!/bin/bash
### rtmpdump handshake-fix ###
## http://lists.mplayerhq.hu/pipermail/rtmpdump/2011-March/001328.html
## http://lists.mplayerhq.hu/pipermail/rtmpdump/2011-March/001332.html

### URLS ###
URL="http://darbycrash.altervista.org/uplinks.txt"
#URL="http://nst-team.freehostia.com/data.txt"

ZATTMP=/tmp/zattoo.txt

function select_channel(){
   if [[ ! -f "$ZATTMP" || $(( $(date +%s) - $(stat -c %Y "$ZATTMP") )) -gt 300 ]]; then
      curl "$URL" > "$ZATTMP"
   fi
      CHANNEL=`cat "$ZATTMP" | grep "zattoo" | awk -F '?' '{print $1}' | awk -F '/' '{print $5}' | sed 's/s_//g' | sort | zenity --height=450 --width=220 --list --column="Channels" --title="Zattoo TV" --text="Select Channel:"`
}

function play_stream(){
   STREAM=`cat "$ZATTMP" | grep "$CHANNEL" | tr -d '\015'` #dos2unix
   rtmpdump -v -r "$STREAM" -W "http://zattoo.com/static/player.swf?" | vlc - #mplayer -nomouseinput -
}

while [ $? -eq 0 ]; do
   select_channel && play_stream
done

