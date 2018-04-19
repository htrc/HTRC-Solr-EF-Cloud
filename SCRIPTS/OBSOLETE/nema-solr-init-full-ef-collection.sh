#!/bin/bash

solr_num_shards=`echo $SOLR_NODES | wc -w`
solr_node_head=`echo $SOLR_NODES | tr ' ' '\n' | head -n 1`
solr_host=${solr_node_head%:*}


solr create \
     -c htrc-full-ef \
     -d htrc_configs \
     -shards $solr_num_shards \
     -replicationFactor 1
