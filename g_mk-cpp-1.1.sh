#!/bin/bash

cat << EOF
#BOOST_PATH    := /usr/include/boost

sources        = \$(wildcard *.cpp)
objects        = \$(sources:.cpp=.o)
program        = \$(sources:.cpp=)

#INCLUDE        = -I\$(BOOST_PATH)

##############################################################################
##############################################################################
##############################################################################

CC          = g++
LD          = \$(CC)
CXX         = \$(CC)
WARNINGS    = -Wall
GDBFLAGS    = -g

CPPFLAGS    = \$(CPP_FLAGS) \$(WARNINGS) \$(GDBFLAGS) \$(INCLUDE) \$(DEFINEFLAGS)

all:          \$(program) tags

EOF

FILES=(
	$( cat - )
)

for file in ${FILES[*]};
do
	source_name=${file%.cpp}
	object_name=${source_name}.o

	echo ${source_name}:
done

cat << EOF
tags:
	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q \$(sources)

clean:
	/bin/rm -rf \$(program) \$(object) tags *.orig

# END OF FILE
EOF
