#!/bin/bash

cat << EOF
#BOOST_PATH    := /usr/include/boost

sources        = \$(wildcard *.cpp)
objects        = \$(sources:.cpp=.o)
programs       = \$(sources:.cpp=)

INCLUDE        = -I\$(BOOST_PATH)

##############################################################################
##############################################################################
##############################################################################

CC          = g++
LD          = \$(CC)
CXX         = \$(CC)
WARNINGS    = -Wall
GDBFLAGS    = -g
LDFAGS     += \$(LIBS)

CPPFLAGS    = \$(CPP_FLAGS) \$(WARNINGS) \$(GDBFLAGS) \$(INCLUDE) \$(DEFINEFLAGS)

all:          \$(programs)

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
clean:
	/bin/rm -rf \$(program) \$(object) tags *.orig *.A

# END OF FILE
EOF
