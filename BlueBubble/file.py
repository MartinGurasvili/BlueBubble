# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import random
import PyQt6
from PySide6.Qt5Compat import QtGraphicalEffects
from PySide6.QtGui import QGuiApplication
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQml import QQmlApplicationEngine , QmlElement
from PySide6.QtCore import QObject, Slot
from cryptography.fernet import Fernet
import numpy as np

message = "my deep dark secret".encode()
f = Fernet(b'5J6WmI-KgUFRzqnqO_jqnGrSAyYFKEotMHTi4GGhFAE=')
encrypted = f.encrypt(message)
print(encrypted)
decrypted = f.decrypt(encrypted)
print(str(decrypted)[1:len(str(decrypted))])

QML_IMPORT_NAME = "backend"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement


class Bridge(QObject):
    @Slot(str, result=str)
    def nume(self,n):
        engine = QQmlApplicationEngine()
        engine.load(os.fspath(Path(__file__).resolve().parent / "App.qml"))
        f = engine.rootObjects()[0].property("formula")
        return f+n
    @Slot(str, result=str)
    def login(self,a):
        np.savetxt("user.txt",np.array([str(a)]),fmt = '%s')
        print("wag1")
    @Slot(str, result=str)
    def load_user(self,b):
        try:
            return str(np.loadtxt("user.txt",dtype=str))
        except:
            return ""


    @Slot(str, result=str)
    def up(self,f):
        if(f != ""):
            try:
              return str(eval(str(f)))
            except:
                return

        else:
            self.ans = "0"


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "content/App.qml"))
    if not engine.rootObjects():
               sys.exit(-1)
    sys.exit(app.exec())




