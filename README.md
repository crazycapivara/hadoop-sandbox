# hadoop in a box

run hadoop inside a docker container

## preface

out of the box you can run hadoop in

- non-distributed or
- pseudo-disributed

mode and run a MapReduce job either locally or on YARN as documented here:

- [hadoop docs single cluster](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)

It should also be possible to run multiple containers to set up fully-distributed clusters (generally by adjusting the config files), but I did not test it yet.

## build

```bash
# with url
$ docker build -t crazycapivara/hadoop github.com/crazycapivara/hadoop-sandbox

# or after pull
$ docker build -t crazycapivara/hadoop . 
```

## run

```bash
# check version
$ docker run --rm crazycapivara/hadoop hadoop version

# run MapReduce example locally as standalone operation
$ docker run --rm crazycapivara/hadoop examples/map-reduce.sh

# start dfs and run MapReduce example locally as pseudo-distributed operation
$ docker run --rm -e START_DFS=yes crazycapivara/hadoop examples/map-reduce.sh

# start dfs and YARN
# and run MapReduce example as pseudo-distributed operation on YARN
$ docker run --rm -P \
    -e START_DFS=yes \
    -e START_YARN=yes \
    crazycapivara/hadoop examples/map-reduce.sh

# start dfs and an interactive bash session
$ docker run --rm -it -e START_DFS=yes crazycapivara/hadoop
```

## environment variables

- `START_DFS`:
    - set to `yes` to set up HDFS and run hadoop's `start-dfs.sh` (defaults to `no`)
- `START_YARN`:
    - set to `yes` to set up YARN and run hadoop's `start-yarn.sh` (defaults to `no`)

## ssh

```bash
# run in detached mode
$ docker run -t -d -p 10022:22 -e START_DFS=yes --name hadoop_sandbox crazycapivara/hadoop

# get key
$ docker cp hadoop_sandbox:/root/.ssh/id_rsa ~/.ssh/

# connect via ssh
$ ssh locahost -p 10022 -i ~/.ssh/id_rsa
```

## web interfaces

```
# publish port(s)
$ docker run --rm -it \
    -p 50070:50070 -p 8088:8088 \
    -e START_DFS=yes -e START_YARN=yes crazycapivara/hadoop
```

browse the web interface for the NameNode

- http://localhost:50070

browse the web interface for the ResourceManager

- http://localhost:8088

