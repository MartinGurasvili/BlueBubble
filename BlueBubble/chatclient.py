from re import T
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from cryptography.fernet import Fernet
from random import randint
import time
import asyncio
import chatserver
import os
import subprocess

        
        

class Client(DatagramProtocol):
    
    def __init__(self,host,port):
        if host == "localhost":
            host = "127.0.0.1"
        self.h = host
        self.f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
        self.id = host,port
        self.address = None
        self.server = "127.0.0.1",9999
        print("Working on id:",self.id)
        

    def startProtocol(self):
        
        # subprocess.run("python /Users/martingurasvili/Downloads/chatserver.py",shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        subprocess.Popen("python /Users/martingurasvili/Downloads/chatserver.py",
        shell=True,
       stdout = subprocess.PIPE,
       stderr = subprocess.PIPE,
    )
        time.sleep(1)
        self.transport.write("ready".encode('utf-8'),self.server)

    def datagramReceived(self,datagram,addr):
        # os.system('^C')
        if addr ==self.server:
            # datagram = datagram.decode('utf-8')
            # print("choose a client from these\n",datagram)
            
            if(port ==12345):
                self.address = self.h,12354
            else:
                self.address = self.h,12345
            reactor.callInThread(self.send_message)

        else:
            decrypted = self.f.decrypt(datagram)
            datagram = str(decrypted)[1:len(str(decrypted))]
            print(" ",datagram)
    
    def send_message(self):
        while True:
            msg = self.f.encrypt(input(" ").encode())
            self.transport.write(msg,self.address)

if __name__ == "__main__":
    if int(input("1 or 2")) == 2:
        port = 12345
    else:
        port =12354
    reactor.listenUDP(port,Client("localhost",port))
    reactor.run()
    