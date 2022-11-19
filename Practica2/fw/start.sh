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

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p udp -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p icmp -j ACCEPT

iptables -t nat -A POSTROUTING -o eth1 -s 10.5.2.0/24 -j SNAT --to 10.5.0.1


iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT


iptables -A FORWARD -o eth0 -d 10.5.1.20 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.5.1.20 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

iptables -A FORWARD -i eth2 -o eth0 -s 10.5.2.20 -p tcp -m tcp --dport 22 -j ACCEPT 
iptables -A FORWARD -i eth0 -o eth2 -d 10.5.2.20 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT


#Para el apartado opcional HTTPS

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -o eth0 -d 10.5.1.20 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.5.1.20 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD ACCEPT

iptables -P OUTPUT ACCEPT

/usr/sbin/sshd -D