#!/bin/bash
route del default gw 10.5.2.254
route add default gw 10.5.2.1


/usr/sbin/sshd -D