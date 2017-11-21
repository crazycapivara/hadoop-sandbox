#!/bin/sh
cp /hd-config/*.xml $HADOOP_HOME/etc/hadoop/
hdfs namenode -format
start-dfs.sh
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/root

