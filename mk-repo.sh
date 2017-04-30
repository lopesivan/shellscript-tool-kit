#! /bin/bash

[ "$1" ] || { echo $0 file.tgz; exit 1; }

    meu_projeto=$1
meu_repositorio=${meu_projeto}-read-only
           _PWD=`pwd`

test -d  /var/lib/svn/$meu_repositorio && sudo rm -rf /var/lib/svn/$meu_repositorio

sudo mkdir -p /var/lib/svn/$meu_repositorio

mkdir -p /tmp/${meu_repositorio}
mkdir -p /tmp/${meu_repositorio}/src
mkdir -p /tmp/${meu_repositorio}/tags
mkdir -p /tmp/${meu_repositorio}/branches
mkdir -p /tmp/${meu_repositorio}/head
mkdir -p /tmp/${meu_repositorio}/trunk

( cd /tmp/${meu_repositorio}/src; tar xvzf $_PWD/${meu_projeto}.tgz )

sudo svnadmin create /var/lib/svn/$meu_repositorio
sudo /etc/init.d/apache2 restart

sudo svn import      /tmp/$meu_repositorio file:///var/lib/svn/$meu_repositorio -m "initial import"
sudo rm -rf          /tmp/$meu_repositorio

sudo chown -R www-data:www-data /var/lib/svn/$meu_repositorio

sudo chmod g+w /var/lib/svn/$meu_repositorio -R

sudo /etc/init.d/apache2 restart

echo https://$( ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1'|head -1 |cut -d: -f2 |awk '{ print $1}' )/svn/$meu_repositorio

exit 0
