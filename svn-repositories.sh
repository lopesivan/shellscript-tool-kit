#!/bin/bash
# vi:set nu nowrap:
# repositorio.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: repositorio.sh
#        Date: Sun 23 May 2010 11:27:29 AM BRT
# Description:
#
#
IP=192.168.1.105
# ----------------------------------------------------------------------------

projects=(
$( curl -k https://${IP}/cgi-bin/svn-projects.pl 2>&- )
)

SERVER=https://${IP}/svn

if [ "$1" == '-co' ]; then
# Tortoise svn
#-----------------------------------------------------------------------------
	Tortoise='"%PROGRAMFILES%\TortoiseSVN\bin"\TortoiseProc.exe /command:checkout'
	for prj in ${projects[*]}; do
cat << EOF > get-${prj}.bat
@echo off
$Tortoise /url:"${SERVER}/${prj}" /path:"C:\workspace\\${prj}" /closeonend:1
exit 0
EOF
	done
	exit 0
fi

if [ "$1" == '-up' ]; then
# Tortoise svn
#-----------------------------------------------------------------------------
	Tortoise='"%PROGRAMFILES%\TortoiseSVN\bin"\TortoiseProc.exe /command:checkout'
	Tortoise='"%PROGRAMFILES%\TortoiseSVN\bin"\TortoiseProc.exe /command:update'
	for prj in ${projects[*]}; do
cat << EOF > update-${prj}.bat
@echo off
$Tortoise /url:"${SERVER}/${prj}" /path:"C:\workspace\\${prj}" /closeonend:1
exit 0
EOF
	done
	exit 0
fi

# list repositories ...
#-----------------------------------------------------------------------------

# isdigit
expr "$1" : '[[:digit:]]\{1,\}' > /dev/null

if [ $? -eq 0 ]; then
	r=${projects[$1-1]}
	echo svn --username `whoami` co ${SERVER}/${r} ${r}
	exit 0
fi

for prj in ${projects[*]}; do
	echo svn --username `whoami` co ${SERVER}/${prj} ${prj}
done | nl

# ----------------------------------------------------------------------------
exit 0
