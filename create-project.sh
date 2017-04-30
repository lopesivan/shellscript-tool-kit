#! /bin/bash

    meu_projeto=$1
meu_repositorio=${meu_projeto}-read-only
           _PWD=`pwd`

_basename=${0##*/}

[ "$1" ] || {
	echo Usage: $_basename '<tar-file-name-whitout-extension>'
	exit 1
}

exit 0
test -d  /var/lib/svn/$meu_repositorio && sudo rm -rf /var/lib/svn/$meu_repositorio

sudo mkdir -p /var/lib/svn/$meu_repositorio

mkdir -p /tmp/${meu_repositorio}
mkdir -p /tmp/${meu_repositorio}/src
mkdir -p /tmp/${meu_repositorio}/tags
mkdir -p /tmp/${meu_repositorio}/trunk
mkdir -p /tmp/${meu_repositorio}/branches
mkdir -p /tmp/${meu_repositorio}/head

( cd /tmp/${meu_repositorio}/src; tar xvzf $_PWD/${meu_projeto}.tgz )

sudo svnadmin create /var/lib/svn/$meu_repositorio
sudo /etc/init.d/apache2 restart

sudo svn import      /tmp/$meu_repositorio file:///var/lib/svn/$meu_repositorio -m "initial import"
sudo rm -rf          /tmp/$meu_repositorio

sudo chown -R www-data:www-data /var/lib/svn/$meu_repositorio

sudo chmod g+w /var/lib/svn/$meu_repositorio -R

echo https://$( ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1'|head -1 |cut -d: -f2 |awk '{ print $1}' )/svn/$meu_repositorio

exit 0

# track
test -d  /var/www/trac/$meu_projeto && sudo rm -rf /var/www/trac/$meu_projeto
sudo mkdir -p /var/www/trac/$meu_projeto

sudo trac-admin /var/www/trac/$meu_projeto initenv

sudo chown -R www-data.svn /var/www/trac/

sudo /etc/init.d/apache2 restart

exit 0
