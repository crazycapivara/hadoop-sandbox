#!/bin/sh
hdfs namenode -format
sbin/start-dfs.sh
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/root

