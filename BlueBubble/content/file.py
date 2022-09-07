# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import random
import PyQt6
# from PySide6.Qt5Compat import QtGraphicalEffects
from PySide6.QtGui import QGuiApplication
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQml import QQmlApplicationEngine , QmlElement
from PySide6.QtCore import QObject, Slot
from cryptography.fernet import Fernet
from re import T
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from cryptography.fernet import Fernet
from random import randint
import time
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
import numpy as np

# message = "my deep dark secret".encode()
# f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
# encrypted = f.encrypt(message)
# print(encrypted)
# decrypted = f.decrypt(encrypted)
# print(str(decrypted)[1:len(str(decrypted))])

QML_IMPORT_NAME = "backend"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement


class Bridge(QObject):
    @Slot(str, result=str)
    def login(self,a):
        if int(a) == 2:
            port = "12345"
            name = "Jakub"
            
        else:
            port ="12354"
            name = "Martin"
        return port
        # np.savetxt((os.fspath(Path(__file__).resolve().parent / "user.txt")),np.array([str(a)]),fmt = '%s')
        # print("wag1")
        
    @Slot(str, result=str)
    def load_user(self,b):
        try:
            return str(np.loadtxt((os.fspath(Path(__file__).resolve().parent / "user.txt")),dtype=str))
        except:
            return ""
    @Slot(str, result=str)
    def message(self,a):
        global port
        port = int(a)
        try:
            reactor.listenUDP(9999,Server())
            print("started server")
        # reactor.run()
        except:
            print("server already made")
        reactor.listenUDP(port,Client("localhost",port))
        reactor.run()




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
            host = "127.0.0.1"
        self.h = host
        self.f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
        self.id = host,port
        self.address = None
        self.server = "127.0.0.1",9999
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
    port = 0
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "App.qml"))
    if not engine.rootObjects():
               sys.exit(-1)
    sys.exit(app.exec())




