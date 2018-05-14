#!/bin/bash

unique_hosts=`echo $MONGODB_CONFIG_HOSTS $MONGODB_ROUTER_HOSTS $MONGODB_SHARD_HOSTS | tr ' ' '\n' | sed 's/:.*$//' | sort | uniq`

#local_dir="/tmp/mongodb"
local_dir="/hdfsd05/dbbridge/gslis-cluster/mongodb"
local_dbdir="/hdfsd05/dbbridge/mongodb-databases"

for mongodb_host in $unique_hosts ; do
  remote_dir="$mongodb_host:$local_dir"

  echo "Running rsync from networked MONGODB_HOME to $remote_dir"
  ssh $mongodb_host "if [ ! -d $local_dir ] ; then mkdir $local_dir ; fi"
  rsync -pav "$MONGODB_HOME/." "$remote_dir/."

  ssh $mongodb_host "if [ ! -d $local_dbdir ] ; then mkdir $local_dbdir ; fi"
##  ssh $mongodb_host "if [ ! -d $local_dbdir/config-metadata ] ; then mkdir $local_dbdir/config-metadata ; fi"

done
