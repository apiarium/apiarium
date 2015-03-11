from datetime import datetime
import asyncore
from smtpd import SMTPServer
import threading
import smtplib
import os

class EmlServer (SMTPServer):
    def process_message(self, peer, mailfrom, rcpttos, data):
        pass

def run_helper(fqdn):
    foo = EmlServer((fqdn, 25), None)
    try:
        asyncore.loop()
    except KeyboardInterrupt:
        pass

def run(fqdn):
    t = threading.Thread(target=run_helper, args=(fqdn,))
    t.start()

def readfqdns():
    curpath = os.path.dirname(os.path.realpath(__file__))
    smtplist_path = os.path.join(curpath, 'smtplist.txt')
    f = open(smtplist_path)
    fqdns = f.read().split("\n")
    f.close()
    return fqdns
    
if __name__ == '__main__':
    for fqdn in readfqdns():
        run(fqdn)
