#!/bin/bash
route del default gw 10.5.1.254
route add default gw 10.5.1.1

iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222

/usr/sbin/sshd -D