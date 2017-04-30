#!/bin/bash
# vi:set nu nowrap:
# vm.sh: .
prefix=146.164.42

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: vm.sh
#        Date: Thu 30 Oct 2008 07:25:12 AM BRT
# Description:
#
#

netmask=255.255.255.192
network=${prefix}.192
broadcast=${prefix}.255
gateway=192.168.42.193
dns_nameservers=${prefix}.193

# ----------------------------------------------------------------------------
[ "$1" = '-h' -o "$1" = '--help' ] && {
	echo "usage: $(basename $0) -[fu|l|m] --[ssh|scp|ip|cmd|interface|resolv]"
	exit 0
}

##############################################################################
: ${root:=root}
: ${Administrator:=Administrator}
: ${developer:=developer}
: ${lopesivan:=lopesivan}
##############################################################################

# ----------------------------------------------------------------------------

f_interface()
{

ip=$1

# output in stderr
echo file: /etc/network/interfaces >&2

# output in stdout
cat << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
#allow-hotplug eth0
#iface eth0 inet dhcp

# The primary network interface
auto eth0
iface eth0 inet static
address   $ip
netmask   $netmask
network   $network
broadcast $broadcast
gateway   $gateway
# dns-* options are implemented by the resolvconf package, if installed
dns-nameservers $dns_nameservers
EOF

# output in stderr
echo command: sudo /etc/init.d/networking restart >&2
}

f_resolv()
{

# output in stderr
echo file: /etc/resolv.conf >&2

# output in stdout
cat << EOF
nameserver $dns_nameservers
EOF

# output in stderr
echo command: sudo /etc/init.d/networking restart >&2
}

f_ifconfig()
{
ip=$1
cat << EOF
ifconfig eth0 $ip netmask $netmask broadcast $broadcast up
route del default
route add default gw $gateway dev eth0
EOF

f_resolv
}

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

#
# set file
# usage: -f fileName
#
[ "$1" = '-f' -a "$#" -ge 2 ] && {
	file=$2
	shift; shift;
}

#
# set user
# usage: -u userName
#
[ "$1" = '-u' -a "$#" -ge 2 ] && {
	root=$2
	Administrator=$2
	developer=$2
	lopesivan=$2

	shift; shift;
}
[ "$1" = '-l' ] && cat << EOF
Machines
--------
197 - server

Virtual Machines
----------------
217 - v subversion
218 - v iptv server
219 - v UbuntuVanilla
220 - v WinXpVanilla
221 - v Win2000Vanilla
223 - v NightBuild-Linux
224 - v NightBuild-Win
226 - v	PluginMachine
227 - v	WindowsFlashMediaServer
228 - v UbuntuStreamServer
230 - v debian-40r4a-i386-netinst
233 - v WinXP_sp2_apr2006d
234 - v UbuntuStreamServer60G
EOF

[ "$1" = '-m' ] && case $2 in

197) echo 217 -   server                   ;;
217) echo 217 - v subversion               ;;
218) echo 218 - v iptv server              ;;
219) echo 219 - v UbuntuVanilla            ;;
220) echo 220 - v WinXpVanilla             ;;
221) echo 221 - v Win2000Vanilla           ;;
223) echo 223 - v NightBuild-Linux         ;;
224) echo 224 - v NightBuild-Win           ;;
226) echo 226 - v PluginMachine            ;;
227) echo 227 - v WindowsFlashMediaServer  ;;
228) echo 228 - v UbuntuStreamServer       ;;
230) echo 230 - v debian-40r4a-i386-netinst;;
233) echo 233 - v WinXP_sp2_apr2006d       ;;
234) echo 234 - v UbuntuStreamServer60G    ;;
*  ) echo Usage: $(basename $0) -m last octets ; exit 1 ;;
esac

# ----------------------------------------------------------------------------

[ "$1" = '--ssh' ] && case $2 in
197) echo ${1#--} ${root}@${prefix}.197         ;;
217) echo ${1#--} ${root}@${prefix}.217         ;;
218) echo ${1#--} ${root}@${prefix}.218         ;;
219) echo ${1#--} ${root}@${prefix}.219         ;;
220) echo ${1#--} ${root}@${prefix}.220         ;;
221) echo ${1#--} ${root}@${prefix}.221         ;;
223) echo ${1#--} ${root}@${prefix}.223         ;;
224) echo ${1#--} ${root}@${prefix}.224         ;;
226) echo ${1#--} ${developer}@${prefix}.226    ;;
227) echo ${1#--} ${Administrator}@${prefix}.227;;
228) echo ${1#--} ${developer}@${prefix}.228    ;;
230) echo ${1#--} ${lopesivan}@${prefix}.230    ;;
233) echo ${1#--} ${Administrator}@${prefix}.233;;
234) echo ${1#--} ${developer}@${prefix}.234    ;;
*  ) echo Usage: $(basename $0) --${1#--} last octets; exit 1        ;;
esac

# ----------------------------------------------------------------------------

[ "$1" = '--scp' ] && case $2 in
197) echo ${1#--} $file ${root}@${prefix}.197:         ;;
217) echo ${1#--} $file ${root}@${prefix}.217:         ;;
218) echo ${1#--} $file ${root}@${prefix}.218:         ;;
219) echo ${1#--} $file ${root}@${prefix}.219:         ;;
220) echo ${1#--} $file ${root}@${prefix}.220:         ;;
221) echo ${1#--} $file ${root}@${prefix}.221:         ;;
223) echo ${1#--} $file ${root}@${prefix}.223:         ;;
224) echo ${1#--} $file ${root}@${prefix}.224:         ;;
226) echo ${1#--} $file ${developer}@${prefix}.226:    ;;
227) echo ${1#--} $file ${Administrator}@${prefix}.227:;;
228) echo ${1#--} $file ${developer}@${prefix}.228:    ;;
230) echo ${1#--} $file ${lopesivan}@${prefix}.230:    ;;
233) echo ${1#--} $file ${Administrator}@${prefix}.233:;;
234) echo ${1#--} $file ${developer}@${prefix}.234:    ;;
*  ) echo Usage: $(basename $0) --${1#--} last octets; exit 1  ;;
esac
# ----------------------------------------------------------------------------

[ "$1" = '--ip' ] && case $2 in
197) echo ${prefix}.197            ;;
217) echo ${prefix}.217            ;;
218) echo ${prefix}.218            ;;
219) echo ${prefix}.219            ;;
220) echo ${prefix}.220            ;;
221) echo ${prefix}.221            ;;
223) echo ${prefix}.223            ;;
224) echo ${prefix}.224            ;;
226) echo ${prefix}.226            ;;
227) echo ${prefix}.227            ;;
228) echo ${prefix}.228            ;;
230) echo ${prefix}.230            ;;
233) echo ${prefix}.233            ;;
234) echo ${prefix}.234            ;;
*  ) echo Usage: $(basename $0) --ip last octets; exit 1;;
esac

# ----------------------------------------------------------------------------

[ "$1" = '--interface' ] && case $2 in
197) f_interface `$(basename $0) --ip $2`        ;;
217) f_interface `$(basename $0) --ip $2`        ;;
218) f_interface `$(basename $0) --ip $2`        ;;
219) f_interface `$(basename $0) --ip $2`        ;;
220) f_interface `$(basename $0) --ip $2`        ;;
221) f_interface `$(basename $0) --ip $2`        ;;
223) f_interface `$(basename $0) --ip $2`        ;;
224) f_interface `$(basename $0) --ip $2`        ;;
226) f_interface `$(basename $0) --ip $2`        ;;
227) f_interface `$(basename $0) --ip $2`        ;;
228) f_interface `$(basename $0) --ip $2`        ;;
230) f_interface `$(basename $0) --ip $2`        ;;
233) f_interface `$(basename $0) --ip $2`        ;;
234) f_interface `$(basename $0) --ip $2`        ;;
*  ) echo Usage: $(basename $0) --interface last octets; exit 1;;
esac

# ----------------------------------------------------------------------------

[ "$1" = '--resolv' ] && f_resolv

# ----------------------------------------------------------------------------

[ "$1" = '--cmd' ] && case $2 in
197) f_ifconfig `$(basename $0) --ip $2`        ;;
217) f_ifconfig `$(basename $0) --ip $2`        ;;
218) f_ifconfig `$(basename $0) --ip $2`        ;;
219) f_ifconfig `$(basename $0) --ip $2`        ;;
220) f_ifconfig `$(basename $0) --ip $2`        ;;
221) f_ifconfig `$(basename $0) --ip $2`        ;;
223) f_ifconfig `$(basename $0) --ip $2`        ;;
224) f_ifconfig `$(basename $0) --ip $2`        ;;
226) f_ifconfig `$(basename $0) --ip $2`        ;;
227) f_ifconfig `$(basename $0) --ip $2`        ;;
228) f_ifconfig `$(basename $0) --ip $2`        ;;
230) f_ifconfig `$(basename $0) --ip $2`        ;;
233) f_ifconfig `$(basename $0) --ip $2`        ;;
234) f_ifconfig `$(basename $0) --ip $2`        ;;
*  ) echo Usage: $(basename $0) --ip last octets; exit 1;;
esac

# ----------------------------------------------------------------------------
exit 0
