#! /usr/bin/awk -f

# Comandos que serao executados antes de varrer o arquivo
BEGIN {
	print "-*- Procedimento para calcular a resistência equivalente -*-"
}
# Comandos que serao executados depois de varrer o arquivo
END {
	print "A Resistência Equivalente: ", 1/sum, "\n"
}
# Comandos que serao executados enquanto varre o arquivo
{
	sum  = 0
	nRes = 0

	while ( nRes < NF )
	{
		print "nRes: " nRes
		nRes++
		res=$1
		sum = sum + 1/res
		print "res =", res
	shift
	}
}
