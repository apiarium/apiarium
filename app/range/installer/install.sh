#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

echo Copying rc.local into place.
mv /etc/rc.local /etc/rc.local.`date +%s`
cp $DIR/rc.local /etc/rc.local
chmod +x /etc/rc.local

echo Copying setiptables.sh into place.
mv /etc/network-scripts/setiptables.sh /etc/network-scripts/setiptables.sh.`date +%s`
cp $DIR/setiptables.sh /etc/network-scripts/setiptables.sh
chmod +x /etc/network-scripts/setiptables.sh

echo Copying routetheinternet.sh into place.
mv /etc/network-scripts/routetheinternet.sh /etc/network-scripts/routetheinternet.sh.`date +%s`
cp $DIR/routetheinternet.sh /etc/network-scripts/routetheinternet.sh 
chmod +x /etc/network-scripts/routetheinternet.sh

echo Copying fakedns.sh into place.
mv /etc/network-scripts/fakedns.sh /etc/network-scripts/fakedns.sh.`date +%s`
cp $DIR/fakedns.sh /etc/network-scripts/fakedns.sh
chmod +x /etc/network-scripts/fakedns.sh

IP=$(ip a | sed -e '/inet.*eth0/!d;s/.*inet //;s/\/.*//')

echo [range] > range.conf
echo apiarium_server_range_ip=$IP >> range.conf
echo apiarium_server_range_port=9000 >> range.conf
echo internal_port_for_clients=9001 >> range.conf

cp $DIR/range.conf $DIR/../range.conf
