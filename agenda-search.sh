#!/bin/bash
#
# $* = nome a procurar
#
# exemplo de uso:
# $ ./consulta.sh Super
# $ ./consulta.sh Super*
# $ ./consulta.sh *Super*
# $ ./consulta.sh super man
#
# O * é um curinga, fazendo procura parcial
#

# converte data de aaaa-mm-dd para dia/mes/ano
data_mysql-to-brasil()
{
	echo "$*" | sed 's,\([0-9]\{4\}\)-\([0-9][0-9]\)-\([0-9][0-9]\),\3/\2/\1,'
}

# Testa pra ver se é procura exata ou parcial
if [ "$*" = "${*#*\*}" ];then
	# procura exata
	S=$(
		mysql -u ivan -e \
		"
		SELECT * FROM agenda
			WHERE nome = '$*'
		" mysql_bash
	)
	# Procura por partes do nome
else
	# ${*//\\*/%} = troca todos * por %, que é o curinga do LIKE
	S=$(
		mysql -u ivan -e \
		"
		SELECT * FROM agenda
			WHERE nome LIKE '${*//\*/%}'
		" mysql_bash
	)
fi

# a procura retornou algum registro ?!
[ "$S" ] || { echo "Registro não encontrado";exit; }

# colocar um TAB como IFS
IFS="$(echo -e '\t')"
# Apagamos a primeira linha, pois ela contém o nome dos campos
S=$(echo "$S" | sed '1d')

# colocamos um espaço em branco entre TABs repetidos (\t\t)
echo "$S" | sed ":a;s/\(`echo -e '\t'`\)\(\1\)/\1 \2/;ta" | \
while read nome fone mail aniver; do

	echo "
	Nome       : $nome
	Telefone   : $fone
	E-mail     : $mail
	Aniversário: $(data_mysql-to-brasil $aniver)"
done

#-----------------------------------------------------------------------------
exit 0
