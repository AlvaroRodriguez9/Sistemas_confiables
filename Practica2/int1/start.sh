#!/bin/bash
# Script que se ejecuta al hacer exec. Contiene la nueva dirección del gateway. 
# Autor: Álvaro Rodríguez Carpintero
route del default gw 10.5.2.254
route add default gw 10.5.2.1


/usr/sbin/sshd -D