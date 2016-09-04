#!/usr/bin/env python
import ConfigParser
import cPickle as pickle
import uuid
import os
import Queue
import select, socket, ssl
import signal
import SocketServer
import struct
import sys
import time
import traceback
import json
import base64

"""
    Local packages
"""
import app.range.docker
import app.main as main

"""
    Globals
"""
NUM_CLIENTS = 100
HOST = ''
## The host to bind to in order to listen for the webC2's connection. Specified in the conf file.
PORT = 9013
## The port to bind to in order to listen for the webC2's connection. Specified in the conf file.
C2PORT = 9000

CORE_SW_INT = ''
INET_INT = ''

GOODBYE = "GOODBYE"

## Supplies command and control functionality for clients.
#  These clients act as little "bots" that can be connnected to student ranges.
#  NOTE: It seems like some of these methods should be private.
class ClientC2():
    ## The constructor.
    def __init__(self):
        self.clients = []
        self.docker = app.range.docker.Docker(CORE_SW_INT, num_clients=NUM_CLIENTS)
        self.remake_client_records()
    ## Starts up or "makes" the clients.
    def start(self):
        self.docker.make_clients()
        self.remake_client_records()
    ## Runs self.inject_update().
    def update(self):
        self.inject_update()
        #self.remake_client_records()

    ## Checks to see if inject is still running.
    #  If not, it changes the state to "STOPPED".
    def inject_update(self):
        for client in self.clients:
            for inject in client.injects:
                pid = inject.pid
                if pid != 0:
                    # check if it's still running:
                    ps_res = self.run_in_client(client, 'ps -p '+str(pid))[0]
                    running = True if len(ps_res.split('\n')) == 2 else False
                    if not running:
                        inject.pid = 0
                        inject.state = main.States.STOPPED

    ## stops the inject on all the clients with the matching ID and removes it.
    #  @param id the id of the inject to be removed.
    def inject_remove(self, id=None):
        for client in list(self.clients):
            for inj in list(client.injects):
                if inj.id == id or id == None:
                    self.inject_stop_inject(client, inj)
                    client.injects.remove(inj)

    ## stops the inject based on the inject's pid.
    #  @param client The client the inject is running.
    #  @param inject The inject to stop.
    def inject_stop_inject(self, client, inject):
        if inject.pid != 0:
            main.debug('Killing pid '+str(inject.pid)+' in client '+str(client.hostname), color='red')
            ret = self.run_in_client(client, 'kill -9 '+str(inject.pid))

            # ensure that stdout and stderr are null
            if filter(None, ret):
                inject.state = main.States.STOPPED
                inject.pid = 0
            else:
                # try again?
                ret = self.run_in_client(client, 'kill -9 '+str(inject.pid))
                if filter(None, ret):
                    inject.state = main.States.STOPPED
                    inject.pid = 0

    ## Stops the inject based on ID but doesn't remove it.
    #  @param id the id of the inject to stop
    def inject_stop(self, id):
        for client in self.clients:
            for inject in client.injects:
                if inject.id == id:
                    self.inject_stop_inject(client, inject)

    ## Runs an inject on a client.
    #  @param client The client the inject is going to run on.
    #  @param inject The inject to run.
    def inject_run(self, client, inject):
        # Make the program name
        injName = os.path.basename(
                main.moduleFromInject(inject).__mod__.__file__)
        if injName[-3:] == 'pyc':
            injName = injName[:-1]
        program = '/opt/injects/' + injName

        args = base64.urlsafe_b64encode(json.dumps(inject.args))

        # Run and return the pid
        pid = self.run_in_client(client, "python %s %s" % (program, args), True)
        main.debug('GOT PID: {}'.format(pid),'red')
        if pid == False:
            main.debug('run_in_client returned false...','red')
            return False
        inject.pid = int(pid)
        inject.state = main.States.RUNNING
        client.injects.append(inject)

    ## Rebuilds a list of all the clients and their attributes.
    def remake_client_records(self):
        new_clients = []
        lookup = dict(self.docker.dhcpClients)

        for inst in self.docker.getInstances():
            newClient = main.Client()
            newClient.ip = inst.ip
            newClient.mac = inst.mac
            newClient.hostname = lookup[inst.mac]
            newClient.dSID = inst.sID
            newClient.state = main.States.RUNNING
            # Grab the dhcp'd ip address
            intIP = self.run_in_client(newClient, 'ip a sh dev eth1|grep inet')
            if filter(None, intIP) == []:
                # we didn't get an ip on that interface
                main.debug("Client did not dhcp properly.", 'red')
            intIP = filter(None, intIP[0].split(' '))[1]
            newClient.intIP = intIP
            new_clients.append(newClient)
        self.clients[:] = []
        for item in new_clients:
            self.clients.append(item)

    ## Removes all clients and rebuilds the records list.
    #  (this effectively clears the client records).
    def stop(self):
        self.docker.remove_clients()
        self.remake_client_records()

    ## Uses ssh to execute a command in the client.
    #  @param client client to execute the command on.
    #  @param cmd command to run on client.
    #  @param background If background is false, it will block. It will return (stdout, stderr).
    #  If background is true, it will not block and not wait for output, but it will return the pid
    def run_in_client(self, client, cmd, background=False):
        sID = client.dSID
        logfile = '/tmp/'+base64.urlsafe_b64encode(cmd)[:20]
        try:
            if background:
                data = self.docker._run_in_inst('nohup '+cmd+' > ' +logfile+' &', sID)
                main.debug('from run_in_client: {}'.format(data),'green')
                if len(data[1]) > 0:
                    main.debug('Failed to run inject.', 'red')
                    raise e
                pid = int(data[0].split(' ')[1])
                running = True if len(self.run_in_client(client, "ps -p "+str(pid))[0].split('\n')) == 2 else False
                if not pid:
                    main.debug("\tIn ClientC2::run_in_client(...): The process that was just started is already finished...", 'red')
                return pid
            else:
                return self.docker._run_in_inst(cmd, sID)
        except Exception as e:
            client.errorString = e
            throwString = "Error running in client: {}".format(e)
            main.debug(throwString, 'red')
            raise Exception(throwString)

    ## Handle the object received from the webC2.
    #  @param obj the object to be received from the webC2
    def handle_object(self, obj):
        if isinstance(obj, main.RemoveInject):
            self.inject_remove(obj.targetId)

        elif isinstance(obj, main.StopInject):
            self.inject_stop(obj.targetId)

        elif isinstance(obj, main.Inject):
            # We have to run the inject
            # Find the client first
            client = None
            for c in self.clients:
                if c.hostname == obj.workstation:
                    client = c
                    break

            if client == None:
                # run it on all of them?
                #main.debug('Could not find workstation {} to run the {} inject.'.format(
                #   obj.workstation, obj.name),'red')
                for c in self.clients:
                    # make a new copy of the inject
                    obj2 = main.Inject()
                    obj2.range = obj.range
                    obj2.name = obj.name
                    obj2.pid = 0
                    obj2.args = obj.args
                    obj2.workstation = c.hostname
                    self.inject_run(c, obj2)
            else:
                self.inject_run(client, obj)

        else:
            main.debug("Recieved bad inject in ClientC2::handle_object(...).", 'red')

## This class spawns then is tasked with communication to/from the WebC2.
class WebC2Connection():
    ## The constructor
    #  initialized values and creates the clients
    def __init__(self):
        self.webC2SSLSock = None
        self.c2Server = None
        self.stop = False
        self.queue = Queue.Queue()
        self.threadLock = main.ReadWriteLock()
        self.errorFile = ""
        self.clientC2 = ClientC2()
        
        # Create the clients
        main.debug("Starting the clients...","yellow")
        self.clientC2.start()
        time.sleep(5)
        main.debug("...finished.","yellow")
    
    ## THIS MUST BE CALLED BEFORE .run!!!
    def setWebC2Socket(self, webC2Conn):
        self.webC2Sock = webC2Conn

    ## Terminates this thread
    def terminate(self):
        print("terminating WebConnectionThread")
        self.stop = True
        for inject in self.c2Server.injects:
            os.kill(inject.pid, signal.SIGKILL)

        self.clientC2.inject_remove()

    ## Send an object to the WebC2.
    #  @param obj object to be sent to the WebC2
    def sendObject(self, obj):
        data = pickle.dumps(obj)
        size = struct.pack("<I", len(data))
        self.webC2SSLSock.sendall(size)
        self.webC2SSLSock.sendall(data)

    ## Receive an object from the WebC2.
    def recvObject(self):
        size = self.webC2SSLSock.recv(4)
        size = struct.unpack("<I", size)[0]
        data = self.webC2SSLSock.recv(size)
        while len(data) < size:
            data += self.webC2SSLSock.recv(size-len(data))
        data = pickle.loads(data)
        return data

    ## Execute an inject (this always forks)
    #  @param injectToExecute the inject to be executed
    def executeInject(self, injectToExecute):
        module = main.moduleFromInject(injectToExecute)

        if module == None:
            self.c2Server.errorString = "Could not load module {}".format(injectToExecute.name)
            print("Bad module name: ".format(injectToExecute.name))
            return

        # Execute it!
        if module.isRange():
            main.debug("Forking for the inject with args: {}!".format(
                injectToExecute.args), color="light_blue")

            pid = os.fork()
            if pid == 0:
                try:
                    ret = module.getInjectClass()().run(**injectToExecute.args)
                    if ret != None and isinstance(ret, basestring) and ret[:5] == "ERROR":
                        #if rangeC2 returns anything that looks like an error, try to stop the process
                        main.debug("From child process: {}".format(ret), color="red")

                        with open(self.errorFile, 'a') as errFile:
                            errFile.write('-'*80+ret)
                        sys.exit(0)
                except Exception as e:
                    print "Error with running inject: {}\n{}".format(str(e), traceback.format_exc())
                print "Exiting"
                sys.exit(0)

            else:
                # parent process
                main.debug("Forked with pid: {}".format(pid), color="light_blue")
                injectToExecute.pid = pid
                injectToExecute.state = main.States.RUNNING
                self.c2Server.injects.append(injectToExecute)

        return injectToExecute

    ## Prints debug info
    def debugStatus(self):
        for c in self.c2Server.clients:
            dbgstr = """client: {} {} ({})
                     \tStatus: {}
                     \tInjects: {} ({})
                     """.format(
                             c.hostname,
                             c.ip,
                             c.dSID[:10],
                             c.state,
                             len(c.injects),
                             str([(a.id, a.pid) for a in c.injects]))
            main.debug(dbgstr, 'blue')

    ## Stops an inject
    #  @param obj an object containing an id matching one of the inject IDs
    def stopInject(self, obj):
        for inj in self.c2Server.injects:
            if hasattr(obj, 'targetId') and inj.id == obj.targetId:
                if inj.pid != 0:
                    try:
                        main.debug("Killing process pid: {}".format(inj.pid))
                        os.kill(inj.pid, signal.SIGTERM)
                        inj.pid = 0
                        inj.state = main.States.STOPPED
                    except:
                        main.debug("Failed to kill process with pid: {}".format(
                            inj.pid))
                        break
                elif inj.state == main.States.STOPPED:
                    pass

    ## Removes an inject
    #  @param obj an object containing an id matching one of the inject IDs
    def removeInject(self, obj):
        for inj in list(self.c2Server.injects):
            if obj.targetId == None:
                obj.targetId = inj.id
                self.stopInject(obj)
                obj.targetId = None
                main.debug("Removing inject: {}".format(inj.pid))
                self.c2Server.injects.remove(inj)

            elif inj.id == obj.targetId:
                self.stopInject(obj)
                main.debug("Removing inject: {}".format(inj.pid))
                self.c2Server.injects.remove(inj)
                break

    ## Handle an object from the WebC2 (execute an inject if needed, etc.), then dispatch it to the appropriate thread for passing to the client.
    #  @param obj the object sent from WebC2
    def handleObject(self, obj):
        self.debugStatus()

        if isinstance(obj, main.UpdateRequest):
            # send out for an update from every client
            self.clientC2.update()

            # Update the server as to our current state
            # Note: since I do it this way, client updates will always be one update behind, technically.
            main.debug("Updating webC2 with info about {} clients".format(len(self.c2Server.clients)))
            #self.debugStatus()
            self.sendObject(self.c2Server)
        
        elif isinstance(obj, main.Inject):
            main.debug("Received module inject from server for {} on {}:{}".format(
                obj.name, obj.range, obj.workstation))
            if main.moduleFromInject(obj).isRange():
                self.executeInject(obj)
            if main.moduleFromInject(obj).isClient():
                self.clientC2.handle_object(obj)
            
            self.sendObject(self.c2Server)

        elif isinstance(obj, main.RemoveInject):
            if obj.targetId == None and obj.workstation == None:
                main.debug("Cleaning up range.")
            else:
                main.debug("Removing inject {} on {}".format(obj.targetId, obj.workstation))
            self.removeInject(obj)
            self.clientC2.handle_object(obj)
            
            self.sendObject(self.c2Server)

        elif isinstance(obj, main.StopInject):
            main.debug("Stopping inject {} on {}".format(obj.targetId, obj.workstation))
            self.stopInject(obj)
            self.clientC2.handle_object(obj)
            
            self.sendObject(self.c2Server)

        else:
            raise Exception("Unknown object received!")

    ## Add the IP addresses that the webC2 told us we could use.
    def addIPs(self):
        main.debug("Configuring IP addresses.","blue")
        #iface = self.c2Server.c2Interface
        #count = 0
        iface = self.c2Server.c2Interface
        if iface != None:
            for each in self.c2Server.c2IPPool:
                #cmd = 'ip a add '+each+'/0 label '+iface+':'+str(count)+' dev '+ iface
                cmd = 'ip a add '+each+'/32 dev '+ iface
                main.debug(cmd)
                os.system(cmd + " 2>&1 > /dev/null" )
                #count += 1
        else:
            main.debug("No interface for ip {} ; subnet not in conf, skipping".format(each),"red")

    ## Remove the IP addresses that ``addIPs`` created.
    def delIPs(self):
        main.debug("Removing IP addresses.", "blue")
        for each in self.c2Server.c2IPPool:
            iface = self.c2Server.c2Interface
            if not iface == None:
                cmd = 'ip a del '+each+'/32 dev '+ iface
                os.system(cmd + ' 2>&1 > /dev/null')
                """cmd2 = 'ip rule del from '+each+'/32 table ' + iface
                cmd3 = 'ip rule del to '+each+'/32 table ' + iface
                os.system('bash -c \"' + cmd2 + '\"')
                os.system('bash -c \"' + cmd3 + '\"')"""

            else:
                main.debug("No interface for ip {} ; subnet not in conf, skipping".format(each),"red")

    ## Handle the communication to/from the WebC2 server. 
    #  This will do the following:
    #  - Enable SSL
    #  - Receive the c2Server information that details how this rangeC2 should behave.
    #  - Add IP addresses to the interface for injects to use.
    #  - Enter a loop; processing messages and communications until stopped.
    #  @param sock the socket for the WebC2
    def handle(self, sock):
        self.setWebC2Socket(sock)

        main.debug("WebConnectionThread: new connection from ({},{})".format(self.webC2Sock.getpeername()[0],self.webC2Sock.getpeername()[1]))
        
        # set up SSL
        self.webC2SSLSock = ssl.wrap_socket(self.webC2Sock, server_side=True, certfile="../cert.pem", ssl_version=ssl.PROTOCOL_SSLv23)

        # Get our c2 information from the server
        self.c2Server = self.recvObject()

        # The following ~10 lines created test clients.
        #for x in xrange(10):
        #    inject = main.Inject()
        #    inject.humanName = 'Connect back shell'
        #    client = main.Client()
        #    client.dc = "testDomain" + str(x)
        #    client.hostname = "testHost" + str(x)
        #    client.ip = "192.168.0.10" + str(x)
        #    client.state = main.States.RUNNING
        #    client.injects.append(inject)
        #    self.c2Server.clients.append(client)
        
        self.c2Server.clients = self.clientC2.clients

        # Create the ip addresses from the pool
        main.debug("payload_ip_pool {}".format(self.c2Server.c2IPPool),"blue")
        main.debug("Subnets,ifaces: {}".format(self.c2Server.aliasInfo),"blue")
        self.delIPs()
        self.addIPs()

        # create a new file for storing errors
        #self.errorFile = str(self.c2Server.rangeName) + "Errors"
        #with open(self.errorFile, 'w') as errFile:
        #   pass

        lastUpdate = time.time()
        lastPIDCheck = time.time()
        main.debug("Starting the main loop.")
        self.stop = False
        while not self.stop:
            try:
                curTime = time.time()
                if curTime - lastPIDCheck > 5:
                    # every 5 seconds, check all of the pids
                    for inj in self.c2Server.injects:
                        pid = inj.pid
                        try:
                            if os.waitpid(pid, os.WNOHANG) != (0,0):
                                self.stopInject(inj)
                        except:
                            self.stopInject(inj)

                    lastPIDCheck = curTime

                if select.select([self.webC2SSLSock],[],[],0)[0]:
                    print("WebConnectionThread: Recv'ing object from webC2.")
                    msg = self.recvObject()
                    self.handleObject(msg)
                    lastUpdate = curTime

                if not self.queue.empty():
                    print("WebConnectionThread: Processing item in queue.")
                    obj = self.queue.get()
                    self.sendObject(obj)
                    self.queue.task_done()
                    lastUpdate = curTime

                if curTime - lastUpdate > 10:
                    # if we haven't communicated in a while, send an object
                    self.sendObject(self.c2Server)
                    lastUpdate = curTime
                
                # Sleep so others can process data
                time.sleep(0.1)
            except (IOError, socket.error, EOFError) as e:
                print("Lost communication to server. Reason: "+str(e))
                break
            except KeyboardInterrupt:
                print("Ctrl+C detected. Shutting down.")
                self.sendObject(GOODBYE)
                self.webC2SSLSock.close()
                self.terminate()
                self.delIPs()
                return False
            except Exception, e:
                self.c2Server.errorString = "In WebConnectionThread: {}\n{}".format(str(e), traceback.format_exc())
                print self.c2Server.errorString
                # send the server the details...
                self.c2Server.state = main.States.ERROR
                try:
                    self.sendObject(self.c2Server)
                except Exception as e:
                    break
        try:
            self.sendObject(GOODBYE)
        except Exception as e:
            pass
        finally:
            self.webC2SSLSock.close()
            self.terminate()
            self.delIPs()
            return True

## Start the local socket to accept from the WebC2 server.
#  This reads the configuration file, and sets variables accordingly.
#  When a WebC2 connects, it will send an object instructing the RangeC2 how to behave and which network to operate on.
#  @param args taken from apiarium.conf
def run(args):

    euid = os.geteuid()
    if euid != 0:
        print("Please start this program as root.")
        sys.exit(1)

    # Set number of clients
    global NUM_CLIENTS
    NUM_CLIENTS = args['num_clients']

    global CORE_SW_INT
    global INET_INT

    CORE_SW_INT = args['range_apiarium_core_sw_interface']
    INET_INT = args['range_apiarium_inet_interface']


    # Change directory to this file's path.
    #print os.getcwd()
    newPath = os.path.dirname(os.path.realpath(__file__))
    #print newPath
    os.chdir(newPath)

    # Load all of the injects
    main.loadInjects()

    webConThread = WebC2Connection()
    try:
        while True:
            s = socket.socket()
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            #print HOST,PORT
            s.bind((HOST, PORT))
            s.listen(0)
            main.debug("Waiting for webC2 to connect.")
            newSocket, fromAddr = s.accept()
            
            # Don't run as a thread; there's no need to
            if not webConThread.handle(newSocket):
                break

            main.debug("WebConnectionThread stopped. Restarting.")
    except Exception as e:
        print("Exception:")
        traceback.print_exc()
    main.debug("Closing range...")
    webConThread.terminate()

if __name__ == '__main__':
    run(dict())
