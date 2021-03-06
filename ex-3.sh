#!/bin/bash
#  Script di Elrond, con la collaborazione di c.realkiller modificato da zerocoll
#+ Ultimo aggiornamento: 21/05/2011
#+ Per suggerimenti e consigli visita http://forum.ubuntu-it.org/index.php/topic,442972.0.html
#+ lo script e di libero utilizzo puoi modificarlo a tuo piacimento sempre se sai cosa fare :P
#+ ma alla fine non e una cosa difficilissima basta sbattersi un po ^__^
#+ un grazie  va a tutti quelli che mi hanno aiutato anche nel testare lo script
#  nb: non ho eliminato quasi nulla dallo script precedente ho solo commentato qualcosa voi siete liberi di farci quello che volete
#  un saluto da zerocol

#  dipendenze:  curl, vlc, zenity, rtmpdump , python-qt4  ( per il televideo)

########## DEFINIZIONE VARIABILI UTILIZZATE NELLO SCRIPT ##########
#  User agent del riproduttore. Serve solo per riprodurre le dirette RAI.
#+ NON modificare se non sai quello che fai!
#USER_AGENT="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20090910 Firefox/3.5.3"

#  Player utilizzato. NOTA BENE: è possibile usare solo `vlc', `mplayer' o `gmplayer'.
#+ Modificalo come preferisci fra le 3 opzioni possibili. Ricorda inoltre che `mplayer'
#+ e `gmplayer' non permettono di riprodurre correttamente i TG regionali.
#PLAYER=`zenity --list --height=200 --width=150 --title="SELECT PLAYER" --text="quale player vuoi usare?" --column="PLAYER"\
 #               "vlc" "gmplayer" "mplayer"`

#  Nome dell'emulatore di terminale usato per visualizzare il televideo. Se non è
#+ impostato nessun valore viene usato `xterm' di defualt.
TERMINALE=xterm
########## FINE DEFINIZIONE VARIABILI ##########
########## INIZIO DEFINIZIONE DELLE FUNZIONI USATE NELLO SCRIPT ##########
while [ $? -eq 0 ]; do
# Funzione per scegliere l'operazione da eseguire all'inizio
function scelta_operazione() {
    operazione=`zenity --width=200 --height=250 --list --column "scelta" --title="select stream tv or radio" --text="Vuoi vedere la TV o ascoltare la radio?" "STREAM TV NAZIONALI" "STREAM TV LOCALI" "STREAM TV MUSICALI" "STREAM TV ZATTO" "STREAM TV ESTERI" "STREAM RADIO" "TG REGIONE" "TELEVIDEO"`
}

# Funzione per scegliere la stazione radio da riprodurre
function scelta_stazione(){
    stazione=`zenity --list --height=400 --width=300 --title="Televisione" --text="Quale canale vuoi ascoltare?" --column="Canale"\
        "Radio Uno" "Radio Due" "Radio Tre" "Isoradio" "RDS" "Radio 105" "RTL 102.5" "Radio Capital" "Radio Deejay" "Radio24" \
    "Controradio" "Radio Popolare" "Radio Onda Rossa" "Radio onda d'Urto" "Radio Italia" "Radio Monte Carlo" "Radio Blackout" "Radio Sherwood" \
    "Virgin radio" "Virgin rock classico" "Virgin rock extreme" "Virgin rock alternative" "RIN" "Radio KissKiss" "Radio Bruno" \
    "Radio Fantastica"`
}

# Funzione per scegliere la il canale televisivo da riprodurre
function scelta_nazionale(){
    nazionale=`zenity --list --height=400 --width=300 --title="Televisione" --text="Quale canale vuoi vedere?" --column="Canale"\
        "Rai Uno" "Rai Due" "Rai Tre" "Rai Quattro" "Rsi La 1" "Rsi La 2" "RaiMed" "RaiSport1" "RaiSport2" "Rai5" "RaiPremium"\
    "RaiGulp" "RaiStoria" "RayYoYo" "Cielo" "RaiCinema" "RaiNews" "Canale5" "Rete 4" "Italia 1" "La 7" "RaiScuola" "RaiInternational"\
    "Sky Tg 24" "Euronews" "SportItalia24" "Inter tv" "SuperTennis.tv" "ComingSoon TV"`
}

# Funzione per scegliere la il canale televisivo da riprodurre

# Funzione per scegliere la il canale televisivo da riprodurre
function scelta_locale(){
    locale=`zenity --list --height=400 --width=300 --title="Televisione" --text="Quale canale vuoi vedere?" --column="Canale"\
        "Canale 7" "Canale 9" "Canale 10" "GRP" "7 Gold" "QVC" "Altaitalia TV" "Videolina" "Umbria TV" "Antenna Sicilia" "Quararete TV"`
}

# Funzione per scegliere la il canale televisivo da riprodurre
function scelta_musicale(){
    musicale=`zenity --list --height=400 --width=300 --title="Televisione" --text="Quale canale vuoi vedere?" --column="Canale"\
        "105 TV" "Virgin TV" "DeeJay TV" "RTL102.5 TV" "RMC TV" "Rock One TV" "The Vault Music"`
}

# Funzione per scegliere la il canale televisivo da riprodurre
function scelta_estera(){
    estera=`zenity --list --height=400 --width=300 --title="Televisione" --text="Quale canale vuoi vedere?" --column="Canale"\
        "Al Jazeera Eng" "France 24 Eng" "BBC News 24" "mtv" "tsr1" "tsr2" "tele5" "sf1" "sf2" "sfinfo" "CNNint" "viva" "BBC 1" "BBC 2" "rte1" "rte2" "ESPN" "RT Eng" "SkyNews"`
}

# Funzione per scegliere la regione di cui riprodurre l'ultimo TG regionale di RAI 3
function seleziona_regione(){
    regione=`zenity --list --height=400 --width=300 --title="Tg Regione" --text="Seleziona la regione:" --column="Regione" "Abruzzo"\
    "Basilicata" "Calabria" "Campania" "Emilia-Romagna" "Friuli-Venezia Giulia" "Lazio" "Liguria" "Lombardia" "Marche" "Molise"\
    "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Trentino-Alto Adige" "Umbria" "Valle d'Aosta" "Veneto"`
}

# Funzione per scegliere la regione di cui riprodurre l'ultimo TG regionale di RAI 3

if [ ! -f ~/.data/canali.txt ]; then
cd ~/.data/
wget  http://nst-team.freehostia.com/canali.txt
fi

if [ ! -f ~/.data/ca-bundle.crt ]; then
cd ~/.data/
wget  http://nst-team.freehostia.com/ca-bundle.tar
tar -xf "ca-bundle.tar"
rm ca-bundle.tar
fi

function scelta_zatto(){
email=`cat ~/.data/email`

pass=`cat ~/.data/pass`

lista=`cat ~/.data/canali.txt | cut -d ' ' -f1 | sort | zenity --height=450 --width=220 --list --column="Channels" --title="Zattoo TV" --text="Select Channel:"`

canale=`cat ~/.data/canali.txt | grep -r $lista | cut -d ' ' -f3 | tr -d '\015'`

curl --cacert ~/.data/ca-bundle.crt --user-agent "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.7) Gecko/20100713 (CK-IBM) Firefox/3.0.17;MEGAUPLOAD 1.0 ( .NET CLR 3.5.30729)" -x 195.162.130.20:8080 --user-agent "Mozilla/4.73 [en] (X11; U; Linux 2.2.15 i686)" -b ~/.data/cookies1.txt -c ~/.data/cookies1.txt -s -S -L  -d 'pw='$pass'' -d 'email='$email'' https://zattoo.com/login > ~/.data/zatto.html

ticket=` cat ~/.data/zatto.html | grep -r ticket_id | cut -d" " -f3 | sed 's/^\"\(.*\)\";$/\1/g'`

uid=`cat ~/.data/cookies1.txt | awk -F\  '/.*uid.*/ { print $7 }'`

codef=`cat ~/.data/zatto.html | awk -F\  '/.*Math.round.*/ { print $7 }' | awk -F\) '{print $1}'`

link=`curl -x 195.162.130.20:8080 'http://tserver.zattoo.com/join?ticket%5Fid='$ticket'&uuid='$uid'&channel='$canale'&f='$codef'' | grep "rtmpe" | cut -d" " -f2 | sed 's/^\"\(.*\)\",$/\1/g'`

zatto=$HOME/.data/zatto.txt

swf=`curl -x 195.162.130.20:8080 -b ~/.data/cookies1.txt --url http://zattoo.com/view#$1 | grep "zattoo.setStaticAssets" | awk -F '"' '{print $2}'`

echo "$link"

rtmpdump -v -r "$link" -W http://zattoo.com"$swf" | vlc -

}

# Funzione per vedere la versione testuale di televideo in un terminale
televideo(){
~/.data/./televideo.sh ;

}

# Funzione per riprodurre l'ultimo TG regionale di RAI 3 della regione passata come argomento alla funzione
riproduci_regione(){
wget -O /dev/stdout http://www.tgr.rai.it/SITOTG/TGR_popupvideo/1,8506,tgr%5E$1,00.html -o /dev/null | grep 'videoURL =' | cut -d" " -f4 | sed 's/\"\(.*\)\";/\1/g'> regione.txt
read regione < regione.txt
rm regione.txt
vlc $regione
}

########## FINE DEFINIZIONE FUNZIONI ##########
########## INIZIO DELLO SCRIPT VERO E PROPRIO ##########
if [ ! -f ~/.data/email ]; then
zenity --entry --text="Inserisci username:" > ~/.data/email
zenity --entry --text="Inserisci la password:" --hide-text > ~/.data/pass
fi

titolo()
{
epg=/tmp/epg.html

cat $epg| grep -r synopsis | sed -e 's/<p class="synopsis">//' | awk -F\</ '{print $1}' | zenity --text-info --title="`cat $epg | grep -r "<title>" | awk -F\> '{print $2}' | awk -F\| '{print $1}'`"
}
zatto()
{

email=`cat ~/.data/email`

pass=`cat ~/.data/pass`

echo "$email"

echo "$pass"

curl --cacert ~/.data/ca-bundle.crt --user-agent "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.7) Gecko/20100713 (CK-IBM) Firefox/3.0.17;MEGAUPLOAD 1.0 ( .NET CLR 3.5.30729)" -x 195.162.130.20:8080 --user-agent "Mozilla/4.73 [en] (X11; U; Linux 2.2.15 i686)" -b ~/.data/cookies1.txt -c ~/.data/cookies1.txt -s -S -L  -d 'pw='$pass'' -d 'email='$email'' https://zattoo.com/login > ~/.data/zatto.html

ticket=` cat ~/.data/zatto.html | grep -r ticket_id | cut -d" " -f3 | sed 's/^\"\(.*\)\";$/\1/g'`

uid=`cat ~/.data/cookies1.txt | awk -F\  '/.*uid.*/ { print $7 }'`

codef=`cat ~/.data/zatto.html | awk -F\  '/.*Math.round.*/ { print $7 }' | awk -F\) '{print $1}'`

echo "$ticket"

echo "$uid"

echo "$codef"

link=`curl --user-agent "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.7) Gecko/20100713 (CK-IBM) Firefox/3.0.17;MEGAUPLOAD 1.0 ( .NET CLR 3.5.30729)" -x 195.162.130.20:8080 'http://tserver.zattoo.com/join?ticket%5Fid='$ticket'&uuid='$uid'&channel='$1'&f='$codef'' | grep "rtmpe" | cut -d" " -f2 | sed 's/^\"\(.*\)\",$/\1/g'`

swf=`curl -x 195.162.130.20:8080 -b ~/.data/cookies1.txt --url http://zattoo.com/view#$1 | grep "zattoo.setStaticAssets" | awk -F '"' '{print $2}'`

echo "$link"

rtmpdump -v -r "$link" -W http://zattoo.com"$swf" -o /dev/null -q

}

scelta_operazione # sceglie l'operazione da eseguire (vedere tv, ascoltare radio, vedere tg regionale, guardare televideo)
case "$operazione" in
    "STREAM TV NAZIONALI") seleziona_canale ;;
    "STREAM TV LOCALI") seleziona_canale ;;
    "STREAM TV MUSICALI") seleziona_canale ;;
    "STREAM TV ZATTO") seleziona_zatto ;;
    "STREAM TV ESTERI") seleziona_canale ;;
    "STREAM RADIO") seleziona_stazione ;;
    "TG REGIONE") TG_regione ;;
    "TELEVIDEO") televideo ;;
esac
if [ "$?" = "0" ]; then
    break
fi

if [ "$operazione" = "STREAM RADIO" ]; then    #  Se l'operazione scelta è l'ascolto della radio
    scelta_stazione                #+ usa la funzione per selezionare la stazione da riprodurre
    case $stazione in
        "Radio Uno") vlc rtsp://live.media.rai.it/broadcast/radiouno.rm ;;
        "Radio Due") vlc rtsp://live.media.rai.it/broadcast/radiodue.rm ;;
        "Radio Tre") vlc rtsp://live.media.rai.it/broadcast/radiotre.rm ;;
        "Isoradio") vlc rtsp://live.media.rai.it/broadcast/isoradio.rm ;;
        "RDS") vlc mms://fastreal.fastweb.it/RDS ;;
        "Radio 105") rtmpdump -v -r "rtmp://fms.105.net:1935/live" -y "105Radio" | vlc - ;;
            "RTL 102.5") vlc mms://151.1.245.36/rtl102.5hq/  ;;
        "Radio Capital") vlc mms://wm.streaming.kataweb.it/reflector:23305 ;;
        "Radio Deejay") vlc mms://wm.streaming.kataweb.it/reflector:51783?deejay ;;
                "Radio24") vlc mms://tilive1.alice.cdn.interbusiness.it/radio24sole1 ;;
        "Controradio") vlc http://streaming.controradio.emmi.it:8190/ ;;
        "Radio Popolare") vlc http://www.radiopopolare.it/liveU.asx ;;
        "Radio Onda Rossa") vlc http://radio.dyne.org:8000/ondarossa.mp3 ;;
        "Radio onda d'Urto") vlc http://radio.dyne.org:8000/ondadurto.ogg.m3u ;;
        "Radio Italia") vlc mms://89.202.214.2/66360a73-2b6d-483e-ae7e-29eee545d37c ;;
        "Radio Monte Carlo") rtmpdump -v -r "rtmp://fms.105.net:1935/live" -y "RMC" | vlc - ;;
        "Radio Blackout") vlc http://stream.teknusi.org:8000/blackout.mp3 ;;
        "Radio Sherwood") vlc http://62.101.68.185:8000/sherwood.ogg ;;
        "Virgin radio") vlc http://shoutcast.unitedradio.it:1301 ;;
        "Virgin rock classico") vlc http://shoutcast.unitedradio.it:1307  ;;
        "Virgin rock extreme") vlc http://shoutcast.unitedradio.it:1309  ;;
        "Virgin rock alternative") vlc http://shoutcast.unitedradio.it:1513  ;;
        "Radio Fantastica") vlc mms://live3.streamingmedia.it/radiofantastica ;;
        "Radio KissKiss") vlc mms://151.1.245.1/34 ;;
        "RIN") vlc http://www.radioitalianetwork.fm/listen.pls ;;
        "Radio Bruno") vlc http://www.streamsolution.it/onair/radiobruno.asx ;;
        esac
elif [ "$operazione" = "STREAM TV NAZIONALI" ]; then    #  Se invece si sceglie di vedere la televisione
    scelta_nazionale                #+ usa la funzione per selezionare il canale da riprodurre
    case $nazionale in
        "Rai Uno") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/rai-uno/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Rai1 ;;
        "Rai Due") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/rai-due/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Rai2 ;;
        "Rai Tre") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/rai-tre/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Rai3 ;;
        "Rai Quattro") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=75708" | vlc - ;;
        "Rsi La 1") zatto TSI1 ;;
        "Rsi La 2") zatto TSI2 ;;
        "RaiMed") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=87127" | vlc - ;;
        "RaiSport1") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=4145" | vlc - ;;
         "RaiSport2") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=179975" | vlc - ;;
         "Rai5") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=72382" | vlc - ;;
         "RaiPremium") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=72383" | vlc - ;;
        "RaiGulp") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=4119" | vlc - ;;
         "RaiStoria") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=24269" | vlc - ;;
                "Cielo") rtmpdump -v -r rtmp://cp86825.live.edgefcs.net/live/cielo_std@17630 -q | vlc - ;;
         "RayYoYo") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=72384" | vlc - ;;
         "RaiCinema") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=72381" | vlc - ;;
         "RaiNews") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=1" | vlc - ;;
                "Canale5")wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/canale-5/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Canale5 ;;
                "Rete 4") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/rete-4/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Rete4 ;;
                "Italia 1") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/italia-1/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto Italia1 ;;
                "La 7") wget -O /tmp/epg.html http://it.tv.yahoo.com/programmi/la7/`date +%Y-%m-%d`/`date +%R |sed -e 's/:/-/'`/ && titolo & zatto CH%5Fla7 ;;
         "RaiScuola") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=24268" | vlc - ;;
         "RaiInternational") vlc http://212.239.120.252:1755/yesItaliaStream ;;
                "Sky Tg 24") rtmpdump -v -r "rtmp://cp49989.live.edgefcs.net:1935/live?videoId=53404915001&lineUpId=&pubId=1445083406&playerId=760707277001&affiliateId=" -y "streamRM1@2564" | vlc -
;;
         "Euronews") curl -H "viaurl: www.rai.tv" "http://mediapolis.rai.it/relinker/relinkerServlet.htm?cont=VssSlashLL5s5Ktm0eeqqEEqual" | vlc - ;;
         "SportItalia24") rtmpdump -v -r "rtmp://fml.390B.edgecastcdn.net/20390B/live/livesportitalia" | vlc - ;;
        "Inter tv") rtmpdump -v -r "rtmp://flash3.ipercast.net/intertv.it/live" -q | vlc - ;;
        "ComingSoon TV") rtmpdump -v -r "rtmp://109.123.96.196:1935/ws-anica/comingsoonlive" -q | vlc - ;;
        "SuperTennis.tv") rtmpdump -v -r "rtmp://109.123.96.197/ws-lexicon/" -y "ws-lexicon/supertennistvbackup" -q | vlc - ;;
        esac
elif [ "$operazione" = "STREAM TV LOCALI" ]; then    #  Se invece si sceglie di vedere la televisione
    scelta_locale                #+ usa la funzione per selezionare il canale da riprodurre
    case $locale in
        "Canale 7") vlc http://canale7.superstreaming.it/ ;;
        "Canale 10") vlc mms://194.244.25.78:6869 ;;
        "Canale 9") rtmpdump -v  -r "rtmp://flash.streamingmedia.it/canale9/livestream" -q | vlc - ;;
        "GRP") rtmpdump -v -r "rtmp://69-31-5-41.dv.livestream.com/mogulus-stream-edge/grptelevisione/rtmp://69-31-5-70.dv.livestream.com/affiliateStream/grptelevisione/6c69766572657065617465723a72746d703a2f2f36392d33312d352d37302e64762e6c69766573747265616d2e636f6d2f6d6f67756c75732f67727074656c65766973696f6e652f73747265616d475250" -q | vlc - ;;
        "QVC") rtmpdump -v -r "rtmp://cp107861.live.edgefcs.net/live/QVC_Italy_Stream1200@34577" -q | vlc - ;;
        "Altaitalia TV") vlc http://89.188.128.211/altaitalia ;;
        "7 Gold") vlc mms://94.87.50.30:9005 ;;
        "Videolina") rtmpdump -v  -r "rtmp://91.121.222.160/videolinalive/videolinalive.sdp" -q | vlc - ;;
        "Umbria TV") rtmpdump -v  -r "rtmp://fl1.mediastreaming.it/umbriatv/livestream" -q | vlc - ;;
        "Antenna Sicilia") rtmpdump -v  -r "rtmp://live.lasiciliaweb.it:1935/live/antenna_sicilia" -q | vlc - ;;
        "Quararete TV") rtmpdump -v  -r "rtmp://wowza1.top-ix.org/quartaretetv/" -y "quartareteweb" -q | vlc - ;;
        esac
elif [ "$operazione" = "STREAM TV MUSICALI" ]; then    #  Se invece si sceglie di vedere la televisione
    scelta_musicale                #+ usa la funzione per selezionare il canale da riprodurre
    case $musicale in
         "105 TV") rtmpdump -v -r "rtmp://fms.105.net:1935/live" -y "105Test1" | vlc - ;;
         "Virgin TV") rtmpdump -v -r "rtmp://fms.105.net:1935/live" -y "virgin1" | vlc - ;;
         "DeeJay TV") vlc http://wm.streaming.kataweb.it/reflector:40004 ;;
         "RTL102.5 TV") vlc mms://151.1.245.36/rtl102.5vs ;;
         "RMC TV") rtmpdump -v -r "rtmp://fms.105.net:1935/live" -y "rmc1" | vlc - ;;
         "Rock One TV") vlc http://mediatv2.topix.it/24RockOne66 ;;
         "The Vault Music") vlc mms://verytangy-699-1055655.wm.llnwd.net/verytangy_699-1055655 ;;
        esac
elif [ "$operazione" = "STREAM TV ESTERI" ]; then    #  Se invece si sceglie di vedere la televisione
    scelta_estera                #+ usa la funzione per selezionare il canale da riprodurre
    case $estera in
        "Al Jazeera Eng") zatto ITL%5Faljazeera ;;
        "France 24 Eng") rtmpdump -v -r rtmp://stream2.france24.yacast.net/france24_live/en -a france24_live/en -W http://www.france24.com/en/sites/all/modules/maison/aef_player/flash/player.swf -p http://www.france24.com/en/aef_player_popup/france24_player -y f24_liveen | vlc - ;;
        "BBC News 24") vlc mms://verytangy-673-404284.wm.llnwd.net/verytangy_673-404284?e=1298596415&h=5289c5089ac9ce222b74349884966dc9&startTime=1298596405&userId=13194&portalId=5&portal=5&channelId=2627&ppvId=19848&mark=7817&source=box&epgType=live ;;
        "RT Eng") rtmpdump -v -r rtmp://fms5.visionip.tv/live -a live -W http://rt.com/s/swf/player5.4.viral.swf -p http://rt.com/on-air/ -y RT_3 | vlc - ;;
        "SkyNews") vlc mms://live1.wm.skynews.servecast.net/skynews_wmlz_live300k ;;
        "ESPN") rtmpdump -v -r "rtmp://95.211.73.3/live/" -y "22.sdp" -q | vlc - ;;
        "BBC 1") vlc mms://verytangy-653-400102.wm.llnwd.net/verytangy_653-400102?e=1297124432&h=f3dadefd07f4765b93e74298c277d29b&startTime=1297124422&userId=13194&portalId=5&portal=5&channelId=2627&ppvId=19838&mark=4024&source=box&epgType=live ;;
        "BBC 2") vlc mms://verytangy-654-400103.wm.llnwd.net/verytangy_654-400103?e=1297124569&h=55bed855bacf48ce2a90e08a520ae00c&startTime=1297124559&userId=13194&portalId=5&portal=5&channelId=2627&ppvId=19839&mark=8585&source=box&epgType=live ;;
        "rte1") rtmpdump -v -r "rtmpte://fmsod.rte.ie/live/rte1" -W "http://www.rte.ie/player/assets/player_403.swf" | vlc - ;;
        "rte2")  rtmpdump -v -r "rtmpte://fmsod.rte.ie/live/rte2" -W "http://www.rte.ie/player/assets/player_403.swf" | vlc - ;;
        "mtv")  zatto CH_mtv ;;
        "tsr1")  zatto TSR1 ;;
        "tsr2")  zatto TSR2 ;;
        "sf1")  zatto SF1 ;;
        "sf2")  zatto CH%5FHiQ%5Fsf2 ;;
        "sfinfo")  zatto SFi ;;
        "CNNint")  zatto CNN%5FIntl ;;
        "tele5")  zatto DE%5Ftele5 ;;
        "viva")  zatto Viva ;;

        esac

elif [ "$operazione" = "STREAM TV ZATTO" ]; then    #  Se l'operazione scelta e vedere i canali zatto
    scelta_zatto

elif [ "$operazione" = "TG REGIONE" ]; then    #  Se invece è stato scelto il tg regionale
    seleziona_regione            #+ avvia la funzione per selezionare la regione
    case "$regione" in
        "Abruzzo") riproduci_regione abruzzo ;;
        "Basilicata") riproduci_regione basilicata ;;
        "Calabria") riproduci_regione calabria ;;
        "Campania") riproduci_regione campania ;;
        "Emilia-Romagna") riproduci_regione emiliaromagna ;;
        "Friuli-Venezia Giulia") riproduci_regione friuli ;;
        "Lazio") riproduci_regione lazio ;;
        "Liguria") riproduci_regione liguria ;;
        "Lombardia") riproduci_regione lombardia ;;
        "Marche") riproduci_regione marche ;;
        "Molise") riproduci_regione molise ;;
        "Piemonte") riproduci_regione piemonte ;;
        "Puglia") riproduci_regione puglia ;;
        "Sardegna") riproduci_regione sardegna ;;
        "Sicilia") riproduci_regione sicilia ;;
        "Toscana") riproduci_regione toscana ;;
        "Trentino-Alto Adige") riproduci_regione trentino ;;
        "Umbria") riproduci_regione umbria ;;
        "Valle d'Aosta") riproduci_regione valdaosta ;;
        "Veneto") riproduci_regione veneto ;;
    esac

fi
done
