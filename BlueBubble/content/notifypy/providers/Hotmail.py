from ..app.SMTPEmail import SMTPEmail

class Hotmail(SMTPEmail):

    def __init__(self, user, password):
        self.user = user
        self.password = password
        self.host = 'smtp.live.com'
        self.port = 587