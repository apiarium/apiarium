#!/usr/bin/python -tt
import os
import subprocess
import re
import threading
import traceback
import socket
import select
import json
import time

import app.main as main

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
DHCP_FILE = os.path.join(SCRIPT_DIR,"workstations.txt")

RANGE_DNS = "172.16.60.21"

# def log_calls_decorator(f):
#    def wrapped(*args, **kwargs):
#        call_string = "%s called with *args: %r, **kwargs: %r " % (f.__name__, args, kwargs)
#        try:
#            retval = f(*args, **kwargs)
#            call_string += " --> " + repr(retval)
#            print call_string
#            return retval
#        except Exception, e:
# top = traceback.extract_stack()[-1]   # get traceback info to print out later
#            call_string += " RAISED EXCEPTION: "
#            call_string += ", ".join([type(e).__name__, os.path.basename(top[0]), str(top[1])])
#            call_string += traceback.format_exc()
#            call_string += '\n--------------------'
#            print call_string
#            raise
#    return wrapped

def clean():
    main.debug("Cleaning up old docker images...")
    d = Docker('eth0')
    d._run('sudo docker ps -a -q | sudo xargs docker rm', None)
    main.debug("Done.")

## Telnet Terminal emulator
class RawTelnet():
    def __init__(self):
        self.s = socket.socket()
        self.prompt = ":/# "

    def connect(self,address, retry=True):
        try:
            self.s.connect(address)
            self.get_prompt()
        except socket.error as e:
            if retry:
                if e.errno == 111:
                    time.sleep(3)
                    self.connect(address, retry=False)
            else:
                raise e

    def execute(self, cmd):
        self._send(cmd+'\n')
        data = self.get_prompt()

        # cut the last line out (the prompt)
        data = '\n'.join(data.split('\n')[1:-1])

        self._send('echo $?\n')
        retval = self.get_prompt()
        retval = '\n'.join(retval.split('\n')[1:-1])

        return (data, retval)

    def close(self):
        self._send('exit\n')
        self.s.close()

    def get_prompt(self):
        data = self._recv_until(self.prompt)
        return data

    def _send(self,data):
        length = self.s.sendall(data)
        return True if length == len(data) else False

    def _recv_until(self,data):
        recvd = ""
        while data not in recvd:
            recvd += self.s.recv(1024)
        return recvd

class DockerInst(object):

    def __init__(self):
        self.sID = ""
        self.hostname = ""
        self.mac = ""
        self.ip = ""


class TimeoutException(Exception):

    def __init__(self):
        pass


class Docker(object):

    def __init__(self, bridge_eth, image='ephor', num_clients=0, kill_old=True):
        """
        bridge_eth = the interface on which to put the docker instances
        image = the name of the image that will be controlled/modified by this
        """
        self.image = image
        self.eth = bridge_eth
        self.dhcpClients = []

        # Kill the stupid masquerade iptables rule
        try:
            subprocess.check_output('iptables -t nat -D POSTROUTING -s 172.17.0.0/16 ! -d 172.17.0.0/16 -j MASQUERADE'.split(' '))
            subprocess.check_output('iptables -D FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT'.split(' '))
            subprocess.check_output('iptables -D FORWARD -i docker0 ! -o docker0 -j ACCEPT'.split(' '))
            subprocess.check_output('iptables -D FORWARD -i docker0 -o docker0 -j ACCEPT'.split(' '))
        except:
            pass
        
        # set up the docker image if it hasn't been done
        setup = False
        images = subprocess.check_output(['docker', 'images', 'ephor'])
        for line in images.split('\n')[1:]:
            if line.startswith('ephor'):
                setup = True
                break
        if not setup:
            print("Initializing ephor docker image...")
            subprocess.call(['docker', 'build', '--no-cache', '-t', 'ephor',
                            os.path.join(SCRIPT_DIR, 'client', '.')])

        # ensure udhcpc is installed
        if subprocess.check_output(['which', 'udhcpc']) == '\n':
            print("ERORR! Please install udhcpc!")
            sys.exit(1)

        # stop all of the old ones
        if kill_old:
            self.stop()
        
        # Create a list of tuples in the form of [(mac,hostname),
        # (mac,hostname), ...]
        num_of_clients = num_clients

        if num_of_clients == 0:
            num_of_clients = 100

        self.dhcpClients = []
        done = False
        with open(DHCP_FILE, 'r') as fp:
            for num, line in enumerate(fp.read().split('\n')):
                if int(num) >= int(num_of_clients):
                    done = True
                    break
                if line != "" and not done:
                    hostname, mac = line.split(' ')[:2]
                    self.dhcpClients.append((mac, hostname))


    class Command(object):

        def __init__(self, cmd):
            self.cmd = cmd
            self.process = None
            self.retval = None

        def _run_with_timeout(self, timeout):
            def target():
                self.process = subprocess.Popen(
                    self.cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
                self.retval = self.process.communicate()

            thread = threading.Thread(target=target)
            thread.daemon = True
            thread.start()

            thread.join(timeout)
            if thread.is_alive():
                try:
                    print("---Terminating process due to timeout.")
                    self.process.terminate()
                    thread.join(1)
                    self.process.kill()
                except:
                    pass
                # TODO: find a way to kill this process that won't die
                # thread.join()
                raise TimeoutException()
            return self.retval

    def _run(self, cmd, timeout=10):
        if isinstance(cmd, list):
            cmd = ' '.join(cmd)  # cmd.split(' ')
        command = Docker.Command(cmd)
        ret = command._run_with_timeout(timeout)
        if ret is None:
            raise Exception(
                "Timed out on Popen('{}'...)".format(' '.join(cmd)))
            return [None, None]
        return ret

    def _run_in_inst(self, cmd, sID, timeout=5):
        # paramiko implementation:
        ##if isinstance(cmd, str):
        ##    cmd = cmd.split(' ')
        ##cmd = ['lxc-attach', '-n', sID] + cmd
        #client = paramiko.SSHClient()
        #ip = self._get_Int_IP(sID)
        ##client.connect(self._get_Int_IP(sID))
        #client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        #client.connect(ip, username='root', password='password', look_for_keys=False)
        #stdin, stdout, stderr = client.exec_command(cmd)
        #stdout = stdout.read()
        #stderr = stderr.read()
        s = RawTelnet()
        ip = self._get_int_IP(sID)
        s.connect((ip, 23))
        #main.debug('Executing {} in {}.'.format(cmd, ip), 'red')
        data = s.execute(cmd)
        #main.debug('Output: {}'.format(data),'red')
        ret = []
        ret.append(data[0])

        if data[1] != '0':
            ret.append('Error! The command returned '+data[1])
        else:
            ret.append('')
        s.close()
        return ret

    def _get_int_IP(self, sID):
        #return self._docker_cmd("inspect "+sID+" | grep IPAddress")[0].split(
        return subprocess.check_output('sudo docker inspect '+
                sID+
                ' | grep IPAddress',
                shell=True).split('": "')[1].split('"')[0]

    def _docker_cmd(self, cmd, timeout=10):
        cmd = '/usr/bin/docker ' + cmd
        return self._run(cmd, timeout)

    def start(self, mac, hostname):
        pipework_path = os.path.join(SCRIPT_DIR, 'client', 'pipework')

        dockerID, stderr = self._docker_cmd('run --dns={} -d {}'.format(
                                            RANGE_DNS, self.image), timeout=15)
        dockerID = dockerID.strip()
        if len(stderr) != 0 or len(dockerID) == 0:
            if not "8.8.8.8" in stderr:
                print stderr
                raise Exception(
                    'Could not start docker instance. Error with docker run.')

        # pipework <interface> $(docker run -d ephor) dhcp <hostname> <mac>
        pipework_cmd = '{} {} {} dhcp {} {}'.format(
            pipework_path,
            self.eth,
            dockerID,
            hostname,
            mac)

        stdout, stderr = (None, None)
        # Start the docker instance
        try:
            stdout, stderr = self._run(pipework_cmd, 10)
        except TimeoutException as e:
            # TODO: handle this. it probably timed out on creation due to the
            #      the dhcp failing
            self.stop(dockerID)
            raise Exception(
                "Could not start client. Check your dhcp server; it probably is not handing out leases.")

        if len(stderr) != 0:
            for line in stderr.split('\n'):
                if not line.startswith('SIOC') and len(line) > 0:
                    raise Exception('Could not start docker instance. '
                                    'Error with pipework: {}.'.format(line))

        main.debug('Started client with mac %s.' % (mac), 'blue')
        
        return True

    def stop(self, sID=""):
        if sID == "":
            sIDs = self.getSIDs()
        else:
            sIDs = [sID]
        for sID in sIDs:
            main.debug("Stopping {}".format(sID), 'yellow')
            #stdout, stderr = self._run_in_inst('/sbin/dhclient -r eth1', sID)

            # if len(stderr) != 0:
            #    raise Exception("Could not release docker instance's IP ({}).".format(sID))

            stdout, stderr = [None, None]
            stdout, stderr = self._docker_cmd('kill {}'.format(sID), timeout=5)
            # try:
            #    stdout, stderr = self._docker_cmd('stop {}'.format(sID),timeout=5)
            # except TimeoutException:
            #    stdout, stderr = self._docker_cmd('kill {}'.format(sID),timeout=3)
            # if len(stderr) != 0:
            #    raise Exception("Could not stop docker instance {}.".format(sID))

    def getSIDs(self):
        stdout, stderr = self._docker_cmd('ps --no-trunc')
        containers = list()
        for each in stdout.split('\n')[1:-1]:
            m = re.search('^[a-fA-F0-9]+', each)
            if m:
                tmp = DockerInst()
                tmp.sID = m.group(0)
                containers.append(tmp)
        return [inst.sID for inst in containers]

    def getInstances(self):
        """
        Return a list of DockerInst objects representing the ones currently running.
        """
        containers = self.getSIDs()
        ret = list()
        for sID in containers:
            # eth1 in the container is always the pipework interface
            stdout, stderr = self._run_in_inst('/sbin/ip a show dev eth1',
                                               sID, 1)
            if len(stderr) != 0:
                pass
                #self.stop(sID)
                #if sID in self.getSIDs():
                #    # If we tried to kill it but it's still in the list of
                #    # containers, exception
                #    raise Exception(
                #        'Error inspecting contents of container. Stderr: {}.'.format(stderr))

            tmp = DockerInst()
            tmp.sID = sID

            m = re.search('inet ([0-9\./]+) brd', stdout)
            if m:
                tmp.ip = m.group(1)
            m = re.search('link/ether ([0-9a-fA-F\:]+) brd', stdout)
            if m:
                tmp.mac = m.group(1)

            ret.append(tmp)
        return ret

    def remove_clients(self):
        """
        remove all of the clients
        """
        self.stop()

    def make_clients(self,timeout=10):
        """Add all of the clients
        """
        for mac, hostname in self.dhcpClients:
            self.start(mac, hostname)
        time.sleep(3)
        self.get_missing_clients(True)

    def make_missing_clients(self):
        """Make all of the clients if some died or something
        """
        if len(self.missing) == 0:
            self.get_missing_clients()
        if len(self.missing) > 0:
            # make them
            for each in self.missing:
                self.start(each.mac, each.hostname)
            self.get_missing_clients(True)
    
    def get_missing_clients(self, throw_exception=False):
        """
        Returns a list of the missing clients or None
        throw_exception: True if this should raise an exception instead of
                         returning the list
        """
        # Ensure all of those containers are running still.
        self.containers = self.getInstances()
        if len(self.containers) != len(self.dhcpClients):
            started = list(set([inst.mac for inst in self.containers]))
            needed = list(set([mac[0] for mac in self.dhcpClients]))
            #extra = [inst.mac for inst in self.containers
            #         if inst.mac not in dict(self.dhcpClients)]

            missingMACs = list(set(needed) - set(started))
            print "Missing {} machines.".format(len(missingMACs))

            lookupTable = dict(self.dhcpClients)
            #self.missing = [ [mac, lookupTable[mac]] for mac in missingMACs ]
            self.missing = []

            for mac in missingMACs:
                tmp = DockerInst()
                tmp.mac = mac
                tmp.hostname = lookupTable[mac]
                self.missing.append(tmp)

            if throw_exception:
                raise Exception(
                    "Not all clients are running. "
                    "Missing MACs/workstations: {}.".format(
                        json.dumps(self.missing)))
            return self.missing
        return None
    
    def get_client_info(self):
        self.containers = self.getInstances()
        for each in self.containers:
            if each.hostname == "":
                lookup = dict(self.dhcpClients)
                if each.mac in lookup:
                    each.hostname = lookup[each.mac]
        return self.containers

if __name__ == '__main__':
    pass
    #import sys

    #a = Docker('eth0')
    #print a.getSIDs()
    #print "Stopping old instances."
    #for inst in a.getInstances():
    #    a.stop(inst.sID)

    #sys.exit(1)

    #print "Starting 5 instances."
    #for i in xrange(5):
    #    a.start()

    #insts = a.getInstances()
    #assert len(insts) == 5
    #for i, inst in enumerate(insts):
    #    print "Instance {}: ".format(str(i))
    #    print inst.mac
    #    print inst.ip
    #for i, inst in enumerate(insts):
    #    print "Stopping instance {}.".format(str(i))
    #    a.stop(inst.sID)
