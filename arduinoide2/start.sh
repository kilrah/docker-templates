#!/bin/bash

mkdir -p /home/arduino/logs

usermod -u $PUID arduino
groupmod -g $PGID arduino
chown -R $PUID:$PGID /home/arduino
chown -R $PUID:$PGID /dev/stdout 
exec gosu $PUID supervisord
chmod 0666 /dev/tty* 
exec gosu $PUID supervisord