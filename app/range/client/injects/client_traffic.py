import base64
import os
import ConfigParser
import ftplib
import random
import smtplib
import StringIO
import sys
import threading
import time
import urllib
import urllib2
from collections import OrderedDict
        

class client_traffic():
    def __init__(self):
        self.name = "Traffic Generator - Workstations"
        self.description = "This will create a random stream of traffic from the workstations."
        self.variables = {'intensity_SLIDER': '50'}

    def client(self, **kwargs):
        # Class for reading the configuration
        class MultiOrderedDict(OrderedDict):
            def __setitem__(self, key, value):
                if isinstance(value, list) and key in self:
                    self[key].extend(value)
                else:
                    super(OrderedDict, self).__setitem__(key, value)

        class wwwclient(threading.Thread):
            def __init__(self, verbose=False):
                threading.Thread.__init__(self)
                self.websites = []
                sites = config.get("www",  "sites")
                for website in sites:
                    if not 'http://' in website or not 'https://' in website:
                        self.websites.append('http://'+website)
                if verbose:
                    print "WWW:"
                    print 'websites:',self.websites

            def run(self):
                url = random.choice(self.websites)
                response = urllib2.urlopen(url)
                html = response.read()
                print("Got {} bytes from {}.".format(len(html), url))

        class smtpclient(threading.Thread):
            def __init__(self, verbose=False):
                threading.Thread.__init__(self)
                self.strict = (lambda x: x in ('True', 'true'))(config.get('smtp', 'strict_ordering')[0])
                self.servers = config.get("smtp",  "servers")
                self.fromEmails = config.get("smtp", "from")
                self.toEmails = config.get("smtp", "to")
                self.subject = config.get("smtp", "subject")
                self.body = config.get("smtp", "body")
                if verbose:
                    print "SMTP:"
                    print 'servers',self.servers
                    print 'from',self.fromEmails
                    print 'to',self.toEmails
                    print 'subject',self.subject
                    print 'body',self.body
                    print 'ordered',self.strict
                if self.strict:
                    l = len(self.servers)
                    if l != len(self.fromEmails) or l != len(self.toEmails) or l != len(self.subject) or l != len(self.body):
                        print "In order to use strict ordering, all settings must have the same number of options!"
                        sys.exit(1)

            def run(self):
                server = None
                emailFrom = None
                emailTo = None
                body = None
                if not self.strict:
                    server = random.choice(self.servers)
                    emailFrom = random.choice(self.fromEmails)
                    emailTo = random.choice(self.toEmails)
                    body = random.choice(self.body)
                else:
                    l = len(self.servers)
                    choice = random.randint(0,l-1)
                    server = self.servers[choice]
                    emailFrom = self.fromEmails[choice]
                    emailTo = self.toEmails[choice]
                    body = self.body[choice]
                smtpConn = smtplib.SMTP(server)
                smtpConn.sendmail(emailFrom, emailTo, body)
                smtpConn.quit()

        class ftpclient(threading.Thread):
            def __init__(self, verbose=False):
                threading.Thread.__init__(self)
                self.strict = (lambda x: x in ('True', 'true'))(config.get('ftp', 'strict_ordering')[0])
                self.sites = config.get("ftp",  "site")
                self.uploadFiles = config.get("ftp",  "uploadfile")
                self.downloadFiles = config.get("ftp",  "downloadfile")
                self.usernames = config.get("ftp",  "username")
                self.passwords = config.get("ftp",  "password")

                if verbose:
                    print "FTP:"
                    print 'site',self.sites
                    print 'file upload',self.uploadFiles
                    print 'file download',self.downloadFiles
                    print 'username',self.usernames
                    print 'password',self.passwords
                    print 'ordered',self.strict
                if self.strict:
                    l = len(self.sites)
                    if l != len(self.uploadFiles) or l != len(self.downloadFiles) or l != len(self.usernames) or l != len(self.passwords):
                        print "In order to use strict ordering, all settings must have the same number of options!"
                        sys.exit(1)

            def run(self):
                site = ""
                username = ""
                password = ""
                uploadFile = ""
                downloadFile = ""
                upload = random.choice([True,False])
                if not self.strict:
                    site = random.choice(self.sites)
                    username = random.choice(self.usernames)
                    password = random.choice(self.passwords)
                    uploadFile = random.choice(self.uploadFiles)
                    downloadFile = random.choice(self.downloadFiles)
                else:
                    l = len(self.sites)
                    choice = random.randint(0,l-1)
                    site = self.sites[choice]
                    username = self.usernames[choice]
                    password = self.passwords[choice]
                    uploadFile = self.uploadFiles[choice]
                    downloadFile = self.downloadFiles[choice]
                if upload:
                    session = ftplib.FTP(site,username,password)
                    fname = uploadFile
                    f = open(fname,'rb')            # file to send
                    session.storbinary('STOR '+fname, f)    # send the file
                    f.close()                   # close file and FTP
                    session.quit()
                    print "Uploaded {} to {}".format(fname,site)
                else:
                    # download
                    resp = urllib2.urlopen('ftp://'+site+'/'+downloadFile)
                    data = resp.read()
                    print "Got {} bytes from {}".format(len(data),'ftp://'+site+'/'+downloadFile)
        
        intensity = 50
        if 'intensity_SLIDER' in kwargs:
            intensity = (-1/8)*int(kwargs['intensity_SLIDER'])+12
            if intensity < 0:
                intensity = 0

        cur_path = os.path.dirname(os.path.realpath(__file__))
        conf_path = os.path.join(cur_path, 'tgen.conf')
        CONFIGURATION_STRING = ''
        with open(conf_path,'r') as f:
            CONFIGURATION_STRING = f.read()
        
        config = ConfigParser.ConfigParser(dict_type=MultiOrderedDict)
        input_str = StringIO.StringIO()
        input_str.write(CONFIGURATION_STRING)
        input_str.seek(0,0)
        config.readfp(input_str)

        while True:
            # Create a random class to use
            traffic = random.choice([wwwclient, ftpclient, smtpclient])() 
            print "Starting {}".format(type(traffic))
            traffic.daemon = True
            traffic.start()
            traffic.join()

            time.sleep(random.randint(0,intensity))
        return

    def run(self, **kwargs):
        self.client(**kwargs)


if __name__ == '__main__':
    import base64
    import json
    args = json.loads(base64.urlsafe_b64decode(sys.argv[1]))
    client_traffic().run(**args)
