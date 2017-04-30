#! /bin/bash

    meu_projeto=$1
meu_repositorio=${meu_projeto}
           _PWD=`pwd`

sudo svnadmin create /var/lib/svn/$meu_repositorio
sudo /etc/init.d/apache2 restart

sudo svn import  $meu_repositorio file:///var/lib/svn/$meu_repositorio -m "initial import"

sudo chown -R www-data:www-data /var/lib/svn/$meu_repositorio

sudo chmod g+w /var/lib/svn/$meu_repositorio -R

sudo /etc/init.d/apache2 restart

echo https://$( ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1'|head -1 |cut -d: -f2 |awk '{ print $1}' )/svn/$meu_repositorio

exit 0
