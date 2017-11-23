#!/bin/bash
cp /hd-config/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/
cp /hd-config/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/
mkdir -p $HADOOP_PREFIX/logs
start-yarn.sh

