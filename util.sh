
  _mail="`git config --get user.email`"
_author="`git config --get user.name`"

#
# ----------------------------- error functions ------------------------------
#

# The error function print menssage of error.
#
_error() {
        exec 4>&1 # stdout duplicado ( FD 4 tem as mesmas caracteristicas
                  # do STDOUT), aponta para o terminal.
	exec 1>&2

	echo ERROR: "$*"

        exec 1>&4        # FD 1 recebe as caracteristicas de FD 4.
                         # FD 1 ressetado.

        exec 4>&-        # FD 4 eh liberado.
}

# The error function print menssage of error.
#
_abort_now() {
	_error '***' aborted '***'
	exit 1
}

#
#----------------------------------- have ------------------------------------
#

# this function checks whether we have a given program on the system.
# no need for bulky functions in memory if we don't.
#
have () {
	unset -v have
	path=$path:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
	have="yes"
}

# inner function to reapeat char n times
#
_line () {
	local char=$1

	# Verify command seq
	#
	have seq && {
		seq -s$char $2| sed 's/[0-9]//g'
	} || { _error 'bash: seq: command not found'; _abort_now; }
	# End have seq
}

# repeat char n times
#
repeat () {
	# Verify function _line
	#
	have _line && {
		if test $# -eq 2; then

			local ch=${1:=}
			local  n=${2:-1}
			_line $ch $((n+1))

		else

			local  n=78
			_line ${1:=} $((n+1))
		fi
	} || { _error 'bash: _line: command not found'; _abort_now; }
	# End have _line
}

#
# ---------------------------------- table -----------------------------------
#

_table () {
	# Verify command sed
	#
	have sed && {
		sed "s/\s\+/$1/; s/^.\{$2\}/&:/; s/:=*/$3/; s/=/ /g"
	} || { _error 'bash: sed: command not found'; _abort_now; }
	# End have sed
}

_table_debug () {
	# Verify command sed
	#
	have sed && {
		sed "s/\s\+/$1/; s/^.\{$2\}/&:/; s/:=*/:/;"
	} || { _error 'bash: sed: command not found'; _abort_now; }
	# End have sed
}

_usage_table () {
	# Verify command cat
	#
	have cat && {
		 cat << EOF-USAGE
Usage: `basename "$0"` size position [string]

-h --help     display this help and exit
-d --debug    debug mode

Examples:
cat file | `basename "$0"` 12 20
cat file | `basename "$0"` 9 15 :
echo -e "\n xvxcv\n xcvxcv\n  xvcxc\n  fadf\n  saaaa\n d"|  `basename "$0"`  -d 12 10

Uso: `basename "$0"` [numero de espacos em branco  position] [posicao do :]

Report bugs to "<${_mail}>."
EOF-USAGE
	} || { _error 'bash: cat: command not found'; _abort_now; }
	# End have cat
}

table() {

	[ $# -eq 0 ] && opt='usage';

	[ "$1" = '--help'  -o "$1" = '-h' ]  && opt='usage'
	[ "$1" = '--debug' -o "$1" = '-d' ]  && opt='debug'

	case $opt in
		debug) 	shift;
			_table_debug $(repeat '=' $1) ${2:-1};;

		usage)  _usage_table;
			exit 1;;

		*    ) _table $(repeat '=' $1) ${2:-1} $3
	esac

}
