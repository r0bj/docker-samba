#!/bin/bash

if [ -z "$SMB_USER" ]; then
    SMB_USER="smb"
fi

if [ -n "$SMB_UID" ]; then
    OPTS="$OPTS -u $SMB_UID"
fi

if [ -n "$SMB_GID" ]; then
    OPTS="$OPTS -G $SMB_USER"
    addgroup -g $SMB_GID $SMB_USER
fi

adduser -D -H -h /nonexistent -g $SMB_USER -s /sbin/nologin $OPTS $SMB_USER

if [ -n "$SMB_PASSWORD" ]; then
    (echo $SMB_PASSWORD; echo $SMB_PASSWORD) | smbpasswd -s -a $SMB_USER
fi

if [ ! -d /media/share ]; then
  mkdir /media/share
fi

confd -onetime -backend env

#nmbd -D
avahi-daemon -D
exec smbd -F --debug-stdout --no-process-group </dev/null
