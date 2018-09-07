# docker build --no-cache -t hadoop -f dockerfiles/Dockerfile dockerfiles
# docker build -t hadoop -f dockerfiles/Dockerfile dockerfiles
# docker run --rm -it --env-file dockerfiles/.env -v $(pwd)/.:/root/src hadoop

FROM ubuntu:18.04 as base

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y upgrade

RUN apt-get -y install \
  software-properties-common

# JAVA
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y install oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# FINISH INSTALLATIONS
RUN apt-get -y install \
  vim \
  tree \
  curl
RUN rm -rf /var/lib/apt/lists/*

###############
FROM base as hadoop_3_1_1

# MYSQL
# FOR DEV ONLY
# ENV MYSQL_ROOT_PASSWORD=1
# RUN apt-get -y install mysql-server
# RUN find /var/lib/mysql/mysql -exec touch -c -a {} + && service mysql start


# HADOOP
# RUN mkdir -p /opt/{hadoop,hdfs/{datanode,namenode},hive,presto/{etc/catalog,data},spark}
RUN bash -c 'mkdir -p /opt/{hadoop,hdfs/{datanode,namenode}}'
ENV HADOOP_HOME=/opt/hadoop
ENV DIST=http://www-eu.apache.org/dist
ADD $DIST/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz $HOME
RUN tar -xf $HOME/hadoop-3.1.1.tar.gz --directory=$HADOOP_HOME --strip=1
RUN echo "localhost\n" >> $HADOOP_HOME/etc/hadoop/master
RUN echo "localhost\n" >> $HADOOP_HOME/etc/hadoop/slaves


FROM hadoop_3_1_1 as dev
# LOCAL FILES
ADD root/* /root/
# RUN chmod +x /root/start.sh
ADD root/hive.sql /root/hive.sql


WORKDIR /root

EXPOSE 22
EXPOSE 3306

ENV DEBIAN_FRONTEND teletype
# ENTRYPOINT /root/start.sh
CMD /root/start.sh
