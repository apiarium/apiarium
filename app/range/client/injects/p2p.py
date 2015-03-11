import socket
import sys
import time
import random

class p2p():
    def __init__(self):
        self.variables = {'src_ws': '', 'src_ip': ''}
        self.name = "P2P Exfiltration"
        self.description = "An inject to exfiltrate a file over a peer-to-peer network"

    def client(self, **kwargs):
        # Try to connect to anything anywhere on ports 6346 and 6348
        ip = kwargs['src_ip']
        while True:
            try:
                s0 = socket.socket()
                s0.connect((ip, 6346))
                s0.close()
                s1 = socket.socket()
                s1.connect((ip, 6347))
                s1.close()
                s2 = socket.socket()
                s2.connect((ip, 6348))
                s2.close()
            except:
                pass
            time.sleep(random.randint(1,10))

    def run(self, **kwargs):
        self.client(**kwargs)

if __name__ == '__main__':
    import base64
    import json
    args = json.loads(base64.urlsafe_b64decode(sys.argv[1]))
    p2p().run(**args)
