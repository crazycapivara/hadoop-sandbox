#!/bin/bash
/usr/sbin/sshd

if [ "$INIT" == "1" ]; then
   echo "set up and start dfs!"
   sh /set-up-and-start-dfs.sh
fi

exec "$@"

