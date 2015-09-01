#!/usr/bin/env python3
# Based on the example from https://docs.python.org/3/library/asyncore.html
import asyncore
import socket

class ChatHandler(asyncore.dispatcher_with_send):
    def __init__(self, sock, name, parent):
        asyncore.dispatcher_with_send.__init__(self, sock)
        self.name = name
        self.parent = parent

    def handle_read(self):
        data = self.recv(8192).decode()
        message = (self.name + ": " + data).encode()
        for otherName in self.parent.clients:
            handler = self.parent.clients[otherName]
            handler.send(message)

    def handle_close(self):
        print(self.name + " disconnected")
        del self.parent.clients[self.name]
        self.close()

class ChatServer(asyncore.dispatcher):
    def __init__(self, host, port):
        asyncore.dispatcher.__init__(self)
        self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
        self.set_reuse_addr()
        self.bind((host, port))
        self.listen(5)
        self.clients = {}
        self.counter = 0

    def handle_accept(self):
        pair = self.accept()
        if pair is not None:
            sock, addr = pair
            self.counter += 1
            name = "client" + str(self.counter)
            print('Incoming connection from {0}: {1}'.format(repr(addr), name))
            handler = ChatHandler(sock, name, self)
            self.clients[name] = handler

server = ChatServer('localhost', 7777)
asyncore.loop()
