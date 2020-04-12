#!/bin/bash

solr_cmd=${1-start}
core_num=${2-null}

if [ "x$SOLR8_SHARDS" != "x" ] ; then
    # Nodes and Shards specified
    # => allows for shards to be stored on different local disks
    # Done by controlling solr.home through -s
    # (which then sets SOLR_HOME in 'solr' script)
    #
    # When SOLR_PID_DIR is undefined, it is set based on SOLR_TIP/server/solr
    # (SOLR_TIP is auto-magically set to be the parent directory of where 'solr' script is)

    SOLR8_NODES_ARRAY=($SOLR8_NODES)
    SOLR8_SHARDS_ARRAY=($SOLR8_SHARDS)

    num_shards=${#SOLR8_NODES_ARRAY[*]}
    
    i=0
    
    while [ $i -lt $num_shards ] ; do
	solr_node=${SOLR8_NODES_ARRAY[$i]}
	solr_home_shard_dir=${SOLR8_SHARDS_ARRAY[$i]}
	
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}
	solr_stop_port=$((solr_port-100))
	
	server_dir="$SOLR8_SERVER_BASE_JETTY_DIR/solr-server-$solr_host-$solr_port"
	
	export SOLR_HOME=
	export SOLR_PID_DIR=
	#export SOLR_PID_DIR="$solr_home_shard_dir"
       	if [ "$core_num" == "null" ] || [ "$core_num" == "$i" ] ; then

	    echo "Starting solr8 cloud node on: $solr_host:$solr_port solr_home=$solr_home_shard_dir"
	    echo "  STOP.PORT overridden to be auto-magically solr.port minus 100: $solr_stop_port"
	    
	  if [ "x$SOLR_JAVA_MEM" != "x" ] ; then
	    echo "=> SOLR_JAVA_MEM=$SOLR_JAVA_MEM"
	  fi
	  ssh $solr_host "export SOLR_STOP=$solr_stop_port" \&\& \
  	      \"\$SOLR8_TOP_LEVEL_HOME/bin/solr\" $solr_cmd -cloud -z $ZOOKEEPER8_SERVER \
	      -h $solr_host -p $solr_port -d "$server_dir" -s "$solr_home_shard_dir"
	fi
	
	i=$((i+1))
    done
else
    # e.g., running on gsliscluster1
    # a configuration where all the shards are located in one area on a single disk
    

    run_from_local_disk=1

    #local_dir="/tmp/solr-ef"
    local_dir="/hdfsd05/dbbridge/solr-ef"


    if [ $run_from_local_disk = "1" ] ; then
	opt_s="-s $local_dir"
	export SOLR_HOME=
	export SOLR_PID_DIR=
	echo "****"
	echo "* Running solr8 from local disk: $local_dir"
	echo "****"
    else 
	opt_s=
    fi
    
    for solr_node in $SOLR8_NODES ; do
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}
	
	echo "Starting solr8 cloud node on: $solr_host [port $solr_port]"
	ssh $solr_host "$SOLR8_TOP_LEVEL_HOME/bin/solr" $solr_cmd -cloud -z $ZOOKEEPER8_SERVER -h $solr_host -p $solr_port $opt_s
    done
fi
