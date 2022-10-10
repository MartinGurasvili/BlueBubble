from .notify import Notify
from .mailer import Gmail

def sendNoti(user, passwd, to, title, message = None, provider = 'none', notification_type = 'none', twilio_keys = {}):
    noti = Notify(user, passwd, provider)
    if notification_type == 'mail':
        noti.sendNotification(to, title, message, notification_type)
    elif notification_type == 'sms':
        noti.sendNotification(to, title, message, notification_type, twilio_keys = twilio_keys)
