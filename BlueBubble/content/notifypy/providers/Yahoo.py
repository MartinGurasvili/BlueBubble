from ..app.SMTPEmail import SMTPEmail

class Yahoo(SMTPEmail):

    def __init__(self, user, password):
        self.user = user
        self.password = password
        self.host = 'smtp.mail.yahoo.com'
        self.port = 465