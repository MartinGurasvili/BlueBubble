import code
import os
import numpy as np
from pathlib import Path
import socket
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
        
    @Slot(list, result=list)
    def colorpicker(self,a):
        return [colors[random.randint(0,len(colors))],colors[random.randint(0,len(colors))]]

    
    @Slot("QAbstractItemModel*", str)
    def saveListModel(self, model, filename):
        global f
        data = []
        headers = {v.data().decode(): k for k, v in model.roleNames().items()}
        for i in range(model.rowCount()):
            row = dict()
            for name, role in headers.items():
                value = model.index(i, 0).data(role)
                row[name] = value
            if(i == 0):
                data.append(f.encrypt((",".join(list(row))).encode()))
            data.append(f.encrypt((",".join(list(row.values()))).encode()))
        # print(data)
        with open((os.fspath(Path(__file__).resolve().parent / filename)), 'w') as b:
            for x in data:
                b.write(str(x)[1:len(str(x))]+"\n")
    
    @Slot(str, result=list)
    def LoadListModel(self,filename):
        global f
        data = []
        with open((os.fspath(Path(__file__).resolve().parent / filename))) as b:
            for line in b:
                # print(bytes(line[:len(str(line))-3],'utf-8'))
                decrypted =f.decrypt(bytes(line,'utf-8'))
                # print(decrypted)
                datagram = str(decrypted)[1:len(str(decrypted))]
                datagram = datagram[1:len(str(datagram))-1]
                data.append(str(datagram).split(","))
        print(data)
        return data
       
    @Slot(list, result=list)
    def contactIndex(self,array):
        print(array)
        data = [int(array[0].index("element")),int(array[0].index("name")),int(array[0].index("c1")),int(array[0].index("c2")),len(array)]
        return data
    
    @Slot(list, result=list)
    def messageIndex(self,array):
        print(array)
        data = [int(array[0].index("element")),int(array[0].index("name")),len(array)]
        return data
    
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
        
        thread1 = threading.Thread(target=reactor.listenUDP(port,Client(ip_ad,port,"")))
        thread1.start()
        time.sleep(1)
        loadedChat = True
        app.processEvents()
        
        loop = task.LoopingCall(refresh)

            # Start looping every 4 millisecond.
        loopDeferred = loop.start(0.004)
        
        reactor.run()
    @Slot(str, result=str)
    def gencode(self,username):
        global port
        port =str(random.randint(11111,65534))
        portlist = ports()
        print(portlist)
        while port in portlist:
            port =str(random.randint(11111,65534))
        code = str(ip_ad+","+port+","+username)
        print(code)
        addr = f.encrypt(code.encode())
        code = addr[10:-1]
        code = str(code)[2:-1]
        print(code)
        return code
    
    @Slot(str, result=str)
    def adduser(self,id):
        global port
        arr = ports()
        arr[len(arr)-1] =","+port+","
        print(str(arr))
        savetoports(str(arr))
        #needs to save own port number 
        #open messaging window
        #save contact and decrypt id
        pass

        
    
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
        self.server = host,9999
        
        

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
            
def ports():
        try:
            return str(np.loadtxt((os.fspath(Path(__file__).resolve().parent / "ports.txt")),dtype=str)).split(",")
        except:
            return ""     
def savetoports(savee):
        # try:
        print(np.array(savee))
        np.savetxt(os.fspath(Path(__file__).resolve().parent / "ports.txt"),np.array([savee]),fmt = '%s')
        # except:
        #     return ""     

def refresh():
    if(stopapp == False):
        app.processEvents()
        
    else:
        quit()
        sys.exit()
    # if(sendmsg =!)
    #     reactor.callInThread(self.send_message)

if __name__ == "__main__":
    colors = ["#ffafbd","#ffc3a0","#2193b0","#753a88","#cc2b5e","#ee9ca7","#ffdde1","#42275a","#734b6d","#2c3e50","#bdc3c7","#de6262","#ffb88c","#dd5e89","#56ab2f","#a8e063","#614385","#516395","#ef629f","#00cdac","#02aab0","#000428","#004e92","#ddd6f3","#faaca8","#61045f","#aa076b"]
    port = 0
    msg = ""
    sendmsg = ""
    stopapp = False
    online=False
    loadedChat = False
    f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
    print("   ")
    print(socket.gethostbyname(socket.gethostname()))
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip_ad = s.getsockname()[0]
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "App.qml"))
    if not engine.rootObjects():
               sys.exit(-1)
               
    sys.exit(app.exec())




