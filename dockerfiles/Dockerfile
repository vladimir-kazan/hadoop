# docker build --no-cache -t hadoop -f dockerfiles/Dockerfile dockerfiles
# docker build -t hadoop -f dockerfiles/Dockerfile dockerfiles
# docker run --rm -it --env-file dockerfiles/.env -v $(pwd)/.:/root/src hadoop

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y upgrade

RUN apt-get -y install \
  software-properties-common \
  tree \
  vim

# JAVA
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y install oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# MYSQL
# FOR DEV ONLY
ENV MYSQL_ROOT_PASSWORD=1
RUN apt-get -y install mysql-server
RUN find /var/lib/mysql/mysql -exec touch -c -a {} + && service mysql start

# FINISH INSTALLATION
RUN rm -rf /var/lib/apt/lists/*

# FILES
ADD root/start.sh /root/start.sh
RUN chmod +x /root/start.sh
ADD root/hive.sql /root/hive.sql

# HADOOP
# RUN mkdir -p /opt/{hadoop,hdfs/{datanode,namenode},hive,presto/{etc/catalog,data},spark}
RUN bash -c 'mkdir -p /opt/{hadoop,hdfs/{datanode,namenode}}'

ENV HOME /root
WORKDIR /root

EXPOSE 22
EXPOSE 3306

ENV DEBIAN_FRONTEND teletype
# ENTRYPOINT /root/start.sh
CMD /root/start.sh
