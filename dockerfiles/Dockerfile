# docker build --no-cache -t hadoop -f dockerfiles/Dockerfile dockerfiles
# docker run --rm -it --env-file dockerfiles/.env -v $(pwd)/.:/root/src hadoop

# docker build -t java8-ubuntu:latest --target=java8-ubuntu -f dockerfiles/Dockerfile dockerfiles
FROM ubuntu:18.04 as java8-ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y upgrade

RUN apt-get -y install \
  software-properties-common

# JAVA 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y install oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN echo "\nJAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment

# FINISH INSTALLATIONS
RUN apt-get -y install \
  vim \
  tree \
  curl \
  openssh-server
RUN rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -b 4096 -t rsa -f $HOME/.ssh/id_rsa -q -N "" && \
  cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys

ENV DEBIAN_FRONTEND teletype
WORKDIR /root


###############
# docker build -t hadoop:3.1.1 --target hadoop-3.1.1 -f dockerfiles/Dockerfile dockerfiles
# docker run --rm -it --env-file dockerfiles/.env -v $(pwd)/.:/root/src hadoop:3.1.1
FROM java8-ubuntu as hadoop-3.1.1

ENV DEBIAN_FRONTEND noninteractive

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

# LOCAL FILES
ADD root /root

# HADOOP
# RUN mkdir -p /opt/{hadoop,hdfs/{datanode,namenode},hive,presto/{etc/catalog,data},spark}
RUN bash -c 'mkdir -p /opt/{hadoop,hdfs/{datanode,namenode}}'
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV DIST=archive/
# ENV DIST=http://www-eu.apache.org/dist
# ADD $DIST/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz $HOME
COPY $DIST/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz $HOME
RUN $HOME/hadoop/setup.sh

# RUN tar -xf $HOME/hadoop-3.1.1.tar.gz --directory=$HADOOP_HOME --strip=1


# MYSQL
# FOR DEV ONLY
# ENV MYSQL_ROOT_PASSWORD=1
# RUN apt-get -y install mysql-server
# RUN find /var/lib/mysql/mysql -exec touch -c -a {} + && service mysql start

ENV DEBIAN_FRONTEND teletype
# CMD /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh"]
