#!/bin/bash
# Esse script gira um arquivos de imagem.
# Versão para zenity
#
# Lendo os arquivos que serão girados
Arq=$(zenity --file-selection --multiple --separator '^') || exit 1
# Agora tenho uma lista de arquivos separados por circunflexo (^)
#+ Vamos "escapar" os espaços em branco dos nomes dos arquivos
#+ e substituir os circunflexos por espaços em branco para
#+ criar uma lista para o mogrify rodar todos de uma vez.
Arq=$(sed 's/ /\\ /g;s/\^/ /g' <<< "$Arq")
# Montando uma radio list para capturar o ângulo de rotação
Ang=$(zenity --list --radiolist --height 240 --title "Ângulo de rotação" \
--text "Escolha o ângulo que sua\n imagem será girada" \
--column Marque --column ângulo true 90 false 180 \
false 270 false "Outro valor") || exit 1
[ "$Ang" = "Outro valor" ] && {
		Ang=$(zenity --entry --title "Ângulo especial" \
		--text "Informe o ângulo entre 1° e 359°") || exit 1
		(($Ang < 1 || $Ang > 359)) && {
				zenity --error --title "Erro" \
				--text "O ângulo deveria ser entre 1° e 359°"
				exit 1
		}
}
mogrify -rotate $Ang "$Arq"
