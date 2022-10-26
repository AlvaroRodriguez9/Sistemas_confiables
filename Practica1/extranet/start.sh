#!/bin/bash
route del default gw 10.5.0.254
route add default gw 10.5.0.1

ifconfig eth0 10.5.0.20 netmask 255.255.255.0

/usr/sbin/sshd -D