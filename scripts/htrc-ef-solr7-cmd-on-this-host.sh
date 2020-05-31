#!/bin/bash

htrc_ef_solr_cloud_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
htrc_ef_home=$( cd "$( dirname "$( dirname "$htrc_ef_solr_cloud_script_dir" )" )" && pwd )

if [ "x$SOLR7_TOP_LEVEL_HOME" == "x" ] ; then
  . "$htrc_ef_home/SETUP.bash"
fi

# Default Solr7 command to run to 'status' if not present
solr_cmd=${1:-status}

# See comment in the following file for what environment variables
# are expected, and how they are used to launch the various solr nodes/shards
. "$htrc_ef_solr_cloud_script_dir/htrc-ef-solr-check-env.sh"
    
SOLR_NODES_ARRAY=($SOLR_NODES)
SOLR_SHARDS_ARRAY=($SOLR_SHARDS)

num_shards=${#SOLR_NODES_ARRAY[*]}

short_hostname=`htrc-ef-short-hostname.sh`

zookeeper_status_ok=0

i=0
    
while [ $i -lt $num_shards ] ; do
    solr_node=${SOLR_NODES_ARRAY[$i]}
    solr_home_shard_dir=${SOLR_SHARDS_ARRAY[$i]}
    
    solr_host=${solr_node%:*}

    if [ $solr_host = $short_hostname ] ; then

	if [ "$solr_cmd" = "start" ] && [ "$zookeeper_status_ok" = "0" ] ; then
	    # Determine if this host is meant to have a Zookeeper running or not
	    # If yes, check it's status and auto-start if it isn't running

	    if [ "x$ZOOKEEPER_SERVER_ENSEMBLE" != "x" ] ; then
		zookeeper_server_list=$ZOOKEEPER_SERVER_ENSEMBLE
	    else
		zookeeper_server_list=$ZOOKEEPER_SERVER
	    fi

	    zookeeper_servers_host_port=$(echo $zookeeper_server_list | sed 's/,/ /g')

	    for zookeeper_host_port in $zookeeper_servers_host_port ; do
		zookeeper_host=${zookeeper_host_port%:*}
		
		if [ "$zookeeper_host" = "$short_hostname" ] ; then
		    # Yes there should be a Zookeeper running => check 'on-this-host' status
		    # Note: the 'on-this-host' version of zookeeper status works
		    # whether starting in Standalone mode or Ensemble configuration
		    htrc-ef-zookeeper-cli-on-this-host.sh status
		    
		    if [ $? != 0 ] ; then
			echo "No Zookeeper Server running => Starting ..."
			htrc-ef-zookeeper-cli-on-this-host.sh start

			# Time for one more check for good measure
			htrc-ef-zookeeper-cli-on-this-host.sh status
			if [ $? != 0 ] ; then
			    echo "Zookeeper Server needs to be running on this mahcine, but attempt to start failed" >&2
			else
			    echo "... Done"
			    zookeeper_status_ok=1
			fi
		    fi
		fi
	    done
	fi
	
	. "$htrc_ef_solr_cloud_script_dir/_htrc-ef-solr7-cmd-local-node-shard.sh"

	if [ "$solr_cmd" = "status" ] ; then
	    # Solr 'status' command prints out details about *all* the nodes known about
	    # on *this* *specific* *machine* in the Solr cloud/cluster
	    # => So no need to loop around any more values
	    break;
	fi
	
    fi

    
    i=$((i+1))
done
