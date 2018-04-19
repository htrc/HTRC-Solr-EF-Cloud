#!/bin/bash

unique_hosts=`echo $SOLR_NODES | tr ' ' '\n' | sed 's/:.*$//' | sort | uniq`

echo "Running 'df' on all Solr hosts"

for solr_host in $unique_hosts ; do
  ssh $solr_host df -h /tmp;
done
