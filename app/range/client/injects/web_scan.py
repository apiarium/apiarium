import os
import time
import sys

class web_scan():
    def __init__(self):
        self.variables = {'src_ip': ''}

        self.name = "NMAP WWW"
        self.description = "An inject to scan the www."
        self.domain = 'www.uct.jcor'

    def range(self, **kwargs):
        iface = 'eth2'
        src_ip = kwargs['src_ip']
        cmd = "nmap -S {} -e {} {}".format(src_ip, iface, self.domain)
        while True:
            os.system(cmd)
            time.sleep(1)

    def run(self,**kwargs):
        self.range(**kwargs)

#print getattr(dmz_scan(), 'range', False)
#print vars(dmz_scan())
