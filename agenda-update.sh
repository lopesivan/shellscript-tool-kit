#!/bin/bash
#
# $* = nome a procurar
#
# exemplo de uso:
# $ ./atualiza.sh telefone super man
# $ ./atualiza.sh nome super*
# $ ./atualiza.sh aniversario *super*
#
# O * é um curinga, fazendo procura parcial
#

# Testa se a data recebida, no formato do MySQL, é válida ou não
checa_data(){
	[ $(echo "$1" | sed 's,[12][0-9]\{3\}/\(0[1-9]\|1[012]\)/\(0[1-9]\|[12][0-9]\|3[01]\),,') ] &&
	return 1 || return 0
}

# Retorna quantas linhas a query SQL alterou na base de dados
linha(){
	sed -n '/^Query/s/.*, \([0-9]\+\) row.*/\1/p'
}

# testa se o campo a alterar é válido
[ "$1" != nome -a "$1" != telefone -a "$1" != email -a "$1" != aniversario ] &&
{ echo "Campos Validos: nome telefone email aniversario";exit; }

# colocamos em campo o $1,e um shift para podermos usar o $*
campo=$1
shift

# se é aniversário é data então para o MySQL é aaaa-mm-dd
if [ "$campo" = "aniversario" ];then
	read -n2 -p "Novos dados para Aniversário (dia/mes/ano): " dia
	read -n2 -p "/" mes
	read -n4 -p "/" ano
	dados="$ano/$mes/$dia"
	echo

	# testa se a data é válida
	checa_data "$dados" || { echo "ERRO: Data de aniversário inválida";exit; }
else
	read -p "Novos dados para $campo: " dados
	# se é para trocar o nome, não aceitamos o nome nulo
	[ "$campo" = "nome" -a ! "$dados" ] && { echo "ERRO: nome inválido";exit; }
fi

# Testa pra ver se é procura exata ou parcial
if [ "$*" = "${*#*\*}" ];then # procura exata
	S=$(
		mysql -vv -u ivan -e \
		"
		UPDATE agenda 
			SET $campo='$dados' WHERE nome = '$*'
		" mysql_bash | linha
	)

	[ $S -eq 0 ] && echo "Registro não encontrado" || echo "Foram alterado(s) $S registro(s)"
	# Procura por partes do nome
else
	S=$(
		mysql -vv -u ivan -e \
		"
		UPDATE agenda 
			SET $campo='$dados' WHERE nome LIKE '${*//\*/%}'
		" mysql_bash | linha
	)

	[ $S -eq 0 ] && echo "Registro não encontrado" || echo "Foram alterado(s) $S registro(s)"
fi
