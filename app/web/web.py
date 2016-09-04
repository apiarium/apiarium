#!/usr/bin/python -tt

## @package app.web
#

"""
    Library Imports
"""
import collections
import ConfigParser
import Cookie
import copy
import cPickle as pickle
import inspect
import json
import os
import Queue
import random
import re
import select
import socket
import struct
import sys
import threading
import time
import traceback
import uuid
import ssl
import base64
import datetime

from flask.ext.sqlalchemy import SQLAlchemy
from collections import OrderedDict
from pdb import set_trace as _DEBUG_BREAK
from SocketServer import ForkingMixIn, ThreadingMixIn
from urlparse import urlparse
import flask, json, logging, random, string, hashlib
from flask import Flask, request, session, flash, Response, make_response
from functools import update_wrapper
from functools import wraps
from OpenSSL import SSL

"""
    Local Imports
"""
from app import main 
from app.web import settings


"""
    Globals
"""
HTTP_NOT_IMPLEMENTED = 501
HTTP_NOT_FOUND = 404
HTTP_SERVER_ERROR = 500

USERNAME = "admin"
PASSWORD = "password"
## The global variable to store the c2Servers. This is accessible from any thread in the server
c2Servers = list()  
## A list of all of the created threads
threads = list()    
## A lock to be acquired during thread list operations, because Elliot wanted it
threadLock = main.ReadWriteLock() 


## Path variable to ensure our path is correct for templates
tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
## Path variable to ensure our path is correct for static pages
static_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'static')

##the flask instance
hFlask = Flask("web", template_folder=tmpl_dir, static_folder=static_dir)

# Set up sqlite...
hFlask.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///saved_injects.sqlite'
## SQLite database
db = SQLAlchemy(hFlask)


class InjectSave(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    json = db.Column(db.String(), unique=False)
    inject = db.Column(db.String(), unique=False)
    saveName = db.Column(db.String(), unique=True)

    def __init__(self, inject, saveName, json):
        self.json = json
        self.saveName = saveName
        self.inject = inject

    def __repr__(self):
        return '%r' % self.json

db.create_all()

# Make the logger easily accessable
logger = hFlask.logger

##  Setup WEBC2
#  @param conf configuration from config file
def run(conf):
    # SETUP WEBC2

    # change our path so we load files correctly
    os.chdir(os.path.dirname(os.path.realpath(__file__)))
    
    # ensure we can bind to port 443, etc
    euid = os.geteuid()
    if euid != 0:
        main.debug("Please run as root to bind to port 443.","yellow")
        sys.exit(1)
    
    main.debug("Starting C2 controller server on "+str(time.asctime()),"pink")
    settings.loadWebC2Config(conf)
    main.loadInjects()
    
    for c2 in c2Servers:
        thread = WebC2(c2)
        thread.start()

    # START FLASK
    main.debug("Starting webserver at :443 on %s" % (str(time.asctime())),"pink")
    # Set options for jinja
    hFlask.jinja_env.trim_blocks = True
    hFlask.jinja_env.lstrip_blocks = True
    hFlask.jinja_env.add_extension('jinja2.ext.do')

    hFlask.secret_key = ''.join([ random.choice( string.printable ) for x in range( 50 ) ] )

    context = SSL.Context(SSL.SSLv23_METHOD)
    cert_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','cert.pem')
    context.use_certificate_file(cert_path)
    context.use_privatekey_file(cert_path)

    hFlask.run(host='', port=443, debug=main.DEBUG, use_reloader=False, ssl_context=context)


def check_auth(username, password):
    """This function is called to check if a username /
    password combination is valid.
    """
    return username == USERNAME and password == PASSWORD


def authenticate():
    """Sends a 401 response that enables basic auth"""
    return Response(
    'apiarium', 401,
    {'WWW-Authenticate': 'Basic realm="Login Required"'})

def nocache(f):
    @wraps(f)
    def new_func(*args, **kwargs):
        resp = make_response(f(*args, **kwargs))
        resp.cache_control.no_cache = True
        resp.headers.add('Last-Modified', datetime.datetime.now())
        resp.headers.add('Cache-Control', 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0')
        resp.headers.add('Pragma', 'no-cache')
        return resp
    return update_wrapper(new_func, f)


def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth or not check_auth(auth.username, auth.password):
            return authenticate()
        return f(*args, **kwargs)
    return decorated

@hFlask.route('/')
@nocache
def startpage():
    """Default index routing function
       Returns:    
            A Page to the user depending on whether they're logged in.
            This check is done by calling :func:`isUserLoggedIn`
    """
    return flask.redirect( flask.url_for('dashboard') )


@hFlask.route('/dashboard')
@nocache
@requires_auth
def dashboard():
    """The primary landing page for the WebUI
        Note:
            If the user is not currently logged in, they are redirected to /login
    """
    ranges = c2Servers
    return flask.render_template('dashboard.html',
                                 ranges=ranges)


@hFlask.route('/dashboard_content')
@nocache
@requires_auth
def dashboard_content():
    ranges = c2Servers
    return flask.render_template('dashboard_content.html',
                                 ranges=ranges)


@hFlask.route('/injects')
@nocache
@requires_auth
def injects():
    """Start an inject/traffic page
    """
    injs = [module for module in main.modules]
    ranges = c2Servers
    return flask.render_template( 'injects.html', injects=injs, ranges=ranges)


@hFlask.route('/injects/save', methods=['GET','POST'])
@nocache
@requires_auth
def inject_save():
    d = {}
    for key, value in request.form.iteritems():
        if key != 'inject' and key != 'saveName':
            d[key] = value
    for key, value in request.files.iteritems():
        enc = base64.urlsafe_b64encode(value.read())
        d[key] = enc
    
    j = json.dumps(d)
    obj = InjectSave(request.form['inject'], request.form['saveName'], j)
    db.session.add(obj)
    db.session.commit()

    return flask.jsonify(d) #flask.redirect( flask.url_for('dashboard') )

@hFlask.route('/injects/stoptraffic', methods=['POST'])
@nocache
@requires_auth
def stop_traffic():
    args = {}
    for key, value in request.form.iterlists():
        args[key] = value

    if 'range' in args:
        if args['range'][0] != "":
            thread = getRangeThreadByName(args['range'][0])
            thread.c2.errorString = ""
            thread.c2.state = main.States.RUNNING
            for c in thread.c2.clients:
                for inj in c.injects:
                    if 'Traffic Gen' in inj.name:
                        i = main.RemoveInject()
                        i.range = args['range'][0]
                        i.workstation = c.hostname
                        i.targetId = inj.id
                        dispatchInjectToRange(i)
        return flask.jsonify({'status':'success'})
    return flask.jsonify({'status':'fail'})

@hFlask.route('/injects/remove', methods=['POST'])
@nocache
@requires_auth
def inject_remove():
    args = {}
    for key, value in request.form.iterlists():
        args[key] = value

    cleanup = False

    if 'id' in args and 'range' in args and 'client' in args:
        cleanup = False

        i = main.RemoveInject()
        i.targetId = args['id'][0]

        if i.targetId == '':
            i.targetId = None
            # This means that they hit the cleanup button
            cleanup = True
        else:
            i.targetId = int(i.targetId)

        i.range = args['range'][0]
        if len(i.range) > 0 and cleanup:
            thread = getRangeThreadByName(i.range)
            thread.c2.errorString = ""
            thread.c2.state = main.States.RUNNING

        i.workstation = args['client'][0]
        dispatchInjectToRange(i)

        return flask.jsonify({'status':'success'})

    return flask.jsonify({'status':'fail'})

@hFlask.route('/injects/stop', methods=['POST'])
@nocache
@requires_auth
def inject_stop():
    args = {}
    for key, value in request.form.iterlists():
        args[key] = value

    if 'id' in args and 'range' in args and 'client' in args:
        i = main.StopInject()
        i.targetId = int(args['id'][0])
        i.range = args['range'][0]
        i.workstation = args['client'][0]
        dispatchInjectToRange(i)

        return flask.jsonify({'status':'success'})

    return flask.jsonify({'status':'fail'})

@hFlask.route('/injects/run', methods=['POST'])
@nocache
@requires_auth
def inject_run():
    args = {}
    # Collapse everything in the dictionary
    for key, value in request.form.iterlists():
        print key, value
        args[key] = value

    # Get the file parameters
    for key, value in request.files.iteritems():
        enc = base64.urlsafe_b64encode(value.read())
        args[key] = enc
    # Deal with the pesky hack for saved things
    for k in args.keys():
        if k.endswith('_FILE_TEXT'):
            args.pop(k)
        if k.endswith('_FILE_HIDDEN'):
            args[k.replace('_HIDDEN','')] = args[k]
            args.pop(k)

    # Get the ranges
    ranges = args['ranges']
    args.pop('ranges')

    tmp = {}
    for key, val in args.iteritems():
        if len(val) == 1:
            tmp[key] = val[0]
        else:
            tmp[key] = val
    args = tmp

    # Get the inject
    inject = args['inject']
    args.pop('inject')

    # Get the workstation, if any
    workstation = args.get('src_ws')
    if 'src_ws' in args:
        args.pop('src_ws')

    inject = getInjectByName(inject).getName()

    for rangeName in ranges:
        # Make the inject
        i = main.Inject()
        i.name = inject
        i.range = rangeName
        i.workstation = workstation
        i.args = args

        # dispatch to the thread
        if dispatchInjectToRange(i):
            flask.flash('Inject launched. Check the dashboard for the status.','success')
        else:
            flask.flash('Something went wrong!','error')
    return flask.jsonify({})
    

@hFlask.route('/injects/form/<inject>', methods=['POST','GET'])
@nocache
@requires_auth
def inject_form(inject):
    """Also needs a 'checkedRanges[]' parameter that is an
    array of range names selected
    """
    if 'saveID' in request.args:
        saveID = request.args['saveID']
        saved = InjectSave.query.get(saveID).json
        return saved

    inj = getInjectByName(inject)

    # Make a list of all ips available from all IPPools
    ranges = request.args.getlist('checkedRanges[]')

    ips = []
    for c2 in c2Servers:
        if len(ranges) > 0:
            if c2.rangeName in ranges:
                ips += c2.c2IPPool
        else:
            ips += c2.c2IPPool

    ips = list(set(ips))
    ips.sort()

    saved = InjectSave.query.filter_by(inject=inject)
    saved = [(s.id,s.saveName) for s in saved]

    return flask.render_template( 'injects_form.html',
            inject=inj,
            workstations=main.workstations,
            ips=ips,
            saved=saved)


@hFlask.route('/logs')
@nocache
@requires_auth
def logs():
    """View all of the event logs page
    """
    events = []
    return flask.render_template( 'logs.html', events=events )


@hFlask.route('/inject/<ID>')
@nocache
@requires_auth
def inject_info(ID):
    return flask.render_template('show_inject.html', inject=None)


@hFlask.route('/client/<ID>')
@nocache
@requires_auth
def client_info(ID):
    return flask.render_template('show_client.html', client=None)


@hFlask.route('/range/<ID>')
@nocache
@requires_auth
def range_info(ID):
    return flask.render_template('show_range.html', simulator=None)


def getInjectByName(injName):
    print 'looking for:',injName
    for each in main.modules:
        print '\t',each.getHTMLName()
        if each.getHTMLName() == injName:
            return each
    return None


def dispatchInjectToRange(objectToSend):
    """ Places objectToSend in a range's message queue. This can only be used on objects that contain a 'range' member variable. """
    found = False
    thread = getRangeThreadByName(objectToSend.range)
    if thread:
        thread.queue.put(objectToSend)
        return True
    else:
        threadLock.acquire_read()
        for thread in threads:
            if isinstance(thread, WebC2):
                thread.queue.put(objectToSend)
        threadLock.release_read()
    return False


def getRangeThreadByName(name):
    threadLock.acquire_read()
    for thread in threads:
        if isinstance(thread, WebC2):
            if thread.c2.rangeName == name:
                threadLock.release_read()
                return thread
    threadLock.release_read()
    return None


@hFlask.after_request
def add_header(response):
    """
    Add headers to both force latest IE rendering engine or Chrome Frame,
    and also to cache the rendered page for 0 minutes.
    """
    response.headers['X-UA-Compatible'] = 'IE=edge,chrome=1'
    return response


"""
    Functions to export to templates
"""
@hFlask.context_processor
def utility_processor():
    def length(item):
        return len(item)

    def gettime():
        return time.strftime("%H:%M:%S")

    def stateToColorName(state):
        #  RUNNING, STOPPED, WAITING, UNKNOWN, ERROR = range(5)
        if state == main.States.RUNNING:
            return ['success','RUNNING','green']
        elif state == main.States.STOPPED:
            return ['warning',"STOPPED",'red']
        elif state == main.States.WAITING:
            return ['info',"WAITING",'yellow']
        elif state == main.States.UNKNOWN:
            return ['default',"UNKNOWN",'black']
        elif state == main.States.ERROR:
            return ['danger',"ERROR",'red']
        return ['default',"UNKNOWN",'black']

    def str_slice(item, start, end=None, step=1):
        if end == None:
            end = len(item)
        return item[start:end:step]

    def str_fancy(string):
        return string.replace('_',' ').replace('OPTION','').strip().capitalize()

    return dict(stateToColorName=stateToColorName,
            length=length,
            time=gettime,
            str_slice=str_slice,
            str_fancy=str_fancy
            )

if __name__ == '__main__':
    run()



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
            time.sleep(0.3)
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
                try:
                    self.SSLSock.close()
                except:
                    pass
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
                        main.debug("WebC2: Sending {} to {}".format(
                            obj.name, obj.range),"light_blue")
                        if self.sendObject(obj) == False:
                            raise UserWarning("Could not send inject request to range.")

                    elif isinstance(obj, main.RemoveInject):
                        main.debug("Removing inject {} on {}".format(obj.targetId, obj.workstation),"yellow")
                        # Start the process to kill the process and send it to the range
                        if self.sendObject(obj) == False:
                            raise UserWarning("Could not send a remove inject request to the range.")

                    elif isinstance(obj, main.StopInject):
                        # Start the process to kill the process and send it to the range
                        if self.sendObject(obj) == False:
                            raise UserWarning("Could not send a remove inject request to the range.")

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
                                #self.debugRangeStatus(data)

                                # figure out inject differences
                                c2.injects = data.injects

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
                                for oldClient in list(c2.clients):
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
                                                            oldInj.update(newInj)
                                                            break
                                                    if not injFound:
                                                        main.debug("Added new inject","light_blue")
                                                        oldClient.injects.append(newInj)
                                                #remove any ghosts
                                                for oldI in list(oldClient.injects):
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
                for c in list(self.c2.clients):
                    self.c2.clients.remove(c)
                for i in list(self.c2.injects):
                    self.c2.injects.remove(i)

                newThread = WebC2(self.c2)
                threadLock.acquire_write()
                for thread in list(threads):
                    if thread.c2.rangeName == self.c2.rangeName:
                        threads.remove(thread)
                        break
                threadLock.release_write()
                time.sleep(10)
                newThread.start()
                return
            except Exception as e:
                main.debug(e,"red")
                traceback.print_exc()
                self.c2.state = main.States.ERROR
                self.c2.errorString = "Error in webC2: "+str(e)+'\n'+traceback.format_exc()

