#!/bin/sh
# This script was generated using Makeself 2.1.5

CRCsum="3357571103"
MD5="84e83d8afeed2452d33ea6c7163cc175"
TMPROOT=${TMPDIR:=/tmp}

label="Unofficial Qt for Symbian 4.6.3 All-In-One (GNUPOC 1.15 + Qt 4.6.3 + Qt Mobility 1.0.2 + Nokia Smart Installer 1.0) Linux Installer"
script="./install.sh"
scriptargs=""
targetdir="qt_all_in_one_linux_installer"
filesizes="9259"
keep=n

print_cmd_arg=""
if type printf > /dev/null; then
    print_cmd="printf"
elif test -x /usr/ucb/echo; then
    print_cmd="/usr/ucb/echo"
else
    print_cmd="echo"
fi

unset CDPATH

MS_Printf()
{
    $print_cmd $print_cmd_arg "$1"
}

MS_Progress()
{
    while read a; do
	MS_Printf .
    done
}

MS_diskspace()
{
	(
	if test -d /usr/xpg4/bin; then
		PATH=/usr/xpg4/bin:$PATH
	fi
	df -kP "$1" | tail -1 | awk '{print $4}'
	)
}

MS_dd()
{
    blocks=`expr $3 / 1024`
    bytes=`expr $3 % 1024`
    dd if="$1" ibs=$2 skip=1 obs=1024 conv=sync 2> /dev/null | \
    { test $blocks -gt 0 && dd ibs=1024 obs=1024 count=$blocks ; \
      test $bytes  -gt 0 && dd ibs=1 obs=1024 count=$bytes ; } 2> /dev/null
}

MS_Help()
{
    cat << EOH >&2
Makeself version 2.1.5
 1) Getting help or info about $0 :
  $0 --help   Print this message
  $0 --info   Print embedded info : title, default target directory, embedded script ...
  $0 --lsm    Print embedded lsm entry (or no LSM)
  $0 --list   Print the list of files in the archive
  $0 --check  Checks integrity of the archive
 
 2) Running $0 :
  $0 [options] [--] [additional arguments to embedded script]
  with following options (in that order)
  --confirm             Ask before running embedded script
  --noexec              Do not run embedded script
  --keep                Do not erase target directory after running
			the embedded script
  --nox11               Do not spawn an xterm
  --nochown             Do not give the extracted files to the current user
  --target NewDirectory Extract in NewDirectory
  --tar arg1 [arg2 ...] Access the contents of the archive through the tar command
  --                    Following arguments will be passed to the embedded script
EOH
}

MS_Check()
{
    OLD_PATH="$PATH"
    PATH=${GUESS_MD5_PATH:-"$OLD_PATH:/bin:/usr/bin:/sbin:/usr/local/ssl/bin:/usr/local/bin:/opt/openssl/bin"}
	MD5_ARG=""
    MD5_PATH=`exec <&- 2>&-; which md5sum || type md5sum`
    test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which md5 || type md5`
	test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which digest || type digest`
    PATH="$OLD_PATH"

    MS_Printf "Verifying archive integrity..."
    offset=`head -n 402 "$1" | wc -c | tr -d " "`
    verb=$2
    i=1
    for s in $filesizes
    do
		crc=`echo $CRCsum | cut -d" " -f$i`
		if test -x "$MD5_PATH"; then
			if test `basename $MD5_PATH` = digest; then
				MD5_ARG="-a md5"
			fi
			md5=`echo $MD5 | cut -d" " -f$i`
			if test $md5 = "00000000000000000000000000000000"; then
				test x$verb = xy && echo " $1 does not contain an embedded MD5 checksum." >&2
			else
				md5sum=`MS_dd "$1" $offset $s | eval "$MD5_PATH $MD5_ARG" | cut -b-32`;
				if test "$md5sum" != "$md5"; then
					echo "Error in MD5 checksums: $md5sum is different from $md5" >&2
					exit 2
				else
					test x$verb = xy && MS_Printf " MD5 checksums are OK." >&2
				fi
				crc="0000000000"; verb=n
			fi
		fi
		if test $crc = "0000000000"; then
			test x$verb = xy && echo " $1 does not contain a CRC checksum." >&2
		else
			sum1=`MS_dd "$1" $offset $s | CMD_ENV=xpg4 cksum | awk '{print $1}'`
			if test "$sum1" = "$crc"; then
				test x$verb = xy && MS_Printf " CRC checksums are OK." >&2
			else
				echo "Error in checksums: $sum1 is different from $crc"
				exit 2;
			fi
		fi
		i=`expr $i + 1`
		offset=`expr $offset + $s`
    done
    echo " All good."
}

UnTAR()
{
    tar $1vf - 2>&1 || { echo Extraction failed. > /dev/tty; kill -15 $$; }
}

finish=true
xterm_loop=
nox11=y
copy=none
ownership=y
verbose=n

initargs="$@"

while true
do
    case "$1" in
    -h | --help)
	MS_Help
	exit 0
	;;
    --info)
	echo Identification: "$label"
	echo Target directory: "$targetdir"
	echo Uncompressed size: 52 KB
	echo Compression: gzip
	echo Date of packaging: Wed Aug 18 19:47:11 AMT 2010
	echo Built with Makeself version 2.1.5 on 
	echo Build command was: "/usr/bin/makeself \\
    \"--nox11\" \\
    \"qt_all_in_one_linux_installer\" \\
    \"qt_for_symbian_4.6.3_all_in_one_linux_installer_v3.sh\" \\
    \"Unofficial Qt for Symbian 4.6.3 All-In-One (GNUPOC 1.15 + Qt 4.6.3 + Qt Mobility 1.0.2 + Nokia Smart Installer 1.0) Linux Installer\" \\
    \"./install.sh\""
	if test x$script != x; then
	    echo Script run after extraction:
	    echo "    " $script $scriptargs
	fi
	if test x"" = xcopy; then
		echo "Archive will copy itself to a temporary location"
	fi
	if test x"n" = xy; then
	    echo "directory $targetdir is permanent"
	else
	    echo "$targetdir will be removed after extraction"
	fi
	exit 0
	;;
    --dumpconf)
	echo LABEL=\"$label\"
	echo SCRIPT=\"$script\"
	echo SCRIPTARGS=\"$scriptargs\"
	echo archdirname=\"qt_all_in_one_linux_installer\"
	echo KEEP=n
	echo COMPRESS=gzip
	echo filesizes=\"$filesizes\"
	echo CRCsum=\"$CRCsum\"
	echo MD5sum=\"$MD5\"
	echo OLDUSIZE=52
	echo OLDSKIP=403
	exit 0
	;;
    --lsm)
cat << EOLSM
No LSM.
EOLSM
	exit 0
	;;
    --list)
	echo Target directory: $targetdir
	offset=`head -n 402 "$0" | wc -c | tr -d " "`
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | UnTAR t
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
	--tar)
	offset=`head -n 402 "$0" | wc -c | tr -d " "`
	arg1="$2"
	shift 2
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | tar "$arg1" - $*
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
    --check)
	MS_Check "$0" y
	exit 0
	;;
    --confirm)
	verbose=y
	shift
	;;
	--noexec)
	script=""
	shift
	;;
    --keep)
	keep=y
	shift
	;;
    --target)
	keep=y
	targetdir=${2:-.}
	shift 2
	;;
    --nox11)
	nox11=y
	shift
	;;
    --nochown)
	ownership=n
	shift
	;;
    --xwin)
	finish="echo Press Return to close this window...; read junk"
	xterm_loop=1
	shift
	;;
    --phase2)
	copy=phase2
	shift
	;;
    --)
	shift
	break ;;
    -*)
	echo Unrecognized flag : "$1" >&2
	MS_Help
	exit 1
	;;
    *)
	break ;;
    esac
done

case "$copy" in
copy)
    tmpdir=$TMPROOT/makeself.$RANDOM.`date +"%y%m%d%H%M%S"`.$$
    mkdir "$tmpdir" || {
	echo "Could not create temporary directory $tmpdir" >&2
	exit 1
    }
    SCRIPT_COPY="$tmpdir/makeself"
    echo "Copying to a temporary location..." >&2
    cp "$0" "$SCRIPT_COPY"
    chmod +x "$SCRIPT_COPY"
    cd "$TMPROOT"
    exec "$SCRIPT_COPY" --phase2 -- $initargs
    ;;
phase2)
    finish="$finish ; rm -rf `dirname $0`"
    ;;
esac

if test "$nox11" = "n"; then
    if tty -s; then                 # Do we have a terminal?
	:
    else
        if test x"$DISPLAY" != x -a x"$xterm_loop" = x; then  # No, but do we have X?
            if xset q > /dev/null 2>&1; then # Check for valid DISPLAY variable
                GUESS_XTERMS="xterm rxvt dtterm eterm Eterm kvt konsole aterm"
                for a in $GUESS_XTERMS; do
                    if type $a >/dev/null 2>&1; then
                        XTERM=$a
                        break
                    fi
                done
                chmod a+x $0 || echo Please add execution rights on $0
                if test `echo "$0" | cut -c1` = "/"; then # Spawn a terminal!
                    exec $XTERM -title "$label" -e "$0" --xwin "$initargs"
                else
                    exec $XTERM -title "$label" -e "./$0" --xwin "$initargs"
                fi
            fi
        fi
    fi
fi

if test "$targetdir" = "."; then
    tmpdir="."
else
    if test "$keep" = y; then
	echo "Creating directory $targetdir" >&2
	tmpdir="$targetdir"
	dashp="-p"
    else
	tmpdir="$TMPROOT/selfgz$$$RANDOM"
	dashp=""
    fi
    mkdir $dashp $tmpdir || {
	echo 'Cannot create target directory' $tmpdir >&2
	echo 'You should try option --target OtherDirectory' >&2
	eval $finish
	exit 1
    }
fi

location="`pwd`"
if test x$SETUP_NOCHECK != x1; then
    MS_Check "$0"
fi
offset=`head -n 402 "$0" | wc -c | tr -d " "`

if test x"$verbose" = xy; then
	MS_Printf "About to extract 52 KB in $tmpdir ... Proceed ? [Y/n] "
	read yn
	if test x"$yn" = xn; then
		eval $finish; exit 1
	fi
fi

MS_Printf "Uncompressing $label"
res=3
if test "$keep" = n; then
    trap 'echo Signal caught, cleaning up >&2; cd $TMPROOT; /bin/rm -rf $tmpdir; eval $finish; exit 15' 1 2 3 15
fi

leftspace=`MS_diskspace $tmpdir`
if test $leftspace -lt 52; then
    echo
    echo "Not enough space left in "`dirname $tmpdir`" ($leftspace KB) to decompress $0 (52 KB)" >&2
    if test "$keep" = n; then
        echo "Consider setting TMPDIR to a directory with more free space."
   fi
    eval $finish; exit 1
fi

for s in $filesizes
do
    if MS_dd "$0" $offset $s | eval "gzip -cd" | ( cd "$tmpdir"; UnTAR x ) | MS_Progress; then
		if test x"$ownership" = xy; then
			(PATH=/usr/xpg4/bin:$PATH; cd "$tmpdir"; chown -R `id -u` .;  chgrp -R `id -g` .)
		fi
    else
		echo
		echo "Unable to decompress $0" >&2
		eval $finish; exit 1
    fi
    offset=`expr $offset + $s`
done
echo

cd "$tmpdir"
res=0
if test x"$script" != x; then
    if test x"$verbose" = xy; then
		MS_Printf "OK to execute: $script $scriptargs $* ? [Y/n] "
		read yn
		if test x"$yn" = x -o x"$yn" = xy -o x"$yn" = xY; then
			eval $script $scriptargs $*; res=$?;
		fi
    else
		eval $script $scriptargs $*; res=$?
    fi
    if test $res -ne 0; then
		test x"$verbose" = xy && echo "The program '$script' returned an error code ($res)" >&2
    fi
fi
if test "$keep" = n; then
    cd $TMPROOT
    /bin/rm -rf $tmpdir
fi
eval $finish; exit $res
‹ ÿplLì<mwÚÆÒùZıŠ-¡5ÄHBâÍØqNˆMRNlC 7ÍSEHèZHŠ$ü’Ä÷·ß™]	$,;¶ã¦§ç‰’ ZÍÎÎÎÌÎÛ®"Éşö«W£VÃo¥Q+'¿ãë‘¢T+•²ZƒÊJY­–‘Ú£ïp-‚P÷	y4ö{Ü×ÿK/I¶à€mKÁì’d¿”¿Ú€vEUkÕG¤üCşûõøgyl9òXfB@C"R".Áš?Iş1JTò×	gÔ\Ô˜¹$wèSºMòeòÔtÏÛÕMÑ´ügäéÇPêev“#Ï~Uy§s+$Š0±a¿ûöè ÛÚ×ö;ıİ¼"¼jƒz™ß©làŸ	uNÉ2õ©GÄä}»×İëw»Ãİ+d´}ßõ·I@¬€8nH`"9ÔO(	>%¯œEÏ5ğa¤ëÔ$ºcÂZºm}¢¦”I«´Æk/BÚÓÃY¡(|NŒWrI"eòåñi¸ğè}Í$:%§ŸÃ.0+–ä®›±îOsê„™ƒ“™~J‰a! 	2'ÄqìÍ¨qb9SâPƒî_‰eÓ@’¤œ`è!9Ü¯0½‚a’Íä×_ÉÜ¬‹9¢ L…çÚ)õwI©	Cö»*Õ¥Jt£ÖtÖyµ\/³¶¹;¶l+¼ˆz•%u½5î¢À?P
\¡âù§Iš™-zºqÚ(æW´HĞCš~B×µƒİëáäÀ<	 ÿÜÓ@awó½·û2Ş|…<ë+7>Á_rND7A­ú~1[º#ºuwá0ŸºDÏ© <&ƒ‹¹m9'D2W–lkÌNB— T`¹¨¤£Ïi À‡RîÇäÕŞ^›À\¦4,
ĞQIøŠ*ûÔ¦z@eİŸŸÖdx(L\ŸPĞj£hØ!¦Ë4 LğA<y”ï‘üY>B.?‘òtÙ/¾ Qoò“„¾ç>çWÒ½A¯¤®Æ—½›ËÇ‹s5F¾ æ†ât't-¦!®fŒ~FÓ”·AD<ÀeŒÇÆtˆL`®ÉQŠĞ#	«aí§	BØÈ Ãì¿æ¢ŠõaNAL®ceôEVZnM1I¬$eÏu€3!Ar¸ÖÌ]ÓšX\C`­3®IÇu¢ëa‰¸ÀÿÌ
(2é‚œYĞL#àÓ=Ï¾ô³²!¿mâ"ö|Ë	I^½Ü  
°à(ìâ\bøÉÇ9Smbƒ‘à-£%û‚ÇÀåkØ4Å‹`¾€!6ÉFPz?–K¥ÄıÇ0j8›ÁŒÀlê&™,Õ.¤`Ò¸¼W¬Qı¾ˆ‡¦¨œo‚Ë.z
Í$ yš1·¡×§òh™&ÚNˆidS x"g>p–úÌ€>{–"ÅzşéSÒî¾"Œî×ğ-/Dã½;ú jÁTw”/>€×†Ÿ+ˆ5tMr£üóœ€:Ã;¬ks~85Ô9øj,B}lSae(Ö¨çB¤şÕ©E`n,ú6Ùx¿œæFª»á:k*¡ÄZ\jÁIOX³1õ'N’XÜ0ß—ğ\wÀ“
:EÑšƒbŠw2%[‹³ÛïbVÀƒT†›ÔàZÇ¡ßºş‰î»ÇÜ†ÅÄ]„Ş"dK•™tdşÜšÀLOÉ1p*°!â³‚+B´`)F #ÉpçsP@våà—üç7‡­×míeç ­‘¸ü%_cXri]¥¸‰İÈ¥_‹Å_62D5?	<jò¤aQ G~KF‹`Ú‚Ò, Bòü	N­Oç.Ä¹3Ë /­`aÅÄwçDbKC2t0>ÂMk2M6½íÑÈ:Ã§£ÑxaÙ&v«×Úßï½Ò¢«´‘
ˆ6JÓ•ñá˜FèfK¥ø…óŸn\OÌ*fƒI'úÂy 5†ğ	äÌ½4È’ú‘Zøçø“L>FîpHÀB2o„=VyÆZ	a0‹€zÇÖ|ö:D¯¨C}Dâ€àN.&R`ó-—0JdaÁ‡o@¤&ÉŒÉÂEºæfbx£Hú$ã²U¢˜Ø„œO–GÜK'ƒ¹¦'ÂqÁ‰ëÑÖ°¶Ö`YjÎIíTÑÊëk¦©E™O!êÊ´âà cÁÒ2%ò‚6-:0u87´p~tî%4ø, Ârá¹¬…ÀJ€€šnCØ|î¹0¥^køÛîšD¶Gyl†IböÄë ×ŞCå|Ìm,KAĞS$€NußB»‹	‹ †HY’+&R¨Ou°[Œú	­9j«CÏb1Ÿ0iÉ_Âa¦LÑÀÚ…¾k.Æää=`ÚÀsœ…¡·-Ã6$è`Û!„|hŠdˆäcC!YáL„€7‰Tš…s[`çÑë_XÿÉ^âß±şSQ5QÿS••j½VÿQÿùŞõŸdL:ÚT!H¹C!(³üğxqã85âèÅOd•&æÈ_}–ñ™éÂÚàï Ù^Àš’Â¼ƒNuÛ2s_+CÁ„câ€&4ÿ0j„.\èái‚ÖtgŞµ‡k4§‹)¹ˆFS¹3A¯Êè¯sØ}Ñ9èßi¿·ûƒN÷(*$Ÿ0:^Ğ™¥‰T)$kîæ×Ñ¢#¢`´İ÷ÛÆ»,Ü âÇú&pøİÛàÃ2ÔŒ+O °ğƒS—yd7®Ç»ã ƒô|÷?À–…,eõr'¾„•``”x`æ. ôÓD™\ ’ğÈdŸZ‘AxKçcˆô€İ4!³ œÒ¬‰a[şêls‚0löøÄç'!³àD!±ŒõÅ?¢ëD*æz¬•ñÎC_7˜º±œó0)¿.	üÄƒr„‰;†ä±áIER™şd DQÊIÉR‘W,DÀ´Œ¿–Kïìà0êƒ£^?LM*?Ğ0€éúaŠßnV"T4ĞL¥O˜¾®)D&ä2G‹g†9™„úfcÌŸ¡š)È,ÅÃLfâ'µÃÁıA—«¬”=\©Z])3ÊoÂ'qiö	4?QÆ%Bù%Î‘É‹ïãü9Fp)Ëxÿ#ûgâ¿¨Øÿ7ïÿÖ«Õk÷«jcµÿWi@ü§¨õGü÷=.`tM¯7+ÆÄTÕšRmR³V1Êµ­f¥9©5Ë„¬íà.O¼½¢kUZ£æ¤Lu¨Ju½Z›TªºÑ4Ôªb’½;Âv‡ØŞÈ¸\¦j­Q©oÕõ†n4*“:n~L&U½Nk•*ÃpS4Ãb ›TšãÊx«FU£Q®Õ€f¹^6+ãIYÑ·:!·¯8ÿÖÿÕ’ø÷]ÿÕ†¢Ôqı—ëV>ÿ¨ÔÕÊõÿ=®cÒómXe•|Ïv¿ıDQü’ë[ÓÌA~R!ËuQ©Uİ®5¶k5©QoV·”¦Ò b¹Z.›››×¹Şk[Q¥rs«º…%êÿü9çjI)“MüŞ"ÏŸä1„X"Ü9%‹'qU.Èü‚$6]È.‰¶e
¯ÈkÅdP?éy ì·5Á‚:İÄøi„ &ü—âû‚ôäÏ÷£Ñ_Å¼˜WF#ÑİYíX>&`ô°–Èà)V±¹ãr?á
BY$Ó$’Dˆ`8s!‡8s}v"€a<>êüÙµíà
FÀh”ßÀlDIO Ãì ÆÄÜ¢±Ù‘ ¤E†˜3‹úºo\›·†ğ_BÊ´½=ğ¨!>ƒî ”B‚¯¥Ôó…‡‹%’šåÉr…‡:ÀÎCpğ|*®cZXÚØFß¥xî‚Ìñ¸ÄÈµ&„ïÒKä%6fŒ›:ÓpVÈÇQºw2-Ég®zÍFI©‚ê5køºwI¨œçGJÈãÎkÃ	`¢1µN©S"#0Ş°p=Fï—Ô¼\ßÙÏV-ÛcL»+îI9ß”àf	wB/ÖŸ‹Ğ&yt0›¸Ö¸ùkaÙøPŒ{ó¾Şk9,—Û[õ°ñ\y^Àj•FŠ1¯0d@í	XS‡šñ„ofN ŸdR6£°ğ,fÖ=¶6h1‰évÌ[#%æÒ¥€…•·¢pÁu–€Ñ·„»±nòo1f†¨K$T·ªj]M{€{ »Ö!4Ë¥:Ù„Ï&[‘xÅ,¬Î-¯]2?+’„Øoh	˜]âÏ× ö~{ZûÎ`8 ´nÈ«‰\ÂÑ`İ½¤YËÿùf¨uÃÖÁö~ü•ÏF\ƒv¯Õo»ıË¹k° :ç¸s<ë
Îş=ğX&Ç³fÖ"Vt{ïRoıq‚™ø˜ˆ>—ĞVIQÁl–•’¢|!±³'¢ùòyÙ<„\¸—“ùé§»©˜¸œÂm{ÆJ%.	¿mÏXDa9éì;·L;n:è¼À&<è/âÆ>O*`¹™¹\¥Rj€ê(5øBÍá€ƒa¿Ó{yĞz5@Dä§Í]"ŠAÁƒ¸p¸OGïƒHø•¢ ²†xÓTcG,‹Â&kmĞúSD7Mm>÷4.«ˆ¸S'¢ø Vã¡i­ßH®@öÛ½ƒî»ÃöÑ •‘û×LêÙîşD©ò½‰02.Ü]®î€'q&/L:–?„kú–Ô·(E§XÅâdñËõM=Ô¿½ñæ7’|;YAYlİàæ}T†5O6KŒÊ¹ÂR,k#K#Œ¥@Zğí¤¤-MRšµ …!)—¨dÄ(·;¦ôwE+·=3smbæZSjåì¸å^ˆ¯`*e´qì3v<µ;rCº½´4Á88U	; Cw6Bí~¢ R¡¯ã¡‚JŸ¥„ÑQ´¤D¤³"šAd³­Ñ€“ÅìÌpMºpÍ¤¥óL<‰!ë6ñéÇ…“çGÔy¶™È^“½ØÀè4|°wºA¬¥DäŠ«™	tP-pÿ[w0”Ü ââ·üäZ®¸}]
Y£˜´Ó\a¶;É›4|Ô(EGÿ`˜Ïÿ~í2ŸoõzZ¿=è÷÷ÚüŒjş3K²3İ—ôL¨¾Ç·>P÷Á5;‰<[qU¸ë•F=­¸7õ»¾Ô¢¨ÜùÆ•–Ë¥Ûãê~Õ “åHàÏX1]Ø"Öˆª°‚XˆJşëòæuHRâÃ—° ÁÆ ìÁ—òÄ]\ÑTå¡¡{T£ç *ŒœQX¼™o< 2«îˆŒ‰BU˜(Tµ¤¤­;A™/`”ŒÕ¬b|4rô1:–ëùÖíèLaI¸¼ı4ù1‚Ìé¥
véQnòf+åèş…|²»ùdwòæµ’@¬†¡5–§¶;Öm9íìaÑw„±O¼¾m~›¾mŞEß6ãÒ	·/í?†ı–6lõ_µ!GÕZ*œÀÑ\U¾Ì"ì+{Ï ä)?Éëú –‘§D~>¸¸q´ì"ü–Rm*[ÍjÚ#Ü	Ñµ.¢^Ãâ|B‚Ïjñ–cØ·’§rÊá…Giöl½+‚¬YØ|lM '"o´î@{Û9ª¨\È¡Ñ‚å¨¹Ş~»ß'9õ9:>ÈA47€É&=•…m3XÇï¼	Z0Ô^´_u´£Öa{Ğkíµ1`eò–Úv‰DN"#`dÅ^ÆgVÀ(<ø»°esİ ¿Îlò–Êıã–ºUºj”­I_âje¡ºt'…\ü. x·]HZ•âz ÅŞÁƒÑ9Ôúû•Z)¬i‰yçjokB
VğÒõ£ÑBqÍø¦‡!cwmÛš[V<1_,<Ó}|#H/À54Œ®¥ nƒí
¦3^>/¬âøº6½Ë+,ş9ÑG3æ°pñuÌDã²x¿U‹¤UË’Vöx†&¬ =÷Â‹B1Sdwbü’k§ºıÊ^Ğ¢Ë|“˜ÔÖp•P,”–BúÊãTÕùÌ%Õm Š;Ù\a«•<U×µç²¿¼ÉH'JÎÜñ|[1h¶Én6ª[ÕÆVù+&ûø˜åÆÿŠ\@5i¹«M´ÜğyÕr‡'×ÌöG“Ól£‘ìõ;½!úZ’“Æz¸²Ö™Á,e¢Ábtøx&A‰SÁL÷±—ô!|ŞXäğ]7ò%8«Z×x]Vx<j2{kï»ıwË„”
.HgÙQü¹|€ß¹dÿWÄÃN÷HË@öÛ[’ƒË:•”ñL\E¯Ldkoœ`m Hàê£Úë²ıöK¾ı²Û×{ÀÙ³S¬ÛÔj’Ä¯ôní[$—êzÌûnŞ§ï‚÷%+º_ìk£—Zÿø =Ğ^´ÀºT›”»
<l½Òz­!Ìîp CøÿÑâ+ğ„oª–y‰·Yn®ÙåÈ†âs4­¬ºOF9ægŞì[şövè±÷¦ÔÓù’(X`Š¼X§5dà Î
îº|–7Ş7ƒÍµa®ââ²ñ:Û‰˜Û"æGóIrò*:ztwáÃí±O¬4ØJŒ/n•;İf5vºÂŠŠîkmĞD19Ém'qqv¾„>–¬¼“i˜C\5no£8 ò¥ üIŸ(ã!;¾æ#t{¸pEò‹¢ÅûÒ/ê
€“€±U”dÜ{à\ÊÂİ“òÕ+·ì·×î;/;{­!Ä†ËÖ×íw‰»^k0èıÖ‡%[ÌoÂ.éş´€¯J›Ãèÿ+øp8„Ş7:I»‘-í~÷‚…ã·{.Æ÷½<„ôï5şšÜ›’­4#%hf+A´wØî§µ€\Uƒ\õË÷:İâJÒËúÎì»	ñVÂK	íöA²†ÿH¤¼93\ŞRkÕæV¥¹u·pùZ¤×ÆÌj¹^˜MüVW'¸‡>ìşŞN³y—ëô©îrñÆıïí\1¡è«îk‡2»§a®A´v¢"›„IöÏ¨Ã$Pş±vöQ®wAd“È"ÏˆìnSñÀ
AëíkwÚÆò»ÅFqkˆA 	0v®Ó`À	=ÄPÀmÒÒã`¶jÉÓŞÜß~gfWbõÜØçö\ëäÄ¶vgvö1£Ùİy€>|§UzŠLÅòh'¾e4,¹aÙ[0¹)œh3KE…CÕêG§²¦êm{Ú®Êªş1³¦)Ğ¢‡¾SoÖ5%<‹¸Ø]ÎQ°¸b#7mÍO,“ØÍlƒ(˜lş5£7 J\êÒé´„0»Dğ+¹S¦<o)~—Œ›$êE¿/áÀ?ªÇoàç¯ÑóD–¬\*›p©¥o(÷gÌ áÒÙ¬?x9Şïÿù-éæ÷íqâª[oasÖ8©w©òNßÙáŠ9¬&~a¬3e¶kèùŒfDeáQÔí`rcÚêÀIYioç~±œË”’Sğ,”‡7NªÍÓídãµ\mˆ¾*?#ÒTì8Èm¦ãN„FÖÂîÍªtÌıZâ—C1'¤bkxÒêIÛC?Nw/HveX÷-‚Š‘MÉÔ¸‘FñÔˆ}Ù’¦İiòö^-áHSú“oĞ½H¶FQ6ÍÃ'—æ°Rê'häqVévÂ£PfÁ†Ü;”'ÎÂæA{Fä:ÓdòEÜ¯H8ùÓ»Ä8~ğ…ÕİÃ}Äkcp+è vfL|¾á~,Ìã¨Q  ùÂBlpƒD“~Ym½k7Pñ¤w®ê¹òˆK-Úª¸#J9y-gä/¬°ZTĞfåº,÷Sğ RVWÓzø•Å5" `6lşé—…Jàm»S=¯ÕÛò.ŒŸ
–öP³Ù-”µŒáš°İÎ¬‘r¤ŸR×ä«ZÛ5¹a¡}
×=Ai5ïæàš}ªè_g‡ò=ÎÛJ÷-S+ş·õwíŞ‡zõm‹)jôı‡ë÷c!#¾ùİ^†âè´Ñ¬EîE³2g¿&'Øçìğ›>ìL&×ì*Õ·uºšZA q…¥BÏ9Î¿ğ85¸‘.ôh¦|núâÌ!«İØæC›mÚ0;Á0Xâ»µÊ½p·1ØĞl,ã+ÙWü“’Rø)i¿ît¿öj&÷4Áx:ş1½±¹àá7Ñ“†ïÁ%-$Ùİ§IÿÃƒ
As«z/”?ó¨“bÔîƒâ ßšb(ˆ%A]²¦ZâQÙ7‰Çàâ¤ö¿3'6ñp<Øìƒ²vbË‹Ã1oÄèI˜îù¸l¦D‘µ€Uà,Üß+ûá0|æš<61j•Ç»ÇÔ5ÌF¨œa(Â1¤÷ÇR1!¿µU¬£É¨1¿»ÂæÁdë{úâùl6Á@85ÏÁ ~ç˜S\>²ÑZ]ÜX9Ûùtç>Ù¥<ıŠ^ärÂ·ªÁèƒ½=£P.Zà`o#\ÆAŞ8ĞuU/KåÂQ”ÎóŠùŒg»ü‡ï\ù$Yt«—ü"Ô»şlè¶3Â[çìòeåjjWgxô;uÈèiwY6€²¡\Æ|eTdGàk8æu£QpêX“(€Úbğ9®¬{eM)bÂthFlkx4^]P Tè
ÆÄ°Â"úƒ÷€Ö(¢àÆm?ğ~´Å•Ù@›%Ñ(>GÚÎ=Ú†œ¶á’6y<o¯`Ê®Ï/‚=<†ê
î}sğevã`pÙi4Íc´_öĞùË&„n,ĞùË¼!ğ¯éàÖ
¼½¸™/Aˆ¢#Ë¹Ì+SëZ¬Ï`çTa W <fÏøÎh„ÒLw>4ë
3vSR·HG:†¼ü>SëÒn;Ú.¾ ÊE]_×¡c5ÚÄ[‚2¿$^`K—„¹PŠ@|æ–­²
u V"Îâ0rn€®”¥Ó<»Şã^ áÛìfåC½ƒrÕ³î‡n¯şN4E®^yûô¨Ù¨Õß·[°J	*Ñô6ËÖzÖÂ‡îH’ó‡ç½´.¨k2ş»¸ËÖ~îÓÍ¯òQŒşh¾É¹‹‰uÕÕ|z­ËâèvÓ/®‚®ñU­•…3H¨+İnó=¡P@öÄçÂóxd‚öS·EÔİçsl. ÀÏnaë#ÊØÀf–CƒqWä\.fŸñôQäc@NÜ¤@a¨İå*÷˜b4çM"oÉÇÏ6†¿-ú–ífk~IÂn	 àT°HæéöjÕvû3è’(/‡ü¿ykĞ›(•¶”/`{‹ÑPH7¼ m÷R­¨—§Ù&·­àöQÁ-äcÜÍPÆÛz’U$ıÏOt½CØ_ºøñÇï…OÁ¨Í†a¥bÄ_øp‚1ò«uëª²Ô’_út·¨íä>LûÊ™Íms±;íße$¶6}ôƒR¡¬ë%#z&6B¸ —U£ˆñĞ
Å²ì-t»ËÀEÁYxÎ˜7à¨wX dÂû8(—c˜av3@8N»õ³Z«zŠ~æo+'µf½SJ7.ÂšX7oÑÔ\¼€®(	ÂzèBÍL6_¾bw=^®Ä DÅğ8^ì8¤çGüøB8„-½Pí›9}
(.:Œbx^™‹©9qc¤ÍP„Z
nEóZYÕtàzãE®µ•H´-¯¸Ÿİ+y}ñ@ü‡ß¨Û´®`˜o¬åVÀ·ô¢w<íæÔÛ*Q•˜ÍJ°Ğnír‚"ÿ0]4s»=˜š§Ö¨g93°qrğ]d«Uh– :¼å{Ç((±ëÂÁ Ú°«ŠiÍGl`DÛ³ùÍü³Dø`ìîL¡ 6Ü×óÙV8ÿö|@cÁøşØ<KİH·¨§xªÿ¼ø±Ùm-ş+æ øy#¿WÂüE£¸÷ÿññã?Šô2õ‘£^~Š¨ïä÷Œ}uOß7öJ¥Ò~8ÖcT!¯î0LhI×|ç'åYÆùéYãÔö¯÷ÿÃrışv.Öt‰2“¹•Ù¿_ÅÖäY©@h2ªàG‡¼Å+‘••DÉ(y.œDÌ» ı1P_£z"ùßŸèñó¿jy˜HÎÿ]×
˜ÿÃĞ´'şÿ§åÿøä$dş`ÿ;©?|)gµ-•ÌdŠy-¼óğÄàuFÊô”¹p-ñEEnû³º·èú©×:ú±û:[ÜíTc‹1•†¯ïä™B6g/vwcğ6)ÌÙëL;%¿HÇT¯¾p_¥Y¶Æß´Úõ1JõZX¨ö™DKÍÈÄsÓz÷’R¥„q¯jlmÍ#/õnbîÀÔËz©Lz1o³Qšëg°ÑÅÃ£ÎáG¨ÇĞy&Ã©æ‡­¹9e]rãT>z íN«vZíuÃ@óÅlD@ò¥ùb6ÚGXrV2Êõ&Îİ`ÀtŒ¤µÕkÕ*?š<Wâ`Æv G¨ÃßòÙıßÿ*|Íò_ôå/;¡Üp<†yg²³áF1<dÙ±şq«İ©7ŞÓjõwe¾ßQ¾I9ÃŞÇ-÷4€û¬†Á`ÛnÁ0s€¾­WjõN7èr´‰	ùQ§ÒiÔ£@'Öy^ØQã$
†$/ŠßPE¡#kˆ{·Ú82•^%j@Î b{ÊI·I£Õ–³ˆ ĞY¦6_7Ø`ı}å]»Ù¿»ëù$nŞàµI´Ößµ¢àFæõ,<{ğxöR_ê\rØÅÍÄ—{ÁšÖĞœà	{‘ÛB?{kHYêP~@H{o&Ì+U7Ï€i—jÊozT8¦é¿£Ñúv{•—k¢Íy’:›ğÇ •yPc/!Ş]İ¿/»¢é»šö»p¤‘ùz›Ø>ªÁ5Ç/5¬;ºb”†/ĞÉ ã¯:÷@G£s‘°F‹‡ÕÈEªË ÍäA²ÎtŸ/H”ú‡¦;(^V#vE´Ÿà â ZWˆ“äqŠ¨5æ„Pp=„ĞúØjœ²4ZâàŒs«q»¢*qxCòoq@Qˆà8ø„£àC¨>1§)ï+Â(Ú¦#Oº¶á «­“ãÆ›Ó†£%IROmØîËDèš'ˆÖ‘e	ø$–O	8Â¾”HÂ(sõ
¡8V2¯”	˜|\»Šë“F[âÒL4Ş.S&1t|ˆ×aâ|>¦[Å´Iıò˜,‘C9Jæ{}Ky‚×S>.ÿÊĞñÒW‘S8¸2™0×‡™SÌâ19æé˜·<,Û‹œØv$µ„XnïKĞ[<åá–­†·.¸…]·ÀØoğK^TªÊ½œ6í7u;óu‹ÜÅ¶CØÇ}byl—¶¹ğfI°›z‹ş?TÎg3F}0ÇÑ˜sD+”Î¢œ‹TÏËÂì‚tñØ:ÛÅ¶‹Ú„°ìtÆÃz²,nU™·Så·üqÃ'#çIáâÈŠQiK÷±ˆŞrÍœs=ÿ?N@§ò;C_AûaÒ?­:ÿ/”òÚòü_ÃüoF±Tx:ÿ{ÜóÿØ˜ÖÔr„û=æ%ÛxÌx‰doŠyCuï—Ö…¶Q{ğO-ëšQÚóßAùŞAà€gĞ+zpnÏ&7‰¦ÚmÙˆS:8 vÄ7½Ys6LZ]DÔâöPu±J*ÒWS¬ñ¸‹!¾C-©6¼O¥Y–qc%4ÁÙr÷°¼‚/üTÌÚ¥ãÕK«ÈPç1¾oÕFˆú}%ÁåBd³/1\T/ùÆÏ²k˜jE4Æ6©pŞÈ«x‰à˜LjD™„‘êtâ½P.Çıˆøz"[Ä,~—&D•µœKs!¸
(÷–æ€l:[\£WtæŸ˜³JBÀnÈŒ	øbY¯°W k5úÅyä…#ØÖ”òæ¾ğŞ'g¬,ë+Ï¾3úJl¸#ŠƒƒÀĞ§0ZgB5´ÄG¯›¸T)>hšíE†¸]Åà½ôÀU7òıNn'³ÓïïD!Œwù‰‹)äå®5©…°”×ö“V°XEE£lEÙµG+hû†
BD‰q~R6õÂrÒ°áSi»S˜ÂwŠHß¢ÄÜ×şt,¤‹—ç-øRwÜ%¯5NÉµUa×›F9í+^¬5>˜è	o6á&ä7Úc”‚ü3F9^öïßïôş+–:Zwéx\ô•ñSÛırİĞT:lZ/ÓìCas"˜@RlÛøĞI[ù|a®şæüÓóô<=OÏÓóô<=OÏC>ÿaİF    