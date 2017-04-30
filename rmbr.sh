#!/bin/bash

USER=ivan
NUMBER_OF_VM=3
#-----------------------------------------------------------------------------

# if you have a dhcp-server uncomment this line:
dhclient3 br0

# create the taps and insert them into the bridge

# bring the interfaces down
ifconfig br0 down

NB=1
while [ $NB -lt $NUMBER_OF_VM ]
do
	# bring the interfaces down
	ifconfig tap$NB down
	brctl delif br0 tap$NB

	let NB=$NB+1
done

brctl delbr br0

#now setup your network-interface again
#for dhcp uncomment the following line
dhclient3 eth0

#-----------------------------------------------------------------------------
exit 0
