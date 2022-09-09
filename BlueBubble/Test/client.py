import socket
import sys
import threading

rendezvous = (str(socket.gethostbyname(socket.gethostname())), 55555)

# connect to rendezvous
print('connecting to rendezvous server')



sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
try:   
    port= 50001
    sock.bind(('0.0.0.0', port))
except:
    port= 50003
    sock.bind(('0.0.0.0', port))

sock.sendto(b'0', rendezvous)

while True:
    data = sock.recv(1024).decode()

    if data.strip() == 'ready':
        print('checked in with server, waiting')
        break

data = sock.recv(1024).decode()
ip, v, dport = data.split(' ')
port =int(port)
dport =int(dport)

print(port,dport)

print('\ngot peer')
print('  ip:          {}'.format(ip))
print('  source port: {}'.format(port))
print('  dest port:   {}\n'.format(dport))

# punch hole
# equiv: echo 'punch hole' | nc -u -p 50001 x.x.x.x 50002
print('punching hole')

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', port))
sock.sendto(b'0', (ip, dport))

print('ready to exchange messages\n')

# listen for
# equiv: nc -u -l 50001
def listen():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(('0.0.0.0', port))

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
    sock.sendto(msg.encode(), (ip, port))