# hadoop

## Docker image

```sh
# download hadoop to dockerfiles/archive/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
# or uncomment in Dockerfile and comment two lines above the next:
# ENV DIST=http://www-eu.apache.org/dist
# ADD $DIST/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz $HOME
docker build -t hadoop:3.1.1 --target hadoop-3.1.1 -f dockerfiles/Dockerfile dockerfiles
docker run --rm -it --env-file dockerfiles/.env -v $(pwd)/.:/root/src hadoop:3.1.1

$ hdfs dfsadmin -report | grep 'Configured Capacity' | tail -n1
```
