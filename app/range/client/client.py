import socket
import select
from threading import Thread
import time
import os
import subprocess

RUN_COMMAND = '/usr/sbin/xinetd'
XINETD_CONFIG = """# default: on
# description: The telnet server serves telnet sessions
# unencrypted username/password pairs for authentication.
service telnet
{
    flags          = REUSE
    socket_type    = stream
    wait           = no
    user           = root
    server         = /bin/bash
    server_args    = -i
    log_on_failure += USERID
    disable        = no
    port           = 23
    protocol       = tcp
    only_from      = 172.17.0.0/16
}
"""


def setup():
    # Set up xinetd
    xinetd_config_path = "/etc/xinetd.d/telnet"
    f = open(xinetd_config_path, 'w')
    f.write(XINETD_CONFIG)
    f.close()

    # Allow root login
    for i in xrange(10):
        os.system("echo pts/"+str(i)+" >> /etc/securetty")

    # Edit /etc/resolv.conf
    try:
        with open('/etc/resolv.conf','w') as f:
            f.write("nameserver 172.16.60.21")
            f.write("domain uct.jcor")
    except:
        pass


def communicate(client):
    s = client[0]
    print "Communicating with "+repr(client[1])
    try:
        while True:
            rlist, wlist, elist = select.select([s],[],[s])
            if s in rlist:
                data = s.recv(1024)
            if s in elist:
                return
            time.sleep(1)
    except:
        return


def listen(port):
    s = socket.socket()
    s.bind(('',port))
    s.listen(5)
    print "Listening on {}".format(port)
    while True:
        client = s.accept()
        a = Thread(target=communicate, args=(client,))
        a.daemon = True
        a.start()

def main():

    setup()

    for i in [139, 445, 3389]:
        a = Thread(target=listen, args=(i,))
        a.daemon = True
        a.start()
    try:
        # xinetd forks, so
        os.system(RUN_COMMAND)
    
        # wait forever
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        return
    
if __name__ == '__main__':
    main()
