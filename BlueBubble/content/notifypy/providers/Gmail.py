import gmail
from ..app.ProviderInterface import ProviderInterface

class Gmail(ProviderInterface):
    def __init__(self, user, password):
        # sender class
        self.sender = gmail.GMail(user, password)

    def send(self, to, sub, msg):
        message = gmail.Message(sub, to, html=msg)
        # check if not connected then connect
        if not self.sender.is_connected():
            self.sender.connect()
        # send email
        self.sender.send(message)

        return True