#!/bin/bash
# Esse script coloca molduras em fotografias
# Versão para zenity
#
Larg=5 # quanto maior for este número, mais larga será a moldura
Arqs=$(zenity --file-selection --multiple --separator '^') || exit 1

# Agora tenho uma lista de arquivos separados por circunflexo (^)
#+ Vamos trocar por ~+= os espaços em branco dos nomes dos arquivos
#+ e depois substituir os circunflexos por espaços em branco para
#+ criar uma lista para o mogrify rodar todos de uma vez.

Arqs=$(sed 's/ /~+=/g;s/\^/ /g' <<< "$Arqs")
for CadaUm in $Arqs
do
CadaUm=$(sed 's/~+=/ /g' <<< $CadaUm) # Repondo os espaços em branco
#+ do nome de cada arquivo
convert "$CadaUm" -bordercolor white -border $Larg "$CadaUm"
done
