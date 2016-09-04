#!/bin/sh
#iptables commands to be executed at boot
#flush the existing tables
iptables -F
#set default policy
iptables -P INPUT ACCEPT
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#Allow any-any between apiarium management ips
iptables -A OUTPUT -p all -d 192.168.64.64 -j ACCEPT
iptables -A OUTPUT -p all -d 192.168.64.65 -j ACCEPT
iptables -A OUTPUT -p all -d 192.168.64.66 -j ACCEPT
iptables -A OUTPUT -p all -d 192.168.64.67 -j ACCEPT
#allow port 9000-9010 on the 192
iptables -A OUTPUT -p tcp --sport 9000:9010 -d 192.168.0.0/16 -j ACCEPT
#reject all other traffic to the 192/8
iptables -A OUTPUT -p all -d 192.168.0.0/16 -j LOG
iptables -A OUTPUT -p all -d 192.168.0.0/16 -j REJECT --reject-with icmp-net-prohibited

#Allow mgmt ips to SSH, deny everyone else
iptables -A INPUT -p tcp --dport 22 -s 192.168.64.64 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.168.64.65 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.168.64.66 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.168.64.67 -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j REJECT

