# hadoop in a box

run hadoop inside a docker container

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

# start dfs and an interactive bash session
$ docker run --rm -it -e START_DFS=yes crazycapivara/hadoop
```

## environment variables

- `START_DFS` defaults to `no`
- `START_YARN` defaults to `no`

```bash
# start dfs only
$ docker run --rm -P -e START_DFS=yes crazycapivara/hadoop examples/map-reduce.sh

# start dfs and yarn
$ docker run --rm -P \
    -e START_DFS=yes \
    -e START_YARN=yes \
    crazycapivara/hadoop examples/map-reduce.sh
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
$ docker run --rm -it \
    -p 50070:50070 -p 8088:8088 \
    -e START_DFS=yes -e START_YARN=yes crazycapivara/hadoop
```

browse the web interface for the NameNode

- http://localhost:50070

browse the web interface for the ResourceManager

- http://localhost:8088

