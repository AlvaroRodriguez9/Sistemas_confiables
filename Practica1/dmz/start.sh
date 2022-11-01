#!/bin/bash
route del default gw 10.5.1.254
route add default gw 10.5.1.1

service apache2 restart

/usr/sbin/sshd -D