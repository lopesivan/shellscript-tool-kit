#!/bin/bash

cat << EOF
#BOOST_PATH    := /usr/include/boost

sources        = \$(wildcard *.c)
objects        = \$(sources:.c=.o)
program        = app

#INCLUDE        = -I\$(BOOST_PATH)

##############################################################################
##############################################################################
##############################################################################

CC          = gcc
LD          = \$(CC)
WARNINGS    = -Wall -ansi
GDBFLAGS    = -g

CFLAGS      = \$(WARNINGS) \$(GDBFLAGS) \$(INCLUDE) \$(DEFINEFLAGS)

all:          \$(program) tags

EOF

FILES=(
	$( cat - )
)

source_name=${FILES%.c}
object_name=${FILES[*]/%.c/.o}

cat << EOF
\$(program): ${object_name[*]}
	\$(CC) \$(LDFLAGS) -o \$@ \$^

EOF

cat << EOF
tags:
	ctags -R --c-kinds=+p --fields=+iaS --extra=+q \$(sources)

clean:
	/bin/rm -rf \$(program) \$(object) tags *.orig

# END OF FILE
EOF
