#!/bin/bash

htrc_ef_solr_cloud_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
htrc_ef_home=$( cd "$( dirname "$htrc_ef_solr_cloud_script_dir/../.." )" && pwd )

if [ "x$HTRC_EF_NETWORK_HOME" == "x" ] ; then
  . "$htrc_ef_home/SETUP8.sh"
fi

# Default Solr8 command to run to 'status' if not present
solr_cmd=${1:-status}

# See comment in the following file for what environment variables
# are expected, and how they are used to launch the various solr nodes/shards
. "$htrc_ef_solr_cloud_script_dir/htrc-ef-solr8-check-env.sh"
    
SOLR8_NODES_ARRAY=($SOLR8_NODES)
SOLR8_SHARDS_ARRAY=($SOLR8_SHARDS)

num_shards=${#SOLR8_NODES_ARRAY[*]}

short_hostname=`htrc-ef-short-hostname.sh`

i=0
    
while [ $i -lt $num_shards ] ; do
    solr_node=${SOLR8_NODES_ARRAY[$i]}
    solr_home_shard_dir=${SOLR8_SHARDS_ARRAY[$i]}
    
    solr_host=${solr_node%:*}

    if [ $solr_host = $short_hostname ] ; then
	. "$htrc_ef_solr_cloud_script_dir/_htrc-ef-solr8-cmd-local-node-shard.sh"
    fi

    if [ "$solr_cmd" = "status" ] ; then
	# Solr 'status' command prints out details about *all* the nodes known about
	# on *this* *specific* *machine* in the Solr cloud/cluster
	# => So no need to loop around any more values
	break;
    fi
    
    i=$((i+1))
done
