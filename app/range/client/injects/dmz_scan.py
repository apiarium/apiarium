import os
import time
import sys

class dmz_scan():
    def __init__(self):
        self.variables = {'src_ip': ''}
        self.name = "NMAP DMZ"
        self.description = "An inject to scan the dmz."
        self.subnet = '172.16.90.0/24'

    def range(self, **kwargs):
        src_ip = kwargs['src_ip']
        iface = 'eth2'
        cmd = "nmap -S {} -e {} {}".format(src_ip, iface, self.subnet)
        while True:
            os.system(cmd)
            time.sleep(1)

    def run(self, **kwargs):
        self.range(**kwargs)
