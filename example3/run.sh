#!/bin/sh
../websocketd --port=8080 --staticdir=. nc localhost 7777
