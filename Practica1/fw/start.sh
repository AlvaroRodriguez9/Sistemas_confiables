#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -A INPUT -i lo -j ACCEPT
 
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT

iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT



iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p icmp --icmp-type echo-reply -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 22 -j ACCEPT 
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT



iptables -P INPUT DROP
iptables -P FORWARD DROP

iptables -P OUTPUT ACCEPT

/usr/sbin/sshd -D