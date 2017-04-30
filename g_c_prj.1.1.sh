#! /bin/bash

for src in f{1..10}.c;
do

	_HEADER=${src%.c}
	_NUM=${_HEADER##f}

cat << EOF >> main.c
#include "${_HEADER}.h"
EOF

cat << EOF > $src
#include "${_HEADER}.h"

int
f${_NUM} (void)
{
	int r_val = $_NUM;

	return r_val;
}
EOF

cat << EOF > ${_HEADER}.h
#ifndef F${_NUM}_H
#define F${_NUM}_H

int f${_NUM} (void);

#endif
EOF

cat << EOF >> .f
	printf ("f${_NUM} return: %d\n",f${_NUM}() );
EOF

done

cat << EOF >> main.c
#include <stdio.h>

int
main(void)
{
EOF

cat .f >> main.c

cat << EOF >> main.c

	return 1;
}
EOF

rm .f
