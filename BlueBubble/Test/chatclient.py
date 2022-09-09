from re import T
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from cryptography.fernet import Fernet
from random import randint
import time
import os
import subprocess

from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor


class Server(DatagramProtocol):
    def __init__(self):
        self.clients = set()
    def datagramReceived(self,datagram,addr):
        datagram = datagram.decode('utf-8')
        if datagram =="ready":
            addresses = "\n".join([str(x) for x in self.clients])
            # self.transport.write(addresses.encode('utf-8'), addr)
            self.transport.write("yo".encode('utf-8'), addr)
            self.clients.add(addr)
        print(datagram)      
        

class Client(DatagramProtocol):
    
    def __init__(self,host,port):
        if host == "localhost":
            host = "127.0.1.1"
        self.h = host
        self.f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
        self.id = host,port
        self.address = None
        self.server = "127.0.1.1",9999
        print("Working on id:",self.id)
        

    def startProtocol(self):
        time.sleep(1)
        self.transport.write("ready".encode('utf-8'),self.server)

    def datagramReceived(self,datagram,addr):
        if addr ==self.server:
           
            if(port ==12345):
                self.address = self.h,12354
            else:
                self.address = self.h,12345
            reactor.callInThread(self.send_message)

        else:
            decrypted = self.f.decrypt(datagram)
            datagram = str(decrypted)[1:len(str(decrypted))]
            print(datagram)
    
    def send_message(self):
        while True:
            msg = self.f.encrypt(input(" ").encode())
            self.transport.write(msg,self.address)

if __name__ == "__main__":
    try:
        reactor.listenUDP(9999,Server())
        print("started server")
        # reactor.run()
    except:
        print("server already made")
        
        
    if int(input("1 or 2")) == 2:
        port = 12345
    else:
        port =12354
    reactor.listenUDP(port,Client("localhost",port))
    reactor.run()
    