#!/bin/bash
#
# Repare que a data para o MySQL é aaaa-mm-dd
#

# Testa se a data recebida, no formato do MySQL, é válida ou não
checa_data(){
	[ $(echo "$1" | sed 's,[12][0-9]\{3\}/\(0[1-9]\|1[012]\)/\(0[1-9]\|[12][0-9]\|3[01]\),,') ] &&
	return 1 || return 0
}

echo "Entre com os dados para incluir na agenda"
echo
read -p "Nome       : " nome
read -p "Telefone   : " fone
read -p "E-Mail     : " mail
read -n2 -p "Aniversário (dia/mes/ano): " dia
read -n2 -p "/" mes
read -n4 -p "/" ano
echo

#colocamos na variável aniver a data no formato do MySQL
aniver="$ano/$mes/$dia"
echo

# se a data não for nula
if [ "$ano" -o "$mes" -o "$dia" ];then
	# testa se a data é válida
	checa_data "$aniver" || { echo "ERRO: Data de aniversário inválida";exit; }
fi

# não aceitamos nomes nulo
[ "$nome" ] || { echo "ERRO: nome inválido";exit; }

read -p "Deseja Incluir (s/n)? "
if [ "$REPLY" = "s" ];then
	mysql -u ivan -e\
		"INSERT INTO agenda VALUES
		(
			'$nome',
			'$fone',
			'$mail',
			'$aniver'
		)" mysql_bash

	[ "$?" = "0" ] && echo "Operacao OK" || echo "Operação: ERRO"
fi

#-----------------------------------------------------------------------------
exit 0
