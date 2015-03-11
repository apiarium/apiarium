#!/usr/bin/env python
import sys
import os
import time

save = False

if len(sys.argv) > 1:
    if sys.argv[1] == '-h' or sys.argv[1] == '--help':
        print "Usage: %s [save]" % (sys.argv[0])
        sys.exit(0)
    elif sys.argv[1] == 'save':
        save = True

BASEDIR = '/mnt/wwwmirror/'

os.chdir(BASEDIR)

with open('/var/log/apache2/access.log','r') as log:
    while True:
        line = log.readline()
        if line == "":
            sys.exit(0)
    
        response = line.split(' ')[8]
        if response == "404":
            print
            path = line.split(' ')[6]
            host = line.split(' ')[10][8:-2]
            url = host+path
            host = url[:url.find('/')]
            path = url[url.find('/'):]
            
            baseHostDir = os.path.join(BASEDIR, host)
            
            if not os.path.exists(baseHostDir):
                # either prepend or remove the 'www' from the front
                if host[:4] == 'www.':
                    baseHostDir = os.path.join(BASEDIR, host[4:])
                    host = host[4:]
                else:
                    baseHostDir = os.path.join(BASEDIR, 'www.'+host)
                    host = 'www.'+host
                if not os.path.exists(baseHostDir):
                    raise Exception("Host does not exist: "+baseHostDir)
            
            print 'host=',host
            print 'path=',path
            
            # find the first '?', cut the rest out, then find the last '/'
            saveDir = baseHostDir+path
            q = saveDir.find('?')
            lastSlash = saveDir[:q].rfind('/')
            filename = saveDir[lastSlash+1:]

            saveDir = saveDir[:lastSlash]
            saveDir = os.path.join(BASEDIR, saveDir)

            print 'dir=',saveDir
            print 'filename=',filename
            if save:
                time.sleep(1)
                wget = "wget --limit-rate=500k --convert-links --no-clobber -p -E -e robots=off -U mozilla http://" + host +path
                os.system(wget)
            


#192.168.1.253 - - [27/Feb/2014:10:27:30 -0600] "GET /e-201409.js HTTP/1.1" 404 506 "http://diberville.ms.us/" "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:27.0) Gecko/20100101 Firefox/27.0"
