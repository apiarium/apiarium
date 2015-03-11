import os
import shutil

MIRROR_DIR = '/mnt/wwwmirror'
APACHE_SITE_DIR = '/etc/apache2/sites-enabled'

confTemplate = """
<VirtualHost *:80>
 DocumentRoot /mnt/wwwmirror/$FILENAME
 ServerName www.$NAME
 ServerAlias $NAME
</VirtualHost> 
"""

with open('wwwmirror.conf','w') as confFile:
    for filename in os.listdir(MIRROR_DIR):
        NAME = filename.replace('www.','')   
        thisConf = confTemplate
        thisConf = thisConf.replace('$NAME',NAME)
        thisConf = thisConf.replace('$FILENAME',filename)
        confFile.write(thisConf)

shutil.copyfile('wwwmirror.conf',APACHE_SITE_DIR+'/wwwmirror')
os.remove('wwwmirror.conf')

os.system('service apache2 reload')
