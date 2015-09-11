#!/usr/bin/env python3
# Based on the example from https://docs.python.org/3/library/asyncore.html
import asyncore
import socket

class ChatHandler(asyncore.dispatcher_with_send):
    def __init__(self, sock, name, server):
        asyncore.dispatcher_with_send.__init__(self, sock)
        self.name = name
        self.server = server

    def handle_read(self):
        data = self.recv(8192).decode()
        if data != "":
            self.server.broadcast(self.name + ": " + data)

    def handle_close(self):
        del self.server.clients[self.name]
        self.close()
        self.server.broadcast(self.name + " disconnected")

class ChatServer(asyncore.dispatcher):
    def __init__(self, host, port):
        asyncore.dispatcher.__init__(self)
        self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
        self.set_reuse_addr()
        self.bind((host, port))
        self.listen(5)
        self.clients = {}
        self.counter = 0

    def broadcast(self, message):
        print(message)
        messageBytes = (message + "\n").encode()
        for otherName in self.clients:
            handler = self.clients[otherName]
            handler.send(messageBytes)

    def handle_accept(self):
        pair = self.accept()
        if pair is not None:
            sock, addr = pair
            self.counter += 1
            name = "client" + str(self.counter)
            print('Incoming connection from {0}: {1}'.
                    format(repr(addr), name))
            self.broadcast(name + " connected")
            handler = ChatHandler(sock, name, self)
            self.clients[name] = handler

server = ChatServer('localhost', 7777)
asyncore.loop()
