#!/bin/bash
while true; do
clear
echo ========================================================================
echo  Alegeți canalul pe care doriți să-l vizionați :
echo ========================================================================
echo "(1) Dolce sport    (Q) TVR Cultural        (A) Kiss TV"                        
echo "(2) Dolce sport 2  (W) TVR International   (S) Transilvania channel"              
echo "(3) Antena 2       (E) TVR Info            (D) Taraf TV"
echo "(4) Antena 3       (R) TVR HD              (F) TV5 Monde"
echo "(5) Realitatea TV  (T) OTV                 (G) Party TV"
echo "(6) B1 TV          (Y) UTV                 (H) Deutsche Welle"
echo "(7) TVR 1          (U) Mynele TV"
echo "(8) TVR 2          (I) Etno TV"
echo "(9) TVR 3          (O) The Money Channel"
echo "(0) IEȘIRE         (P) Euronews"
echo ========================================================================
echo 
rm -rf null.tv

echo -n "Apăsați tasta corespunzătoare canalului, sau 0 pentru a ieși: "
read input
case $input in
1) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/dolcesport?id=14703526/dolcesport" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
2)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/dolcesport2?id=14703526/dolcesport2" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
3) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/antena2?id=14703526/antena2" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
4) rtmpdump -r "rtmpe://fms-de01.mediadirect.ro:80/live2/antena3?id=3222416/antena_3" -s "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
5) rtmpdump -r "rtmpe://fms-de01.mediadirect.ro:1935/live2/realitatea?id=3222416/realitatea" -s "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
6) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/b1?id=14703526/b1" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
7) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvr1?id=14703526/tvr1" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
8)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvr2?id=14703526/tvr2" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
9) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvr3?id=14703526/tvr3" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
Q) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrcultural?id=14703526/tvrcultural" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
W)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvr?id=14703526/tvr" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
E) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrinfo?id=14703526/tvrinfo" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
R) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrhd?id=14703526/tvrhd" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
T) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/otv?id=14703526/otv" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
Y) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/utv?id=14703526/utv" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
U) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/mynele?id=14703526/mynele" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
I) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/etno?id=14703526/etno" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
O) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/money?id=14703526/money" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
P) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/euronews?id=14703526/euronews" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
A)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/kiss?id=14703526/kiss" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
S) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/somes?id=14703526/somes" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
D) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/taraf?id=14703526/taraf" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;; 
F) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tv5?id=14703526/tv5" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
G) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/party?id=14703526/party" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
H) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/dw?id=14703526/dw" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null;;
q) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrcultural?id=14703526/tvrcultural" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
w)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvr?id=14703526/tvr" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
e) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrinfo?id=14703526/tvrinfo" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
r) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tvrhd?id=14703526/tvrhd" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
t) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/otv?id=14703526/otv" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
y) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/utv?id=14703526/utv" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
u) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/mynele?id=14703526/mynele" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
i) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/etno?id=14703526/etno" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
o) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/money?id=14703526/money" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
p) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/euronews?id=14703526/euronews" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
a)  rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/kiss?id=14703526/kiss" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
s) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/somes?id=14703526/somes" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
d) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/taraf?id=14703526/taraf" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;; 
f) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/tv5?id=14703526/tv5" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
g) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/party?id=14703526/party" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null ;;
h) rtmpdump -v -r "rtmpe://fms-de01.mediadirect.ro:80/live/dw?id=14703526/dw" -W "http://static.mediadirect.ro/player-preload/swf/preloader/preloader.swf" 2>null.tv | vlc - 2>/dev/null;;


0) exit
esac
shift
done
