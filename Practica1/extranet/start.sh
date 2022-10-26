#!/bin/bash
route del default gw 10.5.0.254
route add default gw 10.5.0.1

/usr/sbin/sshd -D