#!/bin/bash

_basename=${0##*/}
REGEX=$1
_STR_=$2
[ "$2" ] || {
cat <<End-Of-Usage; exit 1
Usage:
echo "aaaabbbcb.c" | $_basename \.c$ .nova-extensao
End-Of-Usage
}
# ----------------------------------------------------------------------------
cat - | xargs -n1 -I{} echo {} | while read file; do
    echo $file| sed "p; s/$REGEX/$_STR_/; tUp; d;d;:Up" | sed 'N;s/\n/ /; s/^/mv /'
done
#sed "p; s/$REGEX/$_STR_/; tUp; d;d;:Up" | sed 'N;s/\n/ /; s/^/mv /'

# uso
# echo "aaaabbbcb.c" | repattern \.c$ .nova-extensao

# ----------------------------------------------------------------------------
exit 0

