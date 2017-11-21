#!/bin/bash
/usr/sbin/sshd

if [ "$START_DFS" == "yes" ]; then
   echo "set up and start dfs!"
   sh /set-up-and-start-dfs.sh
fi

exec "$@"

