#!/bin/bash
# ----------------------------------------------------------------------------
__debug__=0; __help__=0
__usage__=0
__clean__=0
# ----------------------------------------------------------------------------
[ "$1" = '-h'      ] && { __help__=1; shift;  }
[ "$1" = '--help'  ] && { __help__=1; shift;  }
[ "$1" = '-d'      ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--usage' ] && { __usage__=1; shift; }
[ "$1" = '--clean' ] && { __clean__=1; shift; }
# ----------------------------------------------------------------------------

_usage() {
cat << EOF
Usage:
	`basename $0` [svn|git] project_name

Examples:
	`basename $0` svn project_name.tgz
	`basename $0` svn dir_name

	`basename $0` git server project_name
	`basename $0` git host project_name
EOF
exit 1
}

[ "$1" ] || { _usage; }
[ "$2" ] || { _usage; }

##############################################################################
##############################################################################
##############################################################################

# vi:set nu nowrap:
# repo-new.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: repo-new.sh
#        Date: Qui 18 Nov 2010 07:52:55 BRST
# Description:
#
#
do_svn() {

	if ls -l $1 | grep '^-' ;
	then # is a file
		ext=${1##*.}

		[ "$ext" = 'tgz' ] && {
			name=${1%.tgz}
		} || 
		{
			echo Usage: `basename $0` svn file.tgz
			exit 1
		}

	else # is a dir
		test -d $1 && {
			tar cvzf $1.tgz $1
			name=$1
		} || 
		{
			echo Usage: `basename $0` svn dir
			exit 1
		}
	fi

	project_name=$name
	my_repositorie=${project_name}
    _PWD=`pwd`

	test -d /var/lib/svn/$my_repositorie &&
		sudo rm -rf /var/lib/svn/$my_repositorie

	sudo mkdir -p /var/lib/svn/$my_repositorie

	mkdir -p /tmp/${my_repositorie}
	mkdir -p /tmp/${my_repositorie}/src
	mkdir -p /tmp/${my_repositorie}/tags
	mkdir -p /tmp/${my_repositorie}/branches
	mkdir -p /tmp/${my_repositorie}/head
	mkdir -p /tmp/${my_repositorie}/trunk

	(
		cd /tmp/${my_repositorie}/src;
		tar xvzf $_PWD/${project_name}.tgz
	)

	sudo svnadmin create /var/lib/svn/$my_repositorie
	sudo svn import /tmp/$my_repositorie file:///var/lib/svn/$my_repositorie -m "initial import"
	sudo rm -rf     /tmp/$my_repositorie

	sudo find /var/lib/svn/$my_repositorie -type f -exec chmod 660 {} \;
 	sudo find /var/lib/svn/$my_repositorie -type d -exec chmod 2770 {} \;
	sudo chown -R root.www-data /var/lib/svn/$my_repositorie
#	sudo chown -R www-data:www-data /var/lib/svn/$my_repositorie

	sudo /etc/init.d/apache2 restart
	echo https://$( ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1'|head -1 |cut -d: -f2 |awk '{ print $1}' )/svn/$my_repositorie

}

do_git() {

	repo=$2
	case $1 in
	'server')
		echo '=*=' $repo '=*='
		$ECHO sudo su -c " repo=$1; cd /home/git/repositories; mkdir ${repo}.git; cd ${repo}.git; git --bare init" git
	;;

	'host')
		echo '=*=' $repo '=*='
		$ECHO mkdir $repo && $ECHO cd $repo
		$ECHO git init
		[ "$ECHO" ] && \
			$ECHO echo "Inicializando o repositório $repo  > readme" ||
			$ECHO echo "Inicializando o repositório $repo" > readme
		$ECHO git add .
		$ECHO git commit -m "inicializando $repo"
		$ECHO git remote add origin git@mygit:repositories/${repo}.git
		$ECHO git push origin master
		;;

	*)
		echo
			echo Usage: `basename $0` git [server| host] project_name
			exit 1
		;;
	esac
}

# ----------------------------------------------------------------------------
case $1 in

git)
echo git

	[ "$3" ] || { _usage; }

	do_git $2 $3
;;

svn)
echo svn
	do_svn $2
;;

esac

# ----------------------------------------------------------------------------
exit 0
