#!/usr/bin/env python

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Author: 2d Lt Nathan Hart
# Date updated: 19 Feb 2014
#
# IF YOU CHOOSE TO WORK ON THIS CODE,
# YOU WILL NOT USE TABS TO INDENT. YOU WILL USE 4 SPACES TO INDENT.
# FAILURE TO COMPLY WILL RESULT IN DETRIMENTAL EFFECTS.
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##################
# Global modules #
##################
import base64
import BaseHTTPServer
import collections
import ConfigParser
import Cookie
import copy
import cPickle as pickle
import inspect
import json
import mimetypes
import os
import pty
import Queue
import random
import re
import select
import signal
import socket
import ssl
import struct
import sys
import threading
import time
import traceback
import urllib
import uuid
from pdb import set_trace as _DEBUG_BREAK
from SocketServer import ForkingMixIn, ThreadingMixIn
from urlparse import urlparse

##################
# Custom modules #
##################
from app import main

WEBROOT_DEFAULT_PAGE = 'index.html'
""" The website's default page to send when '/' is requested. """

BASIC_AUTH_PASSWORD = 'admin'
""" The website's default basic auth password. """

BASIC_AUTH_USERNAME = 'password'
""" The website's default basic auth username. """

INJECTS_DIR="./injects"
"""Global var for injects dir, set in web.conf"""

SESSIONS = list()
""" The website's sessions. Note: it holds sessions indefinitely as of right now, so guessing one might be easier than it should be. """

AUTHSTRING = str()
""" The website's basic auth authstring. This is basically the base64 encoding of the basic auth username and password concatenated together. """

c2Servers = list()
""" The global variable to store the c2Servers. This is accessible from any thread in the server. """

threads = list()
""" A list of all of the created threads. """

threadLock = main.ReadWriteLock()
""" A lock to be acquired during thread list operations, because Elliot wanted it """

Payload_IP_Ranges = ""
PC_IP_Ranges = ""
IPs_Per_Range = ""

def ip2int(addr):
    return struct.unpack("!I", socket.inet_aton(addr))[0]

def in2ip(addr):
    return socket.inet_ntoa(struct.pack("!I", addr))

def getRandomIPs(ipString,numIPs):
    ips = list()
    need = int(numIPs)

    ranges = ipString.split(',')

    while len(ips) != need:
        if len(ranges) == 0:
            break
        ipString = random.choice(ranges)

        mask = int(ipString.split('/')[1])
        if mask == 32:
            return [ipString.split('/')[0]]
        if mask == 0:
            return []
        subnet = ipString.split('/')[0]

        magic_num = (2**(32 - mask))
        
        iSubnet = ip2int(subnet)
        start = iSubnet + 1
        end = iSubnet + magic_num - 1

        max_avail = start - end
        
        tmp = random.randint(start,end)
        tmp = in2ip(tmp)
        if tmp not in ips:
            ips.append(tmp)

    return ips

def loadWebC2Config(conf):
    """ Loads the webC2 configuration file into objects. This will add each rangeC2 server's info into the c2Servers global variable.
    
    The configuration file must have a [webC2] section that contains the variables of basic_auth_password, basic_auth_username, webserver_port,
    webserver_hostname, inject_port_start, webroot, and default_web_page.
    Every other section will define a new rangeC2 server, with the variables of c2_if, c2_ext_ip, c2_int_ip, and payload_ip_range. """
    
    global BASIC_AUTH_PASSWORD, BASIC_AUTH_USERNAME, PORT_NUMBER, INJECT_PORT_START, WEBROOT, WEBROOT_DEFAULT_PAGE, HOST_NAME, TEMPLATE_DIR, INJECTS_DIR

    BASIC_AUTH_PASSWORD = conf['basic_auth_password']
    BASIC_AUTH_USERNAME = conf['basic_auth_username']
    PC_IP_Ranges = conf['pc_ips']
    IPs_Per_Range = int(conf['num_pc_ips'])
    pc_ips = getRandomIPs(PC_IP_Ranges,IPs_Per_Range) 
    Payload_IP_Ranges = [ip.strip() for ip in conf['malicious_ips'].split(',')] + pc_ips

    ips = [i.strip() for i in conf['range_ips'].split(',')]
    names = [i.strip() for i in conf['range_names'].split(',')]

    if len(ips) != len(names):
        raise Exception("Error with configuration! range_ips and range_names are not the same length!")

    for i in xrange(len(ips)):
        cc2 = main.C2()
        cc2.rangeName = names[i]
        cc2.c2ExternalIP = ips[i]
        cc2.c2ExternalPort = 9013
        cc2.c2Interface = conf['range_apiarium_inet_interface']
        cc2.clientInterface = conf['range_apiarium_core_sw_interface']
        cc2.c2IPPool = Payload_IP_Ranges
        c2Servers.append(cc2)

class WebC2(threading.Thread):
    """
    This class is the main C2 server in the 3-part tree structure.
    It inherits from ``threading.Thread``.
    It is issued commands by the webserver by placing items in the queue
    structure located here.
    """

    def __init__(self, c2):
        threading.Thread.__init__(self)
        self.daemon = True
        self.c2 = c2
        self.queue = Queue.Queue()
        self.SSLSock = None
        self.stop = False
        self.connected = False
        self.reThread = False

    def terminate(self):
        """ Stops the thread from continuing execution. No return value. """
        self.stop = True

    def restartThread(self, msg):
        self.c2.state = main.States.UNKNOWN
        self.c2.errorString = msg
        self.reThread = True

    def recvObject(self):
        """ Receives a pickled object on the SSL connection, and returns the unpickled object, or False if an error occurs. """
        try:
            size = self.SSLSock.recv(4)
            size = struct.unpack("<I", size)[0]
            data = self.SSLSock.recv(size)
            while len(data) < size:
                data += self.SSLSock.recv(size-len(data))
            data = pickle.loads(data)
            return data
        except:
            return False

    def sendObject(self, obj):
        """ Sends a pickled version of the input. Returns false if an Error is encountered. """
        try:
            data = pickle.dumps(obj)
            size = struct.pack("<I", len(data))
            self.SSLSock.sendall(size)
            self.SSLSock.sendall(data)
        except:
            return False

    def commandToCommandWithInject(self,command):
        """ Fills out the main.Inject completely from an incomplete main.Inject with a target and a list of arguments. """
        global INJECT_PORT_START
        
        # Set up the new inject properly
        newCmd = main.Inject()
        newCmd.id = str(uuid.uuid4())
        newCmd.humanName = command.args[0]
        newCmd.target = command.target
        
        # Find the module based on the name
        module = main.moduleFromInject(newCmd)
        if module == None:
            self.c2.errorString = 'Module "{}" not found'.format(command.moduleFile.name)
            main.debug("ExecuteInject: {}".format(self.c2.errorString),"red")
            return
        newCmd.moduleFile.name = module.__module__.split('.',1)[-1]

        WEBC2_IP = self.SSLSock.getsockname()[0]
        WEBC2_PORT = 0 #INJECT_PORT_START
        ####rsr: per requirements, Malicious IP addrs should not be randomly selected###        
        #RANGEC2_MALICOUS_IP = random.choice(self.c2.c2IPPool)
        RANGEC2_MALICIOUS_IP = "0.0.0.0"
        RANGEC2_PORT = 0 #INJECT_PORT_START
        INJECT_PORT_START += 1
        ###Find the first instance of a MALICIOUS_IP, assign it to RANGEC2_MALICIOUS_IP for anythin
        ###    else that might need it

        ##find the correct index of a defined RANGEC2_MALICIOUS_IP if it exists, 
        ##only count non-tuples and (foo, !None)

        ##for range only injects, the target contains the malicious ip
        if module.isRangeOnly():
            RANGEC2_MALICIOUS_IP = command.target.split('.',1)[1]

        if RANGEC2_MALICIOUS_IP == "0.0.0.0":
            index = 0
            for a in module.getWebC2Arguments():
                if type(a) != type(tuple()):
                    index += 1
                elif a[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    RANGEC2_MALICIOUS_IP = command.args[1][index]
                    break
                elif a[0] != C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    index += 1
        if RANGEC2_MALICIOUS_IP == "0.0.0.0":
            index = 0
            for a in module.getRangeC2Arguments():    
                if type(a) != type(tuple()):
                    index += 1
                elif a[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    RANGEC2_MALICIOUS_IP = command.args[2][index]
                    break
                elif a[0] != C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    index += 1
        if RANGEC2_MALICIOUS_IP == "0.0.0.0":
            index = 0
            for a in module.getClientArguments():
                if type(a) != type(tuple()):
                    index += 1
                elif a[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    RANGEC2_MALICIOUS_IP = command.args[3][index]
                    break
                elif a[0] != C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP and a[1] != None:
                    index += 1

        #
        # The following monsterous lines look at all of the arguments and test if they're a C2Module.ArgType tuple.
        # If so, it will be replaced with the requested information.
        #
        variableWebC2Args = [a for a in module.getWebC2Arguments() if type(a) == type(tuple()) and a[1] == None]
        for each in variableWebC2Args:
            #if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP:
            #    newCmd.webC2Inject.args.append(RANGEC2_MALICIOUS_IP)
            if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_PORT:
                newCmd.webC2Inject.args.append(RANGEC2_PORT)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_IP:
                newCmd.webC2Inject.args.append(WEBC2_IP)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_PORT:
                newCmd.webC2Inject.args.append(WEBC2_PORT)
        newCmd.webC2Inject.args += command.args[1]

        variableRangeC2Args = [a for a in module.getRangeC2Arguments() if type(a) == type(tuple()) and a[1] == None]
        for each in variableRangeC2Args:
            #if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP:
            #    newCmd.rangeC2Inject.args.append(RANGEC2_MALICIOUS_IP)
            if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_PORT:
                newCmd.rangeC2Inject.args.append(RANGEC2_PORT)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_IP:
                newCmd.rangeC2Inject.args.append(WEBC2_IP)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_PORT:
                newCmd.rangeC2Inject.args.append(WEBC2_PORT)
        newCmd.rangeC2Inject.args += command.args[2]

        variableClientArgs = [a for a in module.getClientArguments() if type(a) == type(tuple()) and a[1] == None]
        for each in variableClientArgs:
            #if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_IP:
            #    newCmd.clientInject.args.append(RANGEC2_MALICIOUS_IP)
            if each[0] == C2Module.C2Module.ArgTypes.RANGEC2_MALICIOUS_PORT:
                newCmd.clientInject.args.append(RANGEC2_PORT)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_IP:
                newCmd.clientInject.args.append(WEBC2_IP)
            elif each[0] == C2Module.C2Module.ArgTypes.WEBC2_PORT:
                newCmd.clientInject.args.append(WEBC2_PORT)
        newCmd.clientInject.args += command.args[3]
    
        #check if any args require duplicating; should only be used once per inject
        for each in variableWebC2Args:
            if each[0] == C2Module.C2Module.ArgTypes.DUP_RANGEC2_ARGS:
                newCmd.webC2Inject.args += newCmd.rangeC2Inject.args
            elif each[0] == C2Module.C2Module.ArgTypes.DUP_CLIENT_ARGS:
                newCmd.webC2Inject.args += newCmd.clientInject.args

        for each in variableRangeC2Args:
            if each[0] == C2Module.C2Module.ArgTypes.DUP_WEBC2_ARGS:
                newCmd.rangeC2Inject.args += newCmd.webC2Inject.args
            elif each[0] == C2Module.C2Module.ArgTypes.DUP_CLIENT_ARGS:
                newCmd.rangeC2Inject.args += newCmd.rangeC2inject.args

        for each in variableClientArgs:
            if each[0] == C2Module.C2Module.ArgTypes.DUP_WEBC2_ARGS:
                newCmd.clientInject.args += newCmd.webC2Inject.args
            if each[0] == C2Module.C2Module.ArgTypes.DUP_RANGEC2_ARGS:
                newCmd.clientInject.args += newCmd.rangeC2Inject.args

        #all client args need to be string (for subprocess.popen() to work)
        newCmd.clientInject.args = [str(arg) for arg in newCmd.clientInject.args]

        main.debug("WebC2 args: {}".format(newCmd.webC2Inject.args),"light_blue")
        main.debug("RangeC2 args: {}".format(newCmd.rangeC2Inject.args),"light_blue")
        main.debug("Client args: {}".format(newCmd.clientInject.args),"light_blue")

        # Get the file contents and place it into ModuleFile
        # Get the pyc file contents
        filename = inspect.getabsfile(sys.modules[module.__module__])
        contents = ''
        try:
            f = open(filename+'c','rb')
            contents = f.read()
            f.close()
        except IOError:
            try:
                f = open(filename,'rb')
                contents = f.read()
                f.close()
            except:
                pass
        if contents == '':
            raise Exception("Could not get source for inject: {}".format(newCmd.moduleFile.name))

        newCmd.moduleFile.contents = contents

        return newCmd,module

    def executeInject(self,command):
        """ THIS SHOULD NEVER HAPPEN """
        # Filter the incoming command to fit a better structure
        command, injectInstance = self.commandToCommandWithInject(command)

        return command
    
    def debugRangeStatus(self, c2range):
        for c in c2range.clients:
            main.debug("client: {} {}\n\tStatus: {}\n\tInjects: {}\n\t".format(c.hostname,c.ip,c.state,len(c.injects)),"green")


    def run(self):
        """ The default thread function.
        It tries to connect to the rangeC2 server, trying forever if necessary. As soon as the connection is created, it is SSL encrypted.
        Next, it goes into a loop, until stopped, which will check the message queue, process events, and receive information from the range.
        Will exit if the terminate() function is called. """
        threadLock.acquire_write()
        threads.append(self)
        threadLock.release_write()

        while not self.connected and not self.stop:
            time.sleep(0.1)
            try:
                sock = socket.socket()
                sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
                self.SSLSock = ssl.wrap_socket(sock)
                # Timeout of 10 seconds
                #self.SSLSock.settimeout(0)
                if not self.c2.state == main.States.ERROR:
                   self.c2.errorString = "Connecting to "+self.c2.c2ExternalIP+"..."

                # Try to connect as much as possible
                self.SSLSock.connect((self.c2.c2ExternalIP,self.c2.c2ExternalPort))
                self.connected = True
                self.c2.errorString = ""
            except Exception, e:
                #if self.c2.state == main.States.ERROR:
                #    pass
                #else:
                #TODO: fix transport endpoint is already connected error that can occur here
                self.SSLSock.close()
                self.c2.errorString = "Error with connecting to "+self.c2.c2ExternalIP+" ("+str(e)+")\n"
                self.c2.state = main.States.ERROR
                self.c2.clients[:] = []
                
        
        # connected; initiate sanity handshake
        self.c2.state = main.States.RUNNING
        if self.sendObject(self.c2) == False:
            raise UserWarning("Could not complete initial handshake. Retrying.")
       
        cmd = main.UpdateRequest()
        if self.sendObject(cmd) == False:
            raise UserWarning("Could not complete initial handshake: initial request. Retrying.")

        lastUpdate = time.time()
        waitingOnUpdate = False

        while not self.stop:
            #####################
            # Main recieve loop #
            #####################
            time.sleep(0.01)
            try:
                if self.reThread:
                    self.reThread = False
                    raise UserWarning("A request to restart this thread is being handled...Safely")
                if not self.queue.empty():
                    obj = self.queue.get()
                    #main.debug("WebC2{}: task in queue".format(self))
                    if isinstance(obj, main.Inject):
                        main.debug("WebC2{}: Starting inject and sending to rangeC2".format("self"),"light_blue")
                        command = self.executeInject(obj)
                        if self.sendObject(command) == False:
                            raise UserWarning("Could not send inject request to range.")

                    elif isinstance(obj, main.RemoveInject):
                        main.debug("Removing inject {} on {}".format(obj.targetId, obj.target),"yellow")
                        # Start the process to kill the process and send it to the range
                        rangeName = obj.target.split('.',1)[0]
                        clientName = obj.target.split('.',1)[1:]
                        found = False
                        for c2 in c2Servers:
                            if c2.rangeName == rangeName:
                                for client in c2.clients:
                                    for inj in client.injects:
                                        if inj.id == obj.targetId:
                                            client.injects.remove(inj)
                                            if inj.webC2Inject.pid > 0:
                                                try:
                                                    os.kill(inj.webC2Inject.pid, signal.SIGTERM)
                                                    os.waitpid(inj.webC2Inject.pid, 0)
                                                except OSError as e:
                                                    main.debug("error killing process {}".format(inj.webC2Inject.pid),"yellow")
                                                    main.debug(e)
                                                    inj.webC2Inject.pid = 0
                                            found = True
                                            break # we found the inject
                                break # we found the range
                        if found:
                            if self.sendObject(obj) == False:
                                raise UserWarning("Could not send a remove inject request to the range.")
                        else:
                            main.debug("Could not find inject to remove! {}".format(obj.targetId),"red")
                    elif isinstance(obj, main.StopInject):
                        # Start the process to kill the process and send it to the range
                        main.debug("Stopping inject {} on {}".format(obj.targetId, obj.target),"yellow")
                        rangeName = obj.target.split('.',1)[0]
                        clientName = obj.target.split('.',1)[1:]
                        found = False
                        for c2 in c2Servers:
                            if c2.rangeName == rangeName:
                                for client in c2.clients:
                                    for inj in client.injects:
                                        if inj.id == obj.targetId:
                                            if inj.webC2Inject.pid > 0:
                                                try:
                                                    os.kill(inj.webC2Inject.pid, signal.SIGTERM)
                                                    os.waitpid(inj.webC2Inject.pid, 0)
                                                except OSError as e:
                                                    main.debug("error killing process {}",format(inj.webC2Inject.pid),"red")
                                                    main.debug(e,"red")
                                                    inj.webC2Inject.pid = 0
                                                    inj.webC2Inject.state = main.States.STOPPED
                                            found = True
                                            break # we found the inject
                                break # we found the range
                        if found:
                            if self.sendObject(obj) == False:
                                raise UserWarning("Could not send a remove inject request to the range.")
                        else:
                            main.debug("Could not find process to kill! {}".format(obj.targetId),"red")


                    elif isinstance(obj, main.UpdateRequest):
                        # I'm not sure how this could happen? Maybe a forced refresh?
                        raise Exception("Illegal state. UPDATE_REQUEST placed in WebC2 thread's queue. Who put this here?")
                    else:
                        main.debug("got an unknown object {}".format(obj),"red")
                        self.queue.task_done()
                if select.select([self.SSLSock],[],[],0)[0]:
                    # data ready for reading
                    data = self.recvObject()
                    if data == False:
                        raise UserWarning("The range probably died. Re-initiating converstaion.")
                    if data == "GOODBYE":
                        raise UserWarning("The range said goodbye. Reconnecting.")
                    # Do something with data
                    if isinstance(data, main.C2):
                        for c2 in c2Servers:
                            if c2.rangeName == data.rangeName:
                                waitingOnUpdate = False
                                main.debug("WebC2: Got an update from {} with {} clients".format(data.rangeName, len(data.clients)),"green")
                                
                                self.debugRangeStatus(data)                                
                                # go through clients, ensure adding them won't overwrite our inject data
                                # Add and remove clients
                                newClientIdSet = set([i.ip for i in data.clients])
                                curClientIdSet = set([i.ip for i in c2.clients])
                                # This is the set of clients that we're storing that are no longer with us
                                needDeleteClientIdSet = curClientIdSet - newClientIdSet
                                #main.debug("Clients to delete: {}".format(needDeleteClientIdSet))
                                # This is the set of clients that are new to us
                                needAddClientIdSet = newClientIdSet - curClientIdSet
                                #main.debug("Clients to add: {}".format(needAddClientIdSet))
                                
                                # Delete old clients
                                for oldClient in c2.clients:
                                    if oldClient.ip in needDeleteClientIdSet:
                                        c2.clients.remove(oldClient)

                                # Figure out the differences in injects
                                for newClient in data.clients:
                                    if newClient.ip in needAddClientIdSet:
                                        c2.clients.append(newClient)
                                    else:
                                        # Update old one
                                        ######################rsr# Bugfix, indented and 
                                        found = False
                                        for oldClient in c2.clients:
                                            if oldClient.ip == newClient.ip:
                                                # update the contents of our local copies without overwriting our information
                                                found = True
                                                for newInj in newClient.injects:
                                                    injFound = False
                                                    for oldInj in oldClient.injects:
                                                        if newInj.id == oldInj.id:
                                                            injFound = True
                                                            oldInj.response = newInj.response
                                                            oldInj.rangeC2Inject = newInj.rangeC2Inject
                                                            oldInj.clientInject = newInj.clientInject
                                                            break
                                                    if not injFound:
                                                        main.debug("Added new inject","light_blue")
                                                        oldClient.injects.append(newInj)
                                                #remove any ghosts
                                                for oldI in oldClient.injects:
                                                    if oldI.id not in [i.id for i in newClient.injects]:
                                                        oldClient.injects.remove(oldI)
                                                        c2.errorString = data.errorString
                                                        c2.state = data.state
                    # They spoke to us!
                    lastUpdate = time.time()

                # check how long it's been since they've sent something
                curTime = time.time()
                if curTime - lastUpdate > 10:
                    main.debug("WebC2: the range hasn't talked in a while. Re-initiating communications.","red")
                    raise UserWarning("The range appears to have stopped responding.")
                if not waitingOnUpdate and curTime - lastUpdate > 5:
                    waitingOnUpdate = True
                    #main.debug("WebC2: Requesting status update")
                    cmd = main.UpdateRequest()
                    if self.sendObject(cmd) == False:
                        raise UserWarning("Could not send an update request.")

            except UserWarning as discon:
                main.debug(discon, "red")
                self.c2.state = main.States.ERROR
                self.c2.errorString = str(discon) + ", Trying to reconnect"
                # for some reason, this breaks things (range stops reporting clients)
                #self.c2.clients = list()
                for c in self.c2.clients:
                    self.c2.clients.remove(c)

                newThread = WebC2(self.c2)
                threadLock.acquire_write()
                for thread in threads:
                    if thread.c2.rangeName == self.c2.rangeName:
                        threads.remove(thread)
                        break
                threadLock.release_write()
                time.sleep(11)
                newThread.start()
                return
            except Exception as e:
                main.debug(e,"red")
                traceback.print_exc()
                self.c2.state = main.States.ERROR
                self.c2.errorString = "Error in webC2: "+str(e)+'\n'+traceback.format_exc()

class ThreadedHTTPServer(ThreadingMixIn, BaseHTTPServer.HTTPServer):
    """ This trickery makes us able to do threaded requests? """
    pass

class WWWServer(BaseHTTPServer.BaseHTTPRequestHandler):
    """ This class is the web server. It handles sending the files over the socket as well as JSONing data structures in reply to JS requests. """

    def address_string(self):
        """ If this method is not overwritten, it does a reverse lookup on every request.
        This causes it to be very slow. """
        return str(self.client_address[0])

    def do_AUTHHEAD(self):
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm="apiarium C2"')
        self.send_header('Content-type', 'text/html')
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        self.end_headers()

    def authenticate(self):
        """ This function authenticates the web browser before any important information is sent back to them. It checks for a SESSION_ID cookie, and if found and valid, accepts them. Otherwise, it uses the 401 WWW-Authenticate header, and creates a SESSION_ID for the user. SESSION_IDs are created using a timestamp plus a random value between 0 and 0x100000000. They currently are not cleared until the webserver is restarted, which may cause a security risk. """
        global SESSIONS, AUTHSTRING
        # The person has a cookie (ensure cookie good)
        if 'Cookie' in self.headers:
            c = Cookie.SimpleCookie(self.headers['Cookie'])
            if 'SESSION_ID' in c:
                session_id = c['SESSION_ID'].value
                if session_id in SESSIONS:
                    return True
        # The person has a basic auth (give cookie)
        if 'Authorization' in self.headers:
            if self.headers['Authorization'] == 'Basic '+AUTHSTRING:
                self.send_response(200)
                c = Cookie.SimpleCookie()
                c['SESSION_ID'] = time.time() + random.randint(0, 0x100000000)
                SESSIONS.append(c['SESSION_ID'].value)
                self.send_header("Set-Cookie", c.output(header=""))
                return True
        # The person has no cookie and no basic auth (denied, asked for basic auth)
        self.do_AUTHHEAD()
        return False

    def do_GET(self):
        """ Handles a GET request. Certain pathnames are used to deliver information from the C2's internals.
        This method attempts to derail directory traversal attacks. """
        try:
            self.path = urlparse(self.path).path

            if self.path=='/favicon.ico':
                return
    
            if not self.authenticate():
                return

            webroot = os.getcwd()+'/'+WEBROOT
            filename = ''
            
            json_pages = ['/json','/modules','/injects']

            if self.path == '/':
                filename = webroot + '/' + WEBROOT_DEFAULT_PAGE
        
            elif self.path in json_pages:
                # Handle the AJAX JSON requests...
                self.send_response(200)
                self.send_header("Content-type","application/json")
                self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
                self.send_header("Pragma", "no-cache")
                self.send_header("Expires", "0")
                self.end_headers()

                if self.path == '/json':
                    json_info = json.dumps(c2Servers, cls=self.ObjectJsonEncoder)
                    self.wfile.write(json_info)

                elif self.path == '/injects':
                    """ Creates something like:
                    {"Connect back shell": {"ranges": {"VMRange": [{"ip": "192.168.232.128", "hostname": "333-adeec7dfef1.localdomain", "id": 158322956}]}, "interactive": 0}}
                    """
                    injectDict = {}
                    for c2 in c2Servers:
                        for client in c2.clients:
                            for inject in client.injects:
                                modName = inject.getName()
                                #print "/injects: {}:{}".format(inject.id,modName)
                                if not modName in injectDict:
                                    injectDict[modName] = {}
                                    injectDict[modName]['ranges'] = {}
                                    mod = main.moduleFromInject(inject)
                                if not c2.rangeName in injectDict[modName]['ranges']:
                                    injectDict[modName]['ranges'][c2.rangeName] = []
                                newClientInject = {}
                                newClientInject['ip'] = client.ip
                                newClientInject['hostname'] = client.hostname
                                newClientInject['id'] = inject.id
                                newClientInject['response'] = inject.response
                                injectDict[modName]['ranges'][c2.rangeName].append(newClientInject)
                    self.wfile.write(json.dumps(injectDict))

                elif self.path == '/modules':
                    """Return a list of the modules and their variables
                    """
                    toBeJSON = []
                    for module in main.modules:
                        tmp = []
                        tmp.append(module.getName())
                        tmp.append(module.getDesc())
                        tmp.append(module.getOtherVars())
                        toBeJSON.append(tmp)
                    self.wfile.write(json.dumps(toBeJSON))
                return

            else:
                filename = webroot + self.path
            
            # Try to mitigate directory traversal attacks
            while '..' in filename:
                filename = filename.replace('..','')
            filename = os.path.abspath(filename)
            
            self.send_response(200)
            self.send_header("Content-type", mimetypes.guess_type(filename)[0])
            self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
            self.send_header("Pragma", "no-cache")
            self.send_header("Expires", "0")
            self.end_headers()
            self.deliverFile(filename)
        except Exception as e:
            traceback.print_exc()
            #_DEBUG_BREAK()
    
    def deliverFile(s, filename):
        """ Load the file off of the disk, and write it to the self.wfile object, which returns it to the user.
        If an exception occurs, such as a FileNotFound exception, it will be displayed to the user instead. """
        try:
            f = open(filename)
            s.wfile.write(f.read())
            f.close()
        except Exception, e:
            s.wfile.write("Could not load file: "+str(e))

    def dispatchToRange(self,objectToSend):
        """ Places objectToSend in a range's message queue. This can only be used on objects that contain a 'target' member variable. """
        found = False
        threadLock.acquire_read()
        for thread in threads:
            if isinstance(thread, WebC2):
                if thread.c2.rangeName == objectToSend.target.split('.')[0]:
                    thread.queue.put(objectToSend)
                    found = True
            if found:
                break
        threadLock.release_read()
        return found

    def do_POST(self):
        """ Handles a POST request. This request will initiate an action within the internal C2 structure, such as execution on a C2 node. """
        #main.debug("POST to {}".format(self.path))
        self.send_response(200)
        self.end_headers()

        # Get the parameters, put them in a dictionary
        content_len = int(self.headers.getheader('content-length'))
        post_body = self.rfile.read(content_len)
        main.debug("got post: {}".format(post_body),"pink")
        params_list = post_body.split('&')
        params = dict()
        for p in params_list:
            tmp = p.split('=')
            params[tmp[0]] = tmp[1]

        # Do things with the data
        try:
            newCmd = None
            
            if 'action' in params:
                if params['action'] == 'inject':
                    if 'option' in params:
                        # Start a new inject
                        if params['option'] == 'start':
                            newCmd = main.Inject()
                            newCmd.target = params['target']
                            newCmd.args = json.loads(urllib.unquote(params['args'].replace('+',' ')))
                            main.debug("new Inject","blue")
                            if not self.dispatchToRange(newCmd):
                                main.debug("Could not find target","red")

                        elif params['option'] == 'stop':
                            # TODO: kill an inject via killing its processes and clean them up
                            if 'target' in params and 'id' in params:
                                cmd = main.StopInject()
                                cmd.target = params['target']
                                cmd.targetId = params['id']
                                if self.dispatchToRange(cmd):
                                    self.wfile.write("Dispatched to the range.")
                                else:
                                    self.wfile.write("Error! Target not found.")
                            else:
                                self.wfile.write("Error! Stop who?")

                        elif params['option'] == 'remove':
                            if 'target' in params and 'id' in params:
                                cmd = main.RemoveInject()
                                cmd.target = params['target']
                                cmd.targetId = params['id']
                                if self.dispatchToRange(cmd):
                                    self.wfile.write("Dispatched to the range.")
                                else:
                                    self.wfile.write("Error! Target not found.")
                            else:
                                self.wfile.write("Error! Remove who?")

                        elif params['option'] == 'cleanup':
                            print('POST regarding cleanup')
                            if 'range' in params:
                                print('Cleaning up '+params['range'])
                                for c2 in c2Servers:
                                    if c2.rangeName == params['range']:
                                        for client in c2.clients:
                                            for inj in client.injects:
                                                cmd = main.RemoveInject()
                                                cmd.target = c2.rangeName +'.'+ client.ip
                                                cmd.targetId = inj.id
                                                if not self.dispatchToRange(cmd):
                                                    self.wfile.write("Could not cleanup inject...")
                                        break # we found the correct range; break
                            else:
                                # Loop through all of the ranges, all of the clients, all of the injects in order to get all of the inject IDs.
                                for c2 in c2Servers:
                                    for client in c2.clients:
                                        for inj in client.injects:
                                            cmd = main.RemoveInject()
                                            cmd.target = c2.rangeName +'.'+ client.ip
                                            cmd.targetId = inj.id
                                            if not self.dispatchToRange(cmd):
                                                self.wfile.write("Could not cleanup inject...")
                                self.wfile.write("Cleanup complete.")
                        else:
                            self.wfile.write("Error with the AJAX request. Unknown 'option' param.")

                elif params['action'] == 'maint':
                    if params['option'] == 'rebootRange':
                        ipToReboot = ""
                        for c2 in c2Servers:
                            if params['target'] == c2.rangeName:
                                ipToReboot = c2.c2ExternalIP
                                break
                        main.debug("Got a reboot range request for {}".format(params['target']),"yellow")
                        threadLock.acquire_read()
                        for thread in threads:
                            if thread.c2.c2ExternalIP == ipToReboot:
                                thread.restartThread("RestartRange Clicked")
                        threadLock.release_read()
                        cmd = 'ssh ' + ipToReboot + ' \\"sudo reboot"\\'
                        main.debug(cmd,"yellow")
                        os.system('bash -c "' + cmd + '"')
                    else:
                        self.wfile.write("Error with the AJAX request. Missing 'option' param.")
                    return

                else:
                    self.wfile.write("PLZ UPDATE CODE. OLD POST. EXEC NO LONGER SUPPORTED.")

                self.wfile.write("Executing command.\n")
            else:
                self.wfile.write("No action performed.\n")
        except Exception, e:
            main.debug("Malformed POST request: {} (Error with: {})\n{}".format(params,str(e),traceback.format_exc(),"red"))
            self.wfile.write("Malformed POST request: {} (Error with: {})\n{}".format(params,str(e),traceback.format_exc()))

    class ObjectJsonEncoder(json.JSONEncoder):
        """ A custom json encoder. It's actually pretty lame.
        Use:
        >>> json.dumps(obj, cls=ObjectJsonEncoder)
        {"item1":"yay", "list1":["a","b"]} ...
        """
        def default(self, obj):
            if isinstance(obj, main.C2):
                c2Instance = copy.deepcopy(obj)
                for client in c2Instance.clients:
                    for inject in client.injects:
                        inject.moduleFile.contents = ""
                return c2Instance.__dict__
            elif isinstance(obj, main.Client):
                c = copy.deepcopy(obj)
                for inject in c.injects:
                    inject.moduleFile.contents = ""
                return c.__dict__
            elif isinstance(obj, main.Inject):
                i = copy.deepcopy(obj)
                i.moduleFile.contents = ""
                return i.__dict__
            return obj.__dict__

def run(conf):
    """ This is the main method for the webserver. It starts the C2 portion of the server,
    and then it starts the webserver. """
    
    # Change our working directory to be the same as the file's
    # If this doesn't happen, it will try to load the configuration file and not find it.
    # todo: accept command-line arguments in order to change the directory where the configuration file is loaded from
    os.chdir(os.path.dirname(os.path.realpath(__file__)))

    main.debug("Starting C2 controller server on "+str(time.asctime()),"pink")

    # Load the configuration and load all of the injects
    loadWebC2Config(conf)
    main.loadInjects()

    # Set up the basic authentication
    global AUTHSTRING
    AUTHSTRING = base64.b64encode("%s:%s"%(BASIC_AUTH_USERNAME, BASIC_AUTH_PASSWORD))
    
    # Check to see if we can bind to the port properly (need root for 443)
    if PORT_NUMBER <= 1024:
        euid = os.geteuid()
        if euid != 0:
            main.debug("Please run as root to bind to port {}.".format(PORT_NUMBER),"yellow")
            sys.exit(1)

    # Start the http server and make it ssl
    httpd = ThreadedHTTPServer((HOST_NAME, PORT_NUMBER), WWWServer)
    httpd.socket = ssl.wrap_socket(httpd.socket, certfile="../cert.pem", server_side=True)
    
    # Spawn a new webC2 server for each c2Server specified from the configurations
    for c2 in c2Servers:
        thread = WebC2(c2)
        thread.start()
    
    try:
        main.debug("Starting webserver at %s:%s on %s" % (HOST_NAME, PORT_NUMBER, str(time.asctime())),"pink")
        httpd.serve_forever()
    except KeyboardInterrupt:
        # Don't catch it here. It will be caught elsewhere
        pass
    except Exception as e:
        traceback.print_exc()
    main.debug("Stopping server on "+str(time.asctime()),"yellow")
    httpd.server_close()

if __name__ == '__main__':
    run()
