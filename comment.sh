# !/bin/bash

# ----------------------------------------------------------------------------

# -- box --

# /***************
#  *             *
#  * ----------- *
#  *             *
#  ***************/

# ----------------------------------------------------------------------------

comment.cansi.box()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n &='                    |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/ @\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/ & /;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/.../ @ /'                          \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=*=g'
}

comment.cansi.boxl()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n &='                    |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/ @\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/&  /;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/./ @ /'                            \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=*=g'
}

comment.cansi.boxr()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n &='                    |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/ @\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/  &/;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/....../ @ /'                       \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=*=g'
}

# ----------------------------------------------------------------------------

comment.cpp.box()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n&='                     |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/@@\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/ & /;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/.../@@ /'                          \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=/=g'
}

comment.cpp.boxl()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n&='                     |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/@@\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/&  /;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/./@@ /'                          \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=/=g'
}

comment.cpp.boxr()
{
	file="$*"
	echo |\
	sed   \
	-e a"${file:-x}"                        \
	-e ':b;s/^.\{78\}$/&/;te;s/$/@/;tb;:e'  \
	-e 's=.*=&\n&\n&='                     |\
	sed   \
	-e '1{ s/@/ /g; s/\(.\{75\}\).*/@@\1@/;}' \
	-e '2s=.=/='                              \
	-e '3s=.$=/='                             \
	-e '${s/.*/|&|/}'                         \
	-e 's/ /|/g'                              \
	-e '${:a; s/^.\{1,78\}$/  &/;ta}'         \
	-e '$s/ /-/g'                             \
	-e '$s/...../@@ /'                        \
	-e '$s/\(^.\{76\}\).*/\1 @/'              \
	-e '1h;3H'                                \
	-e '3d'                                   \
	-e '1h;2G'                                \
	-e '$G'                                   \
	-e '1d'                                   \
	-e 's/|/ /g'                              \
	-e 's=@=/=g'
}

# -- Line --

# ----------------------------------------------------------------------------

comment.cansi.line()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/& /;ta; s/.*/\/* &*\//'
# --------------------^ left
}

comment.cansil()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/& /;ta; s/.*/\/* &*\//'
# --------------------^ left
}

comment.cansic()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/ & /;ta; s/.*/\/*&*\//'
# ---------------------^ center
}

comment.cansir()
{
	file="$*"

	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/ &/;ta; s/.*/\/*& *\//'
# ---------------------^ right
}

# ----------------------------------------------------------------------------

comment.cpp.line()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/& /;ta; s/.*/\/\/ & \//'
# --------------------^ left
}

comment.cppl()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/& /;ta; s/.*/\/\/ & \//'
# --------------------^ left
}

comment.cppc()
{
	file="$*"
	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/ & /;ta; s/.*/\/\/& \//'
# ---------------------^ center
}

comment.cppr()
{
	file="$*"

	echo "${file:-x}" |\
    sed                \
	':a;s/^.\{1,73\}$/  &/;ta; s/.*/\/\/& \//'
# ---------------------^ right
}

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
function Example()
{
	case $1 in
		1)
			echo 'echo TEXT TEXT | comment  -tc;';
			echo TEXT TEXT | comment  -tc;
		;;
		2)
			echo 'echo TEXT TEXT | comment  -tc -l';
			echo TEXT TEXT | comment  -tc -l
		;;
		3)
			echo 'echo TEXT TEXT | comment  -tc -r';
			echo TEXT TEXT | comment  -tc -r
		;;
		4)
			echo 'echo TEXT TEXT | comment  -tcpp -l';
			echo TEXT TEXT | comment  -tcpp -l
		;;
		5)
			echo 'echo TEXT TEXT | comment  -tcpp -c';
			echo TEXT TEXT | comment  -tcpp -c
		;;
		6)
			echo 'echo TEXT TEXT | comment  -tcpp -b';
			echo TEXT TEXT | comment  -tcpp -b
		;;
		*)
			echo 'echo  hello! Comment | comment  -tc  -b -l';
			echo  hello! Comment | comment  -tc  -b -l
		;;
	esac
}

function Usage()
{
cat << EOF
	A program to generate nice/simple comment language

	Usage: ${1##*/} [ -e NUMBER | -t{[cpp|c|java|sh]} -[b] -[lr] ]

	Where the options include:
		-t  set language for comment
		-l  generate commnet left
		-r  generate commnet right
		-b  generate commnet box
		-e  show examples

Example:

$ echo   | comment  -tc
/* x                                                                         */

$ echo  hello! Comment | comment  -tc  -b -l
/*****************************************************************************
 *                                                                           *
 * hello! Comment ---------------------------------------------------------- *
 *                                                                           *
 *****************************************************************************/

Edit the generated comment if nedeed.
EOF
}

##############################################################################

box=0; left=0; center=0; right=0
cmd=""

##############################################################################

while getopts e:ct:blr o
	do
	case "$o" in
		e) Example $OPTARG;
		   exit 0
		;;
		t) code=$OPTARG;
		   : ${left:=0};
		   : ${right:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;

		c) center=1;
		   : ${right:=0};
		   : ${left:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;

		l) left=1;
		   : ${right:=0};
		   : ${center:=0};
		   : ${box:=0}
		;;
		r) right=1;
		   : ${center:=0};
		   : ${left:=0};
		   : ${box:=0}
		;;
		b) box=1;
		   : ${left:=0};
		   : ${center:=0};
		   : ${right:=0}
		;;
		?) echo "Usage: ${0##*/} [ -e NUMBER | -t{[cpp|c|java|sh]} -[b] -[lr] ]";
		exit 1;;
	esac
done

#set -x

code_on=0

# cansi
#-----------------------------------------------------------------------------
if [ "$code" = 'c' ]; then

	cmd=comment.cansi
	code_on=1

	if [ $box = 1 ]; then
		flag=1;	cmd=${cmd}.box
	fi

	if [ $left = 1 ]; then
		flag=1;	right=0; cmd=${cmd}l
	fi

	if [ $right = 1 ]; then
		flag=1;	left=0;	cmd=${cmd}r
	fi

	if [ $center = 1 ]; then
		flag=1;	left=0; right=0; cmd=${cmd}c
	fi

	[ "$flag" ] || cmd=${cmd}.line

fi

# cpp
#-----------------------------------------------------------------------------
if [ "$code" = 'cpp' ]; then

	cmd=comment.cpp
	code_on=1

	if [ $box = 1 ]; then
		flag=1;	cmd=${cmd}.box
	fi

	if [ $left = 1 ]; then
		flag=1;	right=0; cmd=${cmd}l
	fi

	if [ $right = 1 ]; then
		flag=1;	left=0;	cmd=${cmd}r
	fi

	if [ $center = 1 ]; then
		flag=1;	left=0; right=0; cmd=${cmd}c
	fi

	[ "$flag" ] || cmd=${cmd}.line

fi

if [ "$code_on" = '1' ]; then

##############################################################################

while read line; do
#	echo :$cmd \"$line\"
	eval $( echo $line | sed "s/.*/'&'/; s/^/$cmd /")
done

##############################################################################
else
	Usage $0
fi
#-----------------------------------------------------------------------------
exit 0
