#!/bin/bash

USER=ivan
NUMBER_OF_VM=3
#-----------------------------------------------------------------------------

# load module
modprobe tun
chmod 666 /dev/net/tun

# create the bridge
brctl addbr br0
ifconfig eth0 0.0.0.0
brctl addif br0 eth0

#if you have a dhcp-server uncomment this line:
dhclient3 br0

# create the taps and insert them into the bridge

NB=1
while [ $NB -lt $NUMBER_OF_VM ]
do
	# change your username accordingly
	tunctl -t tap$NB -u $USER

	#Now add the tap-device to the bridge:
	ifconfig tap$NB up
	brctl addif br0 tap$NB

	let NB=$NB+1
done

#-----------------------------------------------------------------------------
exit 0
