#!/bin/bash

if [ "x$SOLR8_SHARDS" != "x" ] ; then
    SOLR8_NODES_ARRAY=($SOLR8_NODES)
    SOLR8_SHARDS_ARRAY=($SOLR8_SHARDS)

    num_shards=${#SOLR8_NODES_ARRAY[*]}
    
    i=0
    
    while [ $i -lt $num_shards ] ; do
	solr_node=${SOLR8_NODES_ARRAY[$i]}
	solr_home_shard_dir=${SOLR8_SHARDS_ARRAY[$i]}
	
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}

	remote_dir="$solr_host:$solr_home_shard_dir"

	echo "Running rsync from networked SOLR8_HOME to $remote_dir"
	ssh $solr_host "if [ ! -d $solr_home_shard_dir ] ; then mkdir $solr_home_shard_dir ; fi"
	rsync -pav "$SOLR8_HOME/." "$remote_dir/."

	server_dir="$SOLR8_SERVER_BASE_JETTY_DIR/solr-server-$solr_host-$solr_port"
	remote_server_dir="$solr_host:$server_dir"
	
	echo "Running rsync from networked SOLR8_TOP_LEVEL_HOME/server to $remote_server_dir"
	ssh $solr_host "if [ ! -d $server_dir ] ; then mkdir $server_dir ; fi"
	rsync -pav "$SOLR8_TOP_LEVEL_HOME/server/." "$remote_server_dir/."
	echo
	
	i=$((i+1))
    done
else 

  unique_hosts=`echo $SOLR8_NODES | tr ' ' '\n' | sed 's/:.*$//' | sort | uniq`

  #local_dir="/tmp/solr-ef"
  local_dir1="/hdfsd05/dbbridge/solr-ef"
  local_dir2="/hdfsd05/dbbridge/gslis-cluster/solr/server/solr"

  for solr_host in $unique_hosts ; do
    remote_dir1="$solr_host:$local_dir1"
    remote_dir2="$solr_host:$local_dir2"

    echo "Running rsync from networked SOLR8_HOME to $remote_dir1"
    ssh $solr_host "if [ ! -d $local_dir1 ] ; then mkdir $local_dir1 ; fi"
    rsync -pav "$SOLR8_HOME/." "$remote_dir1/."

    echo "Running rsync from networked SOLR8_HOME to $remote_dir2"
    ssh $solr_host "if [ ! -d $local_dir2 ] ; then mkdir $local_dir2 ; fi"
    rsync -pav "$SOLR8_HOME/." "$remote_dir2/."
  done
fi
