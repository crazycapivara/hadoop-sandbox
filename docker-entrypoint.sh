#!/bin/sh
/usr/sbin/sshd
#ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -t rsa -H localhost >> ~/.ssh/known_hosts 
exec "$@"
#/bin/bash

