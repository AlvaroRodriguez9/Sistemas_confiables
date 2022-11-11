#!/bin/bash
#Activacion bit forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

#Trafico entrante por la interfaz de loopback
iptables -A INPUT -i lo -j ACCEPT
#Permitir el trafico entrante correspondiente a cualquier conexion previamente establecida. 
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT

#Permitir consultas entrantes de tipo ICMP ECHO REQUEST.
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT


#Todo el trafico de conexiones establecidas o relacionadas para los protocolos TCP, UDP e ICMP.
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

#Todo el trafico que entre en fw a traves de la interfaz con la red interna, con protocolo TCP, UDP o
#ICMP, con direccion IP origen en el rango 10.5.20.0/24, y que vaya a salir a traves de la interfaz con la
#red externa.
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p icmp --icmp-type echo-reply -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 22 -j ACCEPT 
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p udp -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p icmp -j ACCEPT

#Todos los paquetes que abandonen fw por la interfaz externa y que provengan de la red interna (10.5.2.0/24)
#deben cambiar su IP de origen para que sea la de fw en esa interfaz (10.5.0.1).
iptables -t nat -A POSTROUTING -o eth1 -s 10.5.2.0/24 -j SNAT --to 10.5.0.1

#Acceso TCP desde cualquier m ́aquina (interna o externa) a la m ́aquina dmz1 (IP 10.5.1.20), exclusivamente
#al servicio HTTP (puerto 80).
iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT


iptables -A FORWARD -o eth0 -d 10.5.1.20 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.5.1.20 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

#Acceso SSH desde int1 (10.5.2.20) a dmz1
iptables -A FORWARD -i eth2 -o eth0 -s 10.5.2.20 -p tcp -m tcp --dport 22 -j ACCEPT 
iptables -A FORWARD -i eth0 -o eth2 -d 10.5.2.20 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT


#HTTPS puerto 443

iptables -A FORWARD -i eth2 -o eth1 -s 10.5.2.0/24 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -d 10.5.2.0/24 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -o eth0 -d 10.5.1.20 -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.5.1.20 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

#Politica por defecto de entrada DROP
iptables -P INPUT DROP
#Politica por defecto de forward DROP
iptables -P FORWARD DROP
#Politica por defecto de salida ACCEPT
iptables -P OUTPUT ACCEPT

/usr/sbin/sshd -D