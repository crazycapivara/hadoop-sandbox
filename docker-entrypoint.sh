#!/bin/bash
/usr/sbin/sshd

if [ "$START_DFS" == "yes" ]; then
   echo "set up and start dfs!"
   /set-up-and-start-dfs.sh
fi

if [ "$START_YARN" == "yes" ]; then
   echo "set up and start yarn!"
   /set-up-and-start-yarn.sh
fi

exec "$@"

