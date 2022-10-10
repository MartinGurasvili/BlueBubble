# Import all the email providers here
from .providers.Gmail import Gmail
from .providers.Hotmail import Hotmail
from .providers.Yahoo import Yahoo
from .providers.Aol import Aol
from .providers.iCloud import iCloud

from .exception import UnknownProvider

class Mailer:

    def __init__(self, user, password, provider):
        """ 
            Providers in a dictionary with value of class name
        """
        providers = {
            'gmail': 'Gmail',
            'googlemail': 'Gmail',
            'hotmail': 'Hotmail',
            'outlook': 'Hotmail',
            'live': 'Hotmail',
            'yahoo': 'Yahoo',
            'ymail': 'Yahoo',
            'yahoomail': 'Yahoo',
            'aol': 'Aol',
            'icloud': 'iCloud',
        }
        try:
            # Initialising the email provider class
            self.service = eval(providers[provider])(user, password)
        except:
            # If the email provider doesn't exist in our providers
            raise UnknownProvider(provider + ' is an unknown email provider to us. Open an issue on github to add this provider')

    def sendMsg(self, to, sub, msg):
        # Sending the email using the respective email provider
        response = self.service.send(to, sub, msg)
