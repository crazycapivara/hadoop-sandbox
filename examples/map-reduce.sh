#!/bin/bash
INPUT=input
OUTPUT=output

hdfs dfs -put $HADOOP_PREFIX/etc/hadoop $INPUT
hadoop jar $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-${HADOOP_VERSION}.jar grep $INPUT $OUTPUT 'dfs[a-z.]+'
hdfs dfs -cat $OUTPUT/*

