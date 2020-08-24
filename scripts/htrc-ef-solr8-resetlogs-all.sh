#!/bin/bash

htrc_ef_solr_cloud_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

systemctl_user=${1:-www-data}
systemctl_group=${2:-htrc}

echo "****"
echo "* Running Solr8 log reset as user: $systemctl_user"
echo "****"

if [ "x$SOLR8_SHARDS" != "x" ] ; then
    # Nodes and Shards specified
    # => allows for shards to be stored on different local disks

    
    SOLR8_NODES_ARRAY=($SOLR8_NODES)
    SOLR8_SHARDS_ARRAY=($SOLR8_SHARDS)

    num_shards=${#SOLR8_NODES_ARRAY[*]}
    
    i=0
    
    while [ $i -lt $num_shards ] ; do
	solr_node=${SOLR8_NODES_ARRAY[$i]}
	solr_home_shard_dir=${SOLR8_SHARDS_ARRAY[$i]}
	
	solr_host=${solr_node%:*}
	solr_port=${solr_node##*:}

	if [ $solr_host = "peachpalm" ] || [ $solr_host = "royalpalm" ] ; then
	    systemctl_user="www-data"
	    systemctl_group="htrc-solr"
	fi
	
	server_dir="$SOLR8_SERVER_BASE_JETTY_DIR/solr-server-$solr_host-$solr_port"
	server_logs="$server_dir/logs"

	echo "ssh $solr_host"
  	ssh $solr_host sudo -u $systemctl_user -g $systemctl_group "$htrc_ef_solr_cloud_script_dir/_htrc-ef-solr8-resetlogs.sh" \
	     "$server_logs/solr.log" "$server_logs/solr_gc.log.0.current" "$server_logs/solr-$solr_port-console.log"

###	ssh $solr_host "sudo -u $systemctl_user -g $systemctl_group (cat < /dev/null > $server_logs/solr.log)"
	    
#	    "cat </dev/null >$server_logs/solr.log && cat </dev/null >$server_logs/solr_gc.log.0.current && cat </dev/null >$server_logs/solr-$solr_port-console..log"
	
	i=$((i+1))
    done
else
    echo "No implemented!" >&2
fi
