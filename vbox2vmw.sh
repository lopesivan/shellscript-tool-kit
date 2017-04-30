#!/bin/bash
exit 0
# vi:set nu nowrap:
# vbox2vmw.sh: .

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: vbox2vmw.sh
#        Date: Mon 06 Jul 2009 04:20:39 PM BRT
# Description:
#
#

# ----------------------------------------------------------------------------
image_name=${VDI%.vdi}

vditool copydd ${image_name}.vdi ${image_name}.dd

cat << EOF
Once we have the raw data, we can create the VMDK metadata for our DD image.
We compute the size of the raw data in sectors by dividing its size in bytes
by 512:

stat --printf="%s 512/p" ${image_name}.dd | dc
EOF
size_of_the_raw_data="$(stat --printf="%s 512/p" ${image_name}.dd | dc )"

cat << EOF
We also need to compute the CHS geometry of the virtual disk. I used the
assumption of 255 heads and 63 sectors:

stat --printf="%s 512/255/63/p" ${image_name}.dd | dc
EOF
ddb_geometry_cylinders="$(stat --printf="%s 512/255/63/p" ${image_name}.dd| dc)"

cat >${image_name}-flat.vmdk << __EOF__
# Disk DescriptorFile
version=1
CID=4dd210c6
parentCID=ffffffff
createType="monolithicFlat"

# Extent description
RW $size_of_the_raw_data FLAT "$image_name.dd" 0

# The Disk Data Base
#DDB

ddb.virtualHWVersion  = "4"
ddb.geometry.cylinders= "$ddb_geometry_cylinders"
ddb.geometry.heads    = "255"
ddb.geometry.sectors  = "63"
ddb.adapterType       = "buslogic"
__EOF__

echo And there you have it: a growable converted VMDK from VDI:
vmware-vdiskmanager -r ${image_name}-flat.vmdk -t 0 ${image_name}.vmdk

# ----------------------------------------------------------------------------
exit 0
