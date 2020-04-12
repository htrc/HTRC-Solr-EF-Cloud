#!/bin/bash

solr_num_shards=`echo $SOLR_NODES | wc -w`
solr_node_head=`echo $SOLR_NODES | tr ' ' '\n' | head -n 1`
solr_host=${solr_node_head%:*}

solr_config=${1:-htrc_configs}

#ssh $solr_host \
#    solr zk upconfig \
#    -d $solr_config \
#    -z $ZOOKEEPER_SERVER

ssh $solr_host \
    "$SOLR7_TOP_LEVEL_HOME/bin/solr" zk upconfig \
    -d "$SOLR7_HOME/configsets/$solr_config" -n $solr_config \
    -z $ZOOKEEPER_SERVER

