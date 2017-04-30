#!/bin/bash
# vi:set nu nowrap:
# vm.svn.start.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: vm.svn.start.sh
#        Date: Qua 15 Set 2010 21:26:35 BRT
# Description:
#
#
machine=/virtualmachines/vmware/svn/VMserver-clone-2/VMserver.vmx
# ----------------------------------------------------------------------------
nVM=$( vmrun -T ws list | sed -n 's/Total running VMs:\s*\([0-9]\+\)/\1/p' )

if (( nVM > 0 )); then

	vmrun -T ws list | \
		grep "$machine"

	if [ $? -eq 0 ]; then
		vmrun -T ws stop "$machine" soft
	fi

fi

# ----------------------------------------------------------------------------
exit 0
