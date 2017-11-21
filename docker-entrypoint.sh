#!/bin/bash
/usr/sbin/sshd
ssh-keyscan -t rsa -H localhost >> ~/.ssh/known_hosts
# needed for secondary NameNode 
ssh-keyscan -t rsa -H 0.0.0.0 >> ~/.ssh/known_hosts 

if [ "$INIT" == "1" ]; then
   echo "set up and start dfs!"
   cp /hd-config/*.xml $HADOOP_HOME/etc/hadoop/
   sh /set-up-and-start-dfs.sh
fi

exec "$@"

