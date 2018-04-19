#!/bin/bash

unique_hosts=`echo $SOLR_NODES | tr ' ' '\n' | sed 's/:.*$//' | sort | uniq`

echo "Running 'du -hs' on all Solr shards"

local_dir="/hdfsd05/dbbridge/solr-ef"

for solr_host in $unique_hosts ; do
#  ssh $solr_host du -hs /tmp/solr-ef/solr/*shard*;
  ssh $solr_host du -hs $local_dir/*shard*;
done
