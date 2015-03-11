#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

echo Restoring rc.local.
#echo exit 0 > /etc/rc.local
#rm /etc/rc.local.*

echo Removing setiptables.sh.
rm /etc/network-scripts/setiptables.sh
rm /etc/network-scripts/setiptables.sh.*

echo Removing routetheinternet.sh.
rm /etc/network-scripts/routetheinternet.sh
rm /etc/network-scripts/routetheinternet.sh.*

echo Removing fakedns.sh.
rm /etc/network-scripts/fakedns.sh
rm /etc/network-scripts/fakedns.sh.*

