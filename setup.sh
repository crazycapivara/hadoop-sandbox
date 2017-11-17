# check hadoop folder!
# cd /hadoop-sandbox/...
./bin/hdfs namenode -format
./sbin/start-dfs.sh
./bin/hdfs dfs -mkdir /user
./bin/hdfs dfs -mkdir /user/root # must be username running cmds below!
./bin/hdfs dfs -put ./etc/hadoop input
#./bin/hdfs dfs -cat input/* # check whether you can access hdfs file system
./bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.2.jar grep input output 'dfs[a-z.]+'
./bin/hdfs dfs -cat output/*

