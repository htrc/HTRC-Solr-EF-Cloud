# 'Sourced' internal support script

# Assumes the following variables has been set:
#  $solr_cmd $solr_node $solr_home_shard_dir
    
solr_host=${solr_node%:*}
solr_port=${solr_node##*:}
    
solr_stop_port=$((solr_port-100))
    
server_dir="$SOLR_SERVER_BASE_JETTY_DIR/solr-server-$solr_host-$solr_port"

# Historically the following two environment variables used to be set in SETUP.sh
# But this then didn't allow for running both a Solr7 and Solr8 alongside each other
# Neither SETUP.sh and SETUP8.sh specify them anymore, but (safety first) 
# we'll explicitly make sure they're not set
export SOLR_HOME=
export SOLR_PID_DIR=
#export SOLR_PID_DIR="$solr_home_shard_dir"


echo "Running Solr7 command '$solr_cmd' for cloud node: $solr_host:$solr_port solr_home=$solr_home_shard_dir"
echo "  STOP.PORT overridden to be auto-magically solr.port minus 100: $solr_stop_port"

if [ "x$SOLR7_AUTH_TYPE" != "x" ] ; then    
    echo "  Setting environment variables SOLR_AUTH_TYPE and SOLR_AUTHENTICATION_OPTS"
    echo "  based on values in SOLR7_AUTH_TYPE and SOLR7_AUTHENTICATION_OPTS"
    
    export SOLR_AUTH_TYPE="SOLR7_AUTH_TYPE"
    export SOLR_AUTHENTICATION_OPTS="$SOLR7_AUTHENTICATION_OPTS"
fi

if [ $solr_cmd = "start" ] || [ $solr_cmd = "restart" ] ; then

    if [ "x$SOLR_JAVA_MEM" != "x" ] ; then
	echo "  SOLR_JAVA_MEM=$SOLR_JAVA_MEM"
    fi

    export SOLR_STOP=$solr_stop_port    
    "$SOLR_TOP_LEVEL_HOME/bin/solr" $solr_cmd -cloud -z $ZOOKEEPER_SERVER \
      -h $solr_host -p $solr_port -d "$server_dir" -s "$solr_home_shard_dir"
else
    # stop, status
    "$SOLR_TOP_LEVEL_HOME/bin/solr" $solr_cmd -cloud -z $ZOOKEEPER_SERVER
fi

