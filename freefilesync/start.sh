#!/bin/bash

mkdir -p /home/freefilesync/logs

if [ $RUN_AS_ROOT = true ] ; then
    exec supervisord
else
    usermod -u $PUID freefilesync
    groupmod -g $PGID freefilesync
    chown -R $PUID:$PGID /home/freefilesync
    exec gosu $PUID supervisord
fi