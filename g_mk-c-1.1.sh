#!/bin/bash

cat << EOF
#BOOST_PATH    := /usr/include/boost

sources        = \$(wildcard *.c)
objects        = \$(sources:.c=.o)
programs       = \$(sources:.c=)

#INCLUDE        = -I\$(BOOST_PATH)

##############################################################################
##############################################################################
##############################################################################

CC          = gcc
LD          = \$(CC)
WARNINGS    = -Wall -ansi
GDBFLAGS    = -g

CFLAGS      = \$(WARNINGS) \$(GDBFLAGS) \$(INCLUDE) \$(DEFINEFLAGS)

all:          \$(programs) tags

EOF

FILES=(
	$( cat - )
)

for file in ${FILES[*]};
do
	source_name=${file%.c}
	object_name=${source_name}.o

	echo ${source_name}:
done

cat << EOF
tags:
	ctags -R --c-kinds=+p --fields=+iaS --extra=+q \$(sources)

clean:
	/bin/rm -rf \$(programs) \$(object) tags *.orig

# END OF FILE
EOF
