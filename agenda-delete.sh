#!/bin/bash
#
# $* = nome a procurar
#
# exemplo de uso:
# $ ./deleta.sh Super
# $ ./deleta.sh Super*
# $ ./deleta.sh *Super*
# $ ./deleta.sh super man
#
# O * é um curinga, fazendo procura parcial
#

# Retorna quantas linhas a query SQL alterou na base de dados
linha(){
	sed -n '/^Query/s/.*, \([0-9]\+\) row.*/\1/p'
}

# Testa pra ver se é procura exata ou parcial
if [ "$*" = "${*#*\*}" ];then # procura exata
	S=$(
		mysql -vv -u ivan -e \
		"
		DELETE FROM agenda
			WHERE nome = '$*'
		" mysql_bash | linha
	)

	[ $S -eq 0 ] && echo "Registro não encontrado" || echo "Foram deletado(s) $S registro(s)"

	# Procura por partes do nome
else
	S=$(
		mysql -vv -u ivan -e \
		"
		DELETE FROM agenda
			WHERE nome LIKE '${*//\*/%}'
		" mysql_bash | linha
	)

	[ $S -eq 0 ] && echo "Registro não encontrado" || echo "Foram deletado(s) $S registro(s)"
fi
