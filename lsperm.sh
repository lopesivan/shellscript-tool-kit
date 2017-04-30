#! /bin/bash

for f in $*; do

		W=`ls -l $f| sed 's/ .*//'`
		echo -n $W
		echo -n " : "

		c=1
		for ((i=1;i<${#W};i++));do

				case ${W:$i:1} in
						-) let s=s+0;;
						r) let s=s+4;;
						w) let s=s+2;;
						x) let s=s+1;;
				esac

				if test $c -eq  3; then
						echo -n $s
						c=1; s=0
				else
						let c++
				fi
		done

		echo " : $f"
done
