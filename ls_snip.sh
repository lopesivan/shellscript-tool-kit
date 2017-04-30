#!/usr/bin/env sh

list_snippets_for() {
  # if exist file `_f' then search.
  _f=~/.vim/bundle/vim-snippets/UltiSnips/$1.snippets
  test -e $_f &&
    egrep "^snippet|^#" $_f| sed '$d'

  _f=~/.vim/UltiSnips/$1.snippets
  test -e $_f &&
    egrep "^snippet|^#" $_f |
      sed '1i###########################################################################\n#                            Local Snippets                               #\n###########################################################################'
}

[ "$1" ] || {
    echo You must specify at least one file type as an argument to `basename $0`;
    echo;
    `basename $0` snippets;
    exit 1;
  }

for filetype in "$@"
do
  echo `echo $filetype | awk '{print toupper($0)}'`
  list_snippets_for $filetype
  echo
done

exit 0
