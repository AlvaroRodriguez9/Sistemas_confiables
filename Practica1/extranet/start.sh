#!/bin/bash
# Script que se ejecuta al hacer exec. Contiene la nueva dirección del gateway. 
# Autor: Álvaro Rodríguez Carpintero
route del default gw 10.5.0.254
route add default gw 10.5.0.1


iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -P OUTPUT ACCEPT


service apache2 restart

/usr/sbin/sshd -D