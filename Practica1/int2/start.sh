#!/bin/bash
route del default gw 10.5.2.254
route add default gw 10.5.2.1

ifconfig eth0 10.5.2.21 netmask 255.255.255.0

/usr/sbin/sshd -D