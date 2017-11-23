#!/bin/bash
cp /hd-config/core-site.xml $HADOOP_PREFIX/etc/hadoop/
cp /hd-config/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/
hdfs namenode -format
start-dfs.sh
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/root

