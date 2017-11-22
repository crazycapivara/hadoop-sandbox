#!/bin/bash
cp /hd-config/mapred-site.xml $HADOOP_HOME/etc/hadoop/
cp /hd-config/yarn-site.xml $HADOOP_HOME/etc/hadoop/
start-yarn.sh

