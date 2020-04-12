#!/bin/bash

solr_num_shards=`echo $SOLR_NODES | wc -w`
solr_node_head=`echo $SOLR_NODES | tr ' ' '\n' | head -n 1`
solr_host=${solr_node_head%:*}

solr_col=${1:-htrc-full-ef}

ssh $solr_host \
  \"\$SOLR7_TOP_LEVEL_HOME/bin/solr\" delete \    
     -c $solr_col
