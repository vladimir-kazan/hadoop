echo Setting up Hadoop...
tar -xf $HOME/hadoop-3.1.1.tar.gz --directory=$HADOOP_HOME --strip=1

# single machine installation
echo "localhost\n" >> $HADOOP_HOME/etc/hadoop/master
echo "localhost\n" >> $HADOOP_HOME/etc/hadoop/slaves

# https://hadoop.apache.org/docs/r3.1.1/hadoop-project-dist/hadoop-common/core-default.xml
cp $HOME/hadoop/etc/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
cp $HOME/hadoop/etc/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

hdfs namenode -format
# start-dfs.sh
# hdfs dfs -chown root /
# stop-dfs.sh

# hdfs dfsadmin -report | grep 'Configured Capacity' | tail -n1
