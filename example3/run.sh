#!/bin/sh
set -e

# Run chat.py or chat.tcl depending on the command line arg.
if [ "$1" = "py" ] || [ "$1" = "tcl" ]; then
    echo "Starting chat.$1"
    ./chat.$1 &
else
    echo "usage: $0 (py|tcl)"
    exit 1
fi

# Kill the chat server on exit.
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

# Redirect each WebSocket connection to localhost TCP socket.
../websocketd --port=8080 --staticdir=. nc localhost 7777
