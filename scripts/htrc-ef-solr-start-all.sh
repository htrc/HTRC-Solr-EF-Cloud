#!/bin/bash

solr_cmd=${1:-start}

if [ "x$ZOOKEEPER8_SERVER_ENSEMBLE" != "x" ] ; then
    zookeeper_server_list=$ZOOKEEPER8_SERVER_ENSEMBLE
else
    zookeeper_server_list=$ZOOKEEPER8_SERVER
fi

solr_pid_dir="$SOLR_SERVER_BASE_JETTY_DIR"

if [ "x$SOLR_SHARDS" != "x" ] ; then
    # Nodes and Shards specified
    # => allows for shards to be stored on different local disks
    # Done by controlling solr.home through -s
    # (which then sets SOLR_HOME in 'solr' script)
    #
    # When SOLR_PID_DIR is undefined, it is set based on SOLR_TIP/server/solr
    # (SOLR_TIP is auto-magically set to be the parent directory of where 'solr' script is)
    
    SOLR_NODES_ARRAY=($SOLR_NODES)
    SOLR_SHARDS_ARRAY=($SOLR_SHARDS)

    num_shards=${#SOLR_NODES_ARRAY[*]}
    
    i=0
    
    while [ $i -lt $num_shards ] ; do
	solr_node=${SOLR_NODES_ARRAY[$i]}
	solr_home_shard_dir=${SOLR_SHARDS_ARRAY[$i]}
	
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}
	solr_stop_port=$((solr_port-100))
	
	server_dir="$SOLR_SERVER_BASE_JETTY_DIR/solr-server-$solr_host-$solr_port"
	
	export SOLR_HOME=
	export SOLR_PID_DIR=
	#export SOLR_PID_DIR="$solr_home_shard_dir"
	echo "Starting solr cloud node on: $solr_host:$solr_port solr_home=$solr_home_shard_dir"
	echo "  STOP.PORT overridden to be auto-magically solr.port minus 100: $solr_stop_port"
	
	if [ "x$SOLR_JAVA_MEM" != "x" ] ; then
	    echo "  SOLR_JAVA_MEM=$SOLR_JAVA_MEM"
	fi	

	ssh $solr_host "export STOP_PORT=$solr_stop_port" \&\& "export SOLR_PID_DIR=$solr_pid_dir" \&\& \
	    \"\$SOLR7_TOP_LEVEL_HOME/bin/solr\" $solr_cmd -cloud -z $ZOOKEEPER_SERVER \
	    -h $solr_host -p $solr_port -d "$server_dir" -s "$solr_home_shard_dir"
	
	i=$((i+1))
    done
else

    run_from_local_disk=1

    #local_dir="/tmp/solr-ef"
    local_dir="/hdfsd05/dbbridge/solr-ef"


    if [ $run_from_local_disk = "1" ] ; then
	# Control solr.home through -s argument
	opt_s="-s $local_dir"
	export SOLR_HOME=
	export SOLR_PID_DIR=
	echo "****"
	echo "* Running solr from local disk: $local_dir"
	echo "****"
    else 
	opt_s=
    fi
    
    for solr_node in $SOLR_NODES ; do
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}
	solr_stop_port=$((solr_port-100))
	
	echo "Starting solr cloud node on: $solr_host [port $solr_port]"
	echo "  STOP.PORT overridden to be auto-magically solr.port minus 100: $solr_stop_port"
	
	ssh $solr_host "export STOP_PORT=$solr_stop_port" \&\& "export SOLR_PID_DIR=$solr_pid_dir" \&\& \
	    \"\$SOLR7_TOP_LEVEL_HOME/bin/solr\" $solr_cmd -cloud -z $ZOOKEEPER_SERVER \
	    -h $solr_host -p $solr_port $opt_s
	
    done
fi
