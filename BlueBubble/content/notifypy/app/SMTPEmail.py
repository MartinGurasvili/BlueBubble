import email
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from ..app.ProviderInterface import ProviderInterface

class SMTPEmail(ProviderInterface):

    def __init__(self, user, password):
        self.user = user
        self.password = password
        self.host = ''
        self.port = 587
    
    def send(self, to, sub, msg):

        #Initialise message and headers
        message = MIMEMultipart('alternative')
        message['From'] = self.user
        message['To'] = to
        message['Subject'] = sub

        # Converts and attaches the HTML message
        html_msg = MIMEText(msg, 'html')
        message.attach(html_msg)

        # Initialise the connection and login user
        s = smtplib.SMTP(self.host, self.port)
        s.ehlo()
        s.starttls()
        s.ehlo()
        s.login(self.user, self.password)

        # Sends the email
        s.sendmail(self.user, to, message.as_string())
        s.quit()
        return True