import random
import struct
import socket

from app import main
import app.web.web

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
 
    app.web.web.PASSWORD = conf['basic_auth_password']
    app.web.web.USERNAME = conf['basic_auth_username']
    PC_IP_Ranges = conf['pc_ips']
    IPs_Per_Range = int(conf['num_pc_ips'])
    pc_ips = getRandomIPs(PC_IP_Ranges, IPs_Per_Range) 
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
        app.web.web.c2Servers.append(cc2)

