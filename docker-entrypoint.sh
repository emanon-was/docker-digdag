#!/bin/bash

DIGDAG_CONFIG=$(dirname $0)/server.properties

if [ -f $DIGDAG_CONFIG ]; then
    rm $DIGDAG_CONFIG
fi

# Server-mode commands > --config
# https://docs.digdag.io/command_reference.html#server-mode-commands

# server.bind (ip address)
if [ -n "$SERVER_BIND" ]; then
    echo "server.bind = $SERVER_BIND" >> $DIGDAG_CONFIG
else
    echo "server.bind = 0.0.0.0" >> $DIGDAG_CONFIG
fi

# server.port (integer)
if [ -n "$SERVER_PORT" ]; then
    echo "server.port = $SERVER_PORT" >> $DIGDAG_CONFIG
else
    echo "server.port = 80" >> $DIGDAG_CONFIG
fi

# server.admin.bind (ip address)
if [ -n "$SERVER_ADMIN_BIND" ]; then
    echo "server.admin.bind = $SERVER_ADMIN_BIND" >> $DIGDAG_CONFIG
else
    echo "server.admin.bind = 0.0.0.0" >> $DIGDAG_CONFIG
fi

# server.admin.port (integer)
if [ -n "$SERVER_ADMIN_PORT" ]; then
    echo "server.admin.port = $SERVER_ADMIN_PORT" >> $DIGDAG_CONFIG
fi

if [ -f $DIGDAG_CONFIG ]; then
    digdag server --config $DIGDAG_CONFIG $@;
else
    digdag server --memory;
fi
