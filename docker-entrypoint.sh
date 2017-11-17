#!/bin/sh
/usr/sbin/sshd
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

