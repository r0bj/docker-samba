#!/bin/bash

if [ -z "$SMB_USER" ]; then
    SMB_USER="smbuser"
fi

if [ -n "$SMB_UID" ]; then
    opts="$opts --uid $SMB_UID"
fi

if [ -n "$SMB_GID" ]; then
    opts="$opts --gid $SMB_GID"
    groupadd --gid $SMB_GID $SMB_USER
fi

useradd --no-create-home --home-dir /nonexistent --shell /bin/false $opts $SMB_USER

if [ -n "${SMB_PASSWORD}" ]; then
    (echo $SMB_PASSWORD; echo $SMB_PASSWORD) | smbpasswd -s -a $SMB_USER
fi

if [ ! -d /media/share ]; then
  mkdir /media/share
fi

confd -onetime -backend env

nmbd -D
exec smbd -FS </dev/null
