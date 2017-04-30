#!/bin/bash --norc
#
# Convertendo man pages em pdf's
#
# Sandro Marcell (sandro_marcell@yahoo.com.br)

# Realçando saída:
Echo() { echo -e "\e[1m$*\e[m" ; }

# São necessários: Ghostscript e troff:
[[ $(which gs) ]] || { Echo "-> É necessário o Ghostscript" ; exit 1 ; } 
[[ $(which troff) ]] || { Echo "-> É necessário o troff" ; exit 1 ; }

# Checando parâmetros:
[[ $# != 1 ]] &amp;&amp; Echo "Uso: ${0##*/} [comando]" &amp;&amp; exit 1

# Checando a existência do comando:
[[ $(which $1) ]] || { Echo "[$1] Comando inexistente." ; exit 1 ; }

# Existe man page para o comando especificado?
[[ $(whereis $1 | fgrep "man") ]] || {
   Echo "-> Não existe man page para [$1]"
   exit 1
}

# Convertendo:
man -t $1 > $1.ps
[[ $? == 0 ]] &amp;&amp; {
gs -dQUIET -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
-sOutputFile=$1.pdf $1.ps

rm -f $1.ps 2> /dev/null

Echo "Arquivo pdf criado." ; exit

} || { Echo "-> Erro ao criar arquivo pdf" ; exit 1 ; }
# Fim
