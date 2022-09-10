import socket
import sys
import threading
import os
import multiprocessing
import time


def server_dep():
    known_port = 50002

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(('0.0.0.0', 55555))
    clients = []

    while True:
        data, address = sock.recvfrom(128)

        print('connection from: {}'.format(address))
        clients.append(address)

        sock.sendto(b'ready', address)

        if len(clients) == 2:
            print('got 2 clients, sending details to each')
            break
        time.sleep(1)

    c1 = clients.pop()
    c1_addr, c1_port = c1
    c2 = clients.pop()
    c2_addr, c2_port = c2

    sock.sendto('{} {} {}'.format(c1_addr, c1_port, known_port).encode(), c2)
    sock.sendto('{} {} {}'.format(c2_addr, c2_port, known_port).encode(), c1)
    
# rendezvous = ('192.168.0.21', 55555)
SERVER=(socket.gethostbyname_ex(socket.gethostname())[-1][3],55555)
      

# rendezvous = ("127.0.0.1",55555)

port = 50003
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', port))
sock.sendto(b'0', SERVER)

while True:
    data = sock.recv(1024).decode()

    if data.strip() == 'ready':
        print('checked in with server, waiting')
        break

data = sock.recv(1024).decode()
ip, dport, sport = data.split(' ')
sport = int(port)
dport = int(50002)

print('\ngot peer')
print('  ip:          {}'.format(ip))
print('  source port: {}'.format(sport))
print('  dest port:   {}\n'.format(dport))

# punch hole
# equiv: echo 'punch hole' | nc -u -p 50001 x.x.x.x 50002
print('punching hole')

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', sport))
sock.sendto(b'0', (ip, dport))

print('ready to exchange messages\n')

# listen for
# equiv: nc -u -l 50001
def listen():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(('0.0.0.0', sport))

    while True:
        data = sock.recv(1024)
        print('\rpeer: {}\n> '.format(data.decode()), end='')

listener = threading.Thread(target=listen, daemon=True);
listener.start()

# send messages
# equiv: echo 'xxx' | nc -u -p 50002 x.x.x.x 50001
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', dport))

while True:
    msg = input('> ')
    sock.sendto(msg.encode(), (ip, sport))

