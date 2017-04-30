#!/bin/bash

USER=ivan
NUMBER_OF_NET=2
net_interface=vboxnet
#-----------------------------------------------------------------------------

# create the taps and insert them into the bridge
declare -r  _on=1
declare -r _off=0

NB=0
while [ $NB -lt $((NUMBER_OF_NET)) ]; do

	ifconfig | grep ${net_interface}$NB && state=$_on || state=$_off

	echo ${net_interface}$NB : $state

	if [ $state = $_off  ]; then
		echo sudo ifconfig ${net_interface}$NB up
	else
		echo sudo ifconfig ${net_interface}$NB down
	fi

	let NB=$NB+1
done

#-----------------------------------------------------------------------------
exit 0
