#!/bin/sh
set -e
if [ "$1" = "py" ] || [ "$1" = "tcl" ]; then
    echo "Starting chat.$1"
    ./chat.$1 &
else
    echo "usage: $0 (py|tcl)"
    exit 1
fi
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT # Kill the chat server on exit.
../websocketd --port=8080 --staticdir=. nc localhost 7777
