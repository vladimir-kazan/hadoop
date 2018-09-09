#!/bin/sh

# usermod -d /var/lib/mysql/ mysql
# find /var/lib/mysql/mysql -exec touch -c -a {} + && \
#   service mysql start

# # service mysql start
# mysql -uroot < hive.sql

service ssh start

# Hadoop
start-dfs.sh

/bin/bash
