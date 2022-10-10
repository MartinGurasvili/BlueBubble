from ..app.SMTPEmail import SMTPEmail

class Aol(SMTPEmail):

    def __init__(self, user, password):
        self.user = user
        self.password = password
        self.host = 'smtp.aol.com'
        self.port = 587