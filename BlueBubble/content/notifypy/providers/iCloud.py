from ..app.SMTPEmail import SMTPEmail

class iCloud(SMTPEmail):

    def __init__(self, user, password):
        self.user = user
        self.password = password
        self.host = 'smtp.mail.me.com'
        self.port = 587