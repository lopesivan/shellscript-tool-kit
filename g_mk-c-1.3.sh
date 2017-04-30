#!/bin/bash

cat << EOF
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

all:          \$(programs)

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
clean:
	/bin/rm -rf \$(programs) \$(object) tags *.orig *.A

# END OF FILE
EOF
