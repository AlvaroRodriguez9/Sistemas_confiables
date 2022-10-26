#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -i eth0 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp -m multiport --dports 22,80,443 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth1 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth1 -p tcp -m multiport --dports 22,80,443 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth2 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth2 -p tcp -m multiport --dports 22,80,443 -m state --state ESTABLISHED -j ACCEPT

iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP

iptables -P OUTPUT ACCEPT

/usr/sbin/sshd -D