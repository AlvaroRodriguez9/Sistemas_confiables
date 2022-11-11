#!/bin/bash
# Script que se ejecuta al hacer exec. Contiene la nueva dirección del gateway. También reinicia apache2
# Autor: Álvaro Rodríguez Carpintero
route del default gw 10.5.1.254
route add default gw 10.5.1.1

service apache2 restart

/usr/sbin/sshd -D