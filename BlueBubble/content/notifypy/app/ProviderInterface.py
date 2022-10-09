from abc import ABCMeta
from abc import abstractmethod 

class ProviderInterface():
    @abstractmethod
    def __init__(self, user, password):
        pass
    @abstractmethod
    def send(self, to, sub, msg):
        pass
