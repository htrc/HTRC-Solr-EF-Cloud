#!/bin/bash

solr_num_shards=`echo $SOLR8_NODES | wc -w`
solr_node_head=`echo $SOLR8_NODES | tr ' ' '\n' | head -n 1`
solr_host=${solr_node_head%:*}

solr_config=${1:-htrc-configs-docvals}

ssh $solr_host \
    "$SOLR8_TOP_LEVEL_HOME/bin/solr" zk upconfig \
    -d "$SOLR8_HOME/configsets/$solr_config" -n $solr_config \
    -z $ZOOKEEPER8_SERVER

