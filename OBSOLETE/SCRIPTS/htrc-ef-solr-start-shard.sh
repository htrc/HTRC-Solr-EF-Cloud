#!/bin/bash

solr_cmd=${1-start}
core_num=${2-null}

if [ "x$SOLR_SHARDS" != "x" ] ; then
    SOLR_NODES_ARRAY=($SOLR_NODES)
    SOLR_SHARDS_ARRAY=($SOLR_SHARDS)

    num_shards=${#SOLR_NODES_ARRAY[*]}
    
    i=0
    
    while [ $i -lt $num_shards ] ; do
	solr_node=${SOLR_NODES_ARRAY[$i]}
	solr_home_shard_dir=${SOLR_SHARDS_ARRAY[$i]}
	
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}

	server_dir="/disk0/solr-server-$solr_host-$solr_port"
	
	export SOLR_HOME=
	export SOLR_PID_DIR=
	#export SOLR_PID_DIR="$solr_home_shard_dir"
       	if [ "$core_num" == "null" ] || [ "$core_num" == "$i" ] ; then

	  echo "Starting solr cloud node on: $solr_host:$solr_port solr_home=$solr_home_shard_dir"
	  if [ "x$SOLR_JAVA_MEM" != "x" ] ; then
	    echo "=> SOLR_JAVA_MEM=$SOLR_JAVA_MEM"
	  fi
  	    ssh $solr_host solr $solr_cmd -cloud -z $ZOOKEEPER_SERVER -h $solr_host -p $solr_port -d "$server_dir" -s "$solr_home_shard_dir"
	fi
	
	i=$((i+1))
    done
else

    run_from_local_disk=1

    #local_dir="/tmp/solr-ef"
    local_dir="/hdfsd05/dbbridge/solr-ef"


    if [ $run_from_local_disk = "1" ] ; then
	opt_s="-s $local_dir"
	export SOLR_HOME=
	echo "****"
	echo "* Running solr from local disk: $local_dir"
	echo "****"
    else 
	opt_s=
    fi
    
    for solr_node in $SOLR_NODES ; do
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}
	
	echo "Starting solr cloud node on: $solr_host [port $solr_port]"
	ssh $solr_host solr $solr_cmd -cloud -z $ZOOKEEPER_SERVER -h $solr_host -p $solr_port $opt_s
    done
fi
