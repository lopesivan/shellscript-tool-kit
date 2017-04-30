#! /bin/bash

sudo mkdir /var/swap_area
sudo dd if=/dev/zero of=/var/swap_area/swap bs=1024 count=1000000

echo Verificando...

ls -lh /var/swap_area

echo Dizendo para o sistema operacional usar o arquivo como swap:

sudo mkswap -f /var/swap_area/swap

echo Ativando:

sudo swapon /var/swap_area/swap

echo Tudo pronto! Confira:

free -m
