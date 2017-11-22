# hadoop in a box

## build

```bash
# with url
$ docker build -t crazycapivara/hadoop github.com/crazycapivara/hadoop-sandbox

# after pull
$ docker build -t crazycapivara/hadoop . 
```

## run

```bash
# check version
$ docker run --rm crazycapivara/hadoop hadoop version

# start dfs and run example
$ docker run --rm -e START_DFS=yes crazycapivara/hadoop examples/map-reduce.sh

# start dfs and start a bash
$ docker run --rm -it -e START_DFS=yes crazycapivara/hadoop
```

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
$ docker run --rm -it -p 50070:50070 -e START_DFS=yes crazycapivara/hadoop
```

browse the web interface for the NameNode

- http://localhost:50070

