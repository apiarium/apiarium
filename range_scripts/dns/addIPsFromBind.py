import re
import sys
import os
import glob
import subprocess
import errno

dev = 'eth2'

def getIPsFromFile(zone):
    contents = ""
    with open(zone, 'r') as zf:
        contents = zf.read()
    ipRE = "(?:[0-9]{1,3}\.){3}[0-9]{1,3} "
    return [a[:-1] for a in re.findall(ipRE, contents)]

def getAllIPsFromZones():
    IPs = set()
    for zone in glob.glob("/etc/bind/zones/*"):
        if zone[-4:] != ".bak":
            for ip in getIPsFromFile(zone):
                IPs.add(ip)
    return IPs

def bind():
    for i, ip in enumerate(getAllIPsFromZones()):
        subprocess.call('/sbin/ip a add {}/32 dev {} label {}:{}'.format(
            ip, dev, dev, i).split(' '))
        subprocess.call('/sbin/ip r add {}/32 dev {}:{}'.format(
            ip, dev, i).split(' '))

def remove():
    for i, ip in enumerate(getAllIPsFromZones()):
        subprocess.call('/sbin/ip a del {}/32 dev {}'.format(
            ip, dev).split(' '))

if __name__ == "__main__":
    if os.geteuid() != 0:
        print "You need root permissions to do this."
        sys.exit(1)
    if sys.argv[1] == 'add':
        bind()
    else:
        remove()
