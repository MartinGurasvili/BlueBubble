# This Python file uses the following encoding: utf-8
import os
import numpy as np
from pathlib import Path
from socket import MsgFlag
import sys
import random
import threading
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
from twisted.internet import task


QML_IMPORT_NAME = "backend"
QML_IMPORT_MAJOR_VERSION = 1
# print(sys.modules)
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
    def exit_chat(self,b):
       global loadedChat
       loadedChat = False
       
    @Slot(str, result=str)
    def message(self,a):
        global port,online,loadedChat,loop
        port = int(a)
        try:
            reactor.listenUDP(9999,Server())
            print("started server")
            
        # reactor.run()
        except:
            print("server already made")
            online = True
        
        thread1 = threading.Thread(target=reactor.listenUDP(port,Client("localhost",port,"")))
        thread1.start()
        time.sleep(1)
        loadedChat = True
        app.processEvents()
        
        loop = task.LoopingCall(refresh)

            # Start looping every 1 second.
        loopDeferred = loop.start(0.004)
        
        reactor.run()
               
        
    
    @Slot(str, result=str)
    def sendmessage(self,a):
        global sendmsg
        sendmsg = a


    @Slot(str, result=str)
    def checkmessage(self,a):
        global port,msg,online
        app.processEvents()
        return msg
        
    @Slot(str, result=str)
    def quit(self,a):
        global stopapp
        stopapp = True
        loop.stop()
        reactor.stop()
        print("done")
        app.processEvents()
        quit()
        exit()
        print("done")
        
    



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
    
    def __init__(self,host,port,msg):
        if host == "localhost":
            host = "127.0.0.1"
        self.h = host
        self.f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
        self.id = host,port
        self.address = None
        self.server = "127.0.0.1",9999
        
        

    def startProtocol(self):
        print("Working on id:",self.id)
        time.sleep(1)
        
        self.transport.write("ready".encode('utf-8'),self.server)
        reactor.callInThread(self.send_message)
        # reactor.callInThread(self.ref)

    def datagramReceived(self,datagram,addr):
        global msg
        # reactor.callInThread(app.processEvents)
        
        # app.processEvents()
        print("hppening")
        if addr ==self.server:
           
            if(port ==12345):
                self.address = self.h,12354
            else:
                self.address = self.h,12345
        else:
            try:
                decrypted = self.f.decrypt(datagram)
                datagram = str(decrypted)[1:len(str(decrypted))]
                print(datagram)
                msg = datagram[1:-1]
            except:
                print(datagram)
                msg = datagram

        
            
    def send_message(self):
        global sendmsg
        while True:
            if(stopapp == True):

                break
                
                
            print(sendmsg)
            
            if sendmsg != "":
                if sendmsg !="ready":
            # while True:
                    sendmsg = self.f.encrypt(sendmsg.encode())
                    self.transport.write(sendmsg,self.address)
                    
                sendmsg = ""
            time.sleep(2)
            

def refresh():
    if(stopapp == False):
        app.processEvents()
        
    else:
        quit()
        sys.exit()
    # if(sendmsg =!)
    #     reactor.callInThread(self.send_message)

if __name__ == "__main__":
    port = 0
    msg = ""
    sendmsg = ""
    stopapp = False
    online=False
    loadedChat = False
    
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "App.qml"))
    if not engine.rootObjects():
               sys.exit(-1)
               
    sys.exit(app.exec())




