#!/bin/sh
#add route for the 172.16/16 network

ip route add to 172.16.0.0/16 via 172.16.100.2 dev eth1

