import os
from pathlib import Path
import socket
from socket import MsgFlag
import sys
import random
import threading
from PySide6.QtGui import QGuiApplication,QAction
from PySide6.QtQml import QQmlApplicationEngine , QmlElement
from PySide6.QtCore import QObject, Slot
from cryptography.fernet import Fernet
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from cryptography.fernet import Fernet
from random import randint
import time
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from twisted.internet import task
import pync
# from win10toast import ToastNotifier
QML_IMPORT_NAME = "backend"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class Bridge(QObject):
    @Slot(list, result=str)
    def login(self,a):
        with open((os.fspath(Path(__file__).resolve().parent / "user.txt")), 'w') as b:
            for x in a:
                b.write(x+"\n")
        
        
        
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
        if ((Path(__file__).resolve().parent / filename).exists()):
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
        else:
            return [-1]
        

       
    @Slot(list, result=list)
    def contactIndex(self,array):
        print(array)
        data = [int(array[0].index("element")),int(array[0].index("name")),int(array[0].index("c1")),int(array[0].index("c2")),int(array[0].index("ip")),int(array[0].index("port")),int(array[0].index("uport")),len(array)]
        return data
    
    @Slot(list, result=list)
    def messageIndex(self,array):
        print(array)
        data = [int(array[0].index("element")),int(array[0].index("name")),len(array)]
        return data
    
    @Slot(str, result=list)
    def load_user(self,b):
        data = []
        with open((os.fspath(Path(__file__).resolve().parent / "user.txt"))) as b:
            for x in b:
                data.append(x[:-1])
        
        return data


    
        
    @Slot(str, result=str)
    def exit_chat(self,b):
       global loadedChat
       loadedChat = False
        
    @Slot(str, result=str)
    def message(self,a):
        global port,online,loadedChat,loop,ip,uport
        print(a)
        a = a.split(",")
        port = int(a[1])
        ip = str(a[0])
        uport =int(a[2])
        try:
            reactor.listenUDP(9999,Server())
            # print("started server")
        except:
            # print("server already made")
            online = True
        
        thread1 = threading.Thread(target=reactor.listenUDP(port,Client(ip,port,"")))
        thread1.start()
        time.sleep(1)
        loadedChat = True
        app.processEvents()
        loop = task.LoopingCall(refresh)
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
        addr = f.encrypt(code.encode())
        code = addr[8:-1]
        code = str(code)[2:-1]
        while True:
            try:
                f.decrypt(bytes(("gAAAAABj"+str(code)+"="), 'utf-8'))
                break
            except:
                addr = f.encrypt(code.encode())
                code = addr[8:-1]
                code = str(code)[2:-1]
        
        return code
            
    @Slot(str, result=list)
    def adduser(self,id):
        global port
        arr = ports()
        arr.append(port)
        print(arr)
        savetoports(arr)
        print(id)
        decrypted = f.decrypt(bytes("gAAAAABj"+str(id)+"=", 'utf-8'))
        mainf = str(decrypted)[1:len(str(decrypted))]
        print(mainf)
        mainf = mainf[1:len(str(mainf))-1].split(",")
        print(mainf)
        col = internalcolorpicker()
        return [" contact.qml",mainf[2],col[0],col[1],mainf[0],mainf[1],port]

        
    
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
        try:
            loop.stop()
            reactor.stop()
        except:

            app.processEvents()
    @Slot(str,str,result=str)
    def notif(self,titl,messag):
        pync.notify(
        title = titl,
        message = messag,
        app_icon = (os.fspath(Path(__file__).resolve().parent / "images/bb.png")),
        timeout = 10
        )
        # toaster = ToastNotifier()
        # toaster.show_toast(titl,
        #            messag,
        #            icon_path=(os.fspath(Path(__file__).resolve().parent / "bb.png")),
        #            duration=10)
        
def internalcolorpicker():
        return [colors[random.randint(0,len(colors))],colors[random.randint(0,len(colors))]]


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
        self.p = port
        self.up = uport
        self.address = None
        self.server = host,9999
        
    
        

    def startProtocol(self):
        # print("Working on id:",self.id)
        time.sleep(1)
        self.transport.write("ready".encode('utf-8'),self.server)
        reactor.callInThread(self.send_message)

    def datagramReceived(self,datagram,addr):
        global msg
        if addr ==self.server:
            self.address = self.h,self.up
        else:
            try:
                decrypted = self.f.decrypt(datagram)
                datagram = str(decrypted)[1:len(str(decrypted))]
                msg = datagram[1:-1]
            except:
                msg = datagram

        
            
    def send_message(self):
        global sendmsg
        while True:
            if(stopapp == True):
                break
            # print(sendmsg)
            if sendmsg != "":
                if sendmsg !="ready":
                    sendmsg = self.f.encrypt(sendmsg.encode())
                    self.transport.write(sendmsg,self.address)
                    
                sendmsg = ""
            time.sleep(2)
            
def ports():
    data = []
    with open((os.fspath(Path(__file__).resolve().parent / "ports.txt"))) as b:
        for line in b:
            decrypted =f.decrypt(bytes(line,'utf-8'))
            if(len(str(decrypted)) !=5):
                print(str(decrypted)[2:len(str(decrypted))-1])
                data.append(str(decrypted)[2:len(str(decrypted))-1])
            else:
                data.append(str(decrypted)[1:len(str(decrypted))])
    return data
       
def savetoports(savee):
    with open((os.fspath(Path(__file__).resolve().parent / "ports.txt")), 'w') as b:
        for x in savee:
            x = f.encrypt(str(x)[0:len(str(x))].encode())
            b.write(str(x)[1:len(str(x))]+"\n")
            
def refresh():
    if(stopapp == False):
        app.processEvents()
    else:
        quit()
        sys.exit()

if __name__ == "__main__":
    colors = ["#ffafbd","#ffc3a0","#2193b0","#753a88","#cc2b5e","#ee9ca7","#ffdde1","#42275a","#734b6d","#2c3e50","#bdc3c7","#de6262","#ffb88c","#dd5e89","#56ab2f","#a8e063","#614385","#516395","#ef629f","#00cdac","#02aab0","#000428","#004e92","#ddd6f3","#faaca8","#61045f","#aa076b"]
    port = 0
    uport = 0
    ip = ""
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




