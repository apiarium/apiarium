# This will be used to make the client docker app
FROM stackbrew/ubuntu
#CMD \
    #chmod +x /opt/pipework && \
    #/opt/pipework --wait && \
    #python /opt/client.py

ADD . /opt
ADD ./injects /opt/injects

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y xinetd python2.7 \ 
    python-pip python-dev libldap2-dev libsasl2-dev # required for python-ldap

RUN pip install python-ldap

RUN echo 'root:password' |chpasswd

EXPOSE 23
CMD (/opt/pipework --wait); (python /opt/client.py)
