#! /bin/bash

#service networking  restart

ifconfig usb0 down
ip address add 192.168.0.200/24 dev usb0
ip link set dev usb0 up

iptables -F # clean

iptables -A FORWARD -s 192.168.0.202 -j ACCEPT
iptables -A FORWARD -d 192.168.0.202 -j ACCEPT
iptables -P FORWARD DROP

#iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE

/sbin/route add -host 192.168.0.202/32 dev usb0
iptables -A POSTROUTING -t nat -j MASQUERADE -s 192.168.0.0/24
iptables -P FORWARD ACCEPT
sysctl -w net.ipv4.ip_forward=1

iptables -I FORWARD 1 -j LOG --log-level 5 --log-prefix 'MAEMO > '

service networking restart

##############################################################################
exit 0

