#! /bin/bash

# Usage
# ./g_tp.sh cansi-sample-thread-01
# ./g_tp.sh cansi-sample-thread-02

_basename=${0##*/}
[ "$1" ] || {
	echo -e "Example:\n\$ $_basename cansi-sample-thread-01"
	exit 1
}

rename 's/-/_/g' *

cat <<EOF-MAIN > $1-00.txt
###############
# get source. #
###############
cmd='--$1'
n=\$(expr "\$(tp list \${cmd}| nl| tail -2| head -1)" : '[[:blank:]]*\([0-9]*\)')

arr=( empty empty \`tp list \${cmd} | sed -n "2,\${n}s/.*-//p"\` ) && seq -f"tp %g " 2 \$n | sed 's/tp \([0-9]\+\)/& > \${arr[\1]}/' > prj
cat << EOF >> prj
# Modo 1  - Usando scripts
#chmod +x compile.sh clean.sh

# Modo 2  -  c++ e nao tenho make
#tp list --makefile-cpp-unrestricted
#tp 1 > Makefile
#make

# Modo 3  -  tenho make
#make
EOF

# run
. prj

# clean
history | tail -1 | sed 's/.*\./rm prj  /'| sh

# restore
tp list \${cmd}-00| sed '1iRestore build template mode:\nUsage: tp 1 > a; . a'
EOF-MAIN

ls | sed "/^.*\.txt/d; /$_basename/d; /RCS/d; s/^.*$/cp & $1-&.txt/" |sh
