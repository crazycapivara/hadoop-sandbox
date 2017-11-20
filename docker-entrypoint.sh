#!/bin/sh
/usr/sbin/sshd
ssh-keyscan -t rsa -H localhost >> ~/.ssh/known_hosts
# needed for secondary NameNode 
ssh-keyscan -t rsa -H 0.0.0.0 >> ~/.ssh/known_hosts 
exec "$@"

