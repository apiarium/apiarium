## @package app.main
#  @brief This class houses all of the main data structures and methods that all components will use.
#


import threading
import datetime
import struct
import socket
import random
import imp
import glob
import os
import sys
from collections import OrderedDict


"""
Globals
"""
## @var modules 
#  A list of all the inject modules.
modules = []
## @var workstations 
#  A list of all the workstations populated from workstations.txt.
workstations = []
## @var DEBUG
#  Toggles debugging output.
DEBUG = False
## @var LOGFILE
#  Specifies the location of the logfile.
#  default value is /var/log/apiarium.log
#  SHOULD BE DEFINED IN CONFIG FILE
LOGFILE = None

## Helper function to populate the modules and workstations global variables.
#   This will fill the "modules" list with all of the inject modules.
#   These modules are module objects (not strings), so you can look into their contents. 
#   This will also populate the workstations list with the names of all of the workstations.

def loadInjects():
    
 
    global modules, workstations
    
    # Load the injects
    curdir = os.getcwd()
    os.chdir('../injects')
    sys.path.insert(0, '.')
    for each in glob.glob('*.py'):
        pyName = os.path.basename(each).replace('.py','')
        mod = Module(imp.load_source(pyName,each))
        
        # if it's a valid module, it will have a class named the same
        if mod.getInjectClass():
            modules.append(mod)
    sys.path.pop(0)
    os.chdir(curdir)

    # Load the workstations
    d = []
    with open('../workstations.txt') as f:
        for line in f.read().split('\n'):
            if len(line) > 0:
                d.append(line.split(' '))
    
    workstations = dict(d)
## Wrapper for inject modules.
class Module():
    ## The Constructor.
    #  @param mod the module to be wrapped.
    def __init__(self, mod):
        self.__mod__ = mod

    ## self.getName().
    def __getitem__(self,index):
        if index == "__getname__":
            return self.getName()
        else:
            return ""

    ## Gets module class name.
    def getInjectClass(self):
        return getattr(self.__mod__, self.__mod__.__name__.replace('.py',''), None)
    ## Boolean check to see if module is range.
    def isRange(self):
        return True if getattr(self.getInjectClass(), 'range', False) else False
    ## Boolean check to see if module is client.
    def isClient(self):
        return True if getattr(self.getInjectClass(), 'client', False) else False
    ## ??? not sure what it is returning.
    def canSave(self):
        return 'canSave' in vars(self.getInjectClass()())
    ## Gets variables.
    def getVars(self):
        d = self.getInjectClass()().variables
        return d
    ## Gets name.
    def getName(self):
        return self.getInjectClass()().name
    ## Gets HTML name. 
    #  replaces spaces in name with underscores
    def getHTMLName(self):
        return self.getInjectClass()().name.replace(' ','_')
    ## Gets module description.
    def getDesc(self):
        return self.getInjectClass()().description

## Print debugging information into log file. 
#  This method was created to help if a log were to be used.
def debug(string, color="default"):
    
    global DEBUG
    global LOGFILE
    if DEBUG:
        option = {"gray" : "\033[90m{0}\033[0m",
                  "grey" : "\033[90m{0}\033[0m",
                  "red" : "\033[91m{0}\033[0m",
                  "green" : "\033[92m{0}\033[0m",
                  "yellow" : "\033[93m{0}\033[0m",
                  "blue" : "\033[94m{0}\033[0m",
                  "pink" : "\033[95m{0}\033[0m",
                  "light_blue" : "\033[96m{0}\033[0m",
                  "white" : "\033[97m{0}\033[0m",
		  "default" : "{0}"
                }
        if color not in option:
           color = "default"

        print(option[color].format(string))
    else:
        if LOGFILE == None:
            LOGFILE = open('/var/log/apiarium.log','a')
        LOGFILE.write(str(datetime.datetime.now()))
        LOGFILE.write(': ')
        LOGFILE.write(string)
        LOGFILE.write('\n')
        LOGFILE.flush()
## Various statues to be used for error handling, etc.
class States():
    RUNNING, STOPPED, WAITING, UNKNOWN, ERROR = range(5)

## Used to store messages
#  used mainly on the range 
class ErrorMessage(object):
    def __init__(self):
	self.injectId = ""
	self.webC2Message = ""
	self.rangeC2Message = ""
	self.clientMessage = ""

## A client class. Contains all things a client needs
class Client(object):
    def __init__(self):
        self.ip = ""    # The ip we connect to it via (eth0 on the docker instance)
        self.intIP = "" # The ip in the range (eth1 on the docker instance)
        self.hostname = ""
        self.mac = ""
        self.injects = []
        self.state = States.UNKNOWN
        self.errorString = ""
        self.dSID = ""
    def getInjectByKey(self, id):
        for inject in self.injects:
            if inject.id == id:
                return inject
        return None

## given an inject, returns the module with the matching name.
#  @param inject The inject needing to be looked up.
def moduleFromInject(inject):
    for module in modules:
        if module.getName() == inject.name:
            return module
    return None

## Stores everything relavant to an inject running on a client.
#  An data structure for injects.
class Inject(object):
    
    ## The constructor.
    def __init__(self):
        ## The name of the range that the inject has been run on.
        self.range = ""
        ## The name of the workstation that the inject has been run on.
        self.workstation = ""
        ## The name of the inject.
        self.name = ""
        ## A unique id of the inject.
        #  It is generated in this constructor
        self.id = id(self)
        ## The state of the inject.
        #  The different states can be found in the "States" module.
        self.state = States.UNKNOWN
        ## Error flags
        self.errorString = ""
        ## The Process ID of the inject
        self.pid = 0
        self.args = {}

    ## Used whenever a higher power in the chain needs an update from someone below.
    #  @param inj a given inject
    def update(self, inj):
        for key, val in inj.__dict__.iteritems():
            self.__dict__[key] = val

## The command sent when an inject needs to be stopped. 
#  This does not delete it from memory.
#  Note!!! This class is identical to RemoveInject(object) even though it claims to be different
class StopInject(object):
    ##The constructor.
    # The target range, workstation, and targetID are returned to default values
    def __init__(self):
        ## The name of the range the inject is assigned to.
        self.range = ""
        ## The name of the workstation the inject is assigned to.
        self.workstation = ""
        ## Id of target
        self.targetId = 0

## This command will stop and remove an inject.
#  Note!!! This class is identical to StopInject(object) even though it claims to be different
class RemoveInject(object):
    def __init__(self):
        ## The name of the range the inject is assigned to.
        self.range = ""
        ## The name of the workstation the inject is assigned to.
        self.workstation = ""
        ## Id of target
        self.targetId = 0

##  This object is sent whenever a higher power in the chain needs an update from someone below.
class UpdateRequest(object):
   
    def __init__(self):
        pass

## This structure describes a Range Command and Control instance. 
class C2(object):
    ## The Constructor
    def __init__(self):
        ## The state of the C2 instance.
        #  The different states can be found in the "States" module.
        self.state = States.UNKNOWN
        ## Error flags
        self.errorString = ""

        # Information from the config file:
        self.rangeName = ""
        self.clients = list()
        self.injects = list()
        self.c2Interface = ""
        self.clientInterface = ""
        self.c2ExternalIP = ""
        self.c2InternalIP = 0
        self.c2InternalPort = ""
        self.c2IPPool = []
        self.aliasInfo = []
## A lock object that allows many simultaneous 'read-locks', but only one 'write-lock'.
class ReadWriteLock(object):
    ## The constructor
    def __init__(self):
	self._read_ready = threading.Condition(threading.Lock())
	self._write_ready = threading.Condition(threading.Lock())
	self._readers = 0

    ## Acquire read-lock. Blocks iff thread has write_lock
    def acquire_read(self):
	self._write_ready.acquire()
	self._read_ready.acquire()
	try:
	   self._readers += 1
	finally:
	   self._read_ready.release()
	   self._write_ready.release()

    ## release a read-lock
    def release_read(self):
	
	self._read_ready.acquire()
	try:
	   self._readers -= 1
	   if not self._readers:
	      self._read_ready.notifyAll()
    	finally:
	   self._read_ready.release()

    ## Acquire write-lock. Blocks until there are no acquired read or write locks
    def acquire_write(self):
	
	self._write_ready.acquire()
	self._read_ready.acquire()
	while self._readers > 0:
	   self._read_ready.wait()

    ## Release a write-lock
    def release_write(self):
	
	self._read_ready.release()
	self._write_ready.release()



if __name__=='__main__':
    print "Sorry for the misnomer! Run webC2.py, rangeC2.py, or clientC2.py instead..."
