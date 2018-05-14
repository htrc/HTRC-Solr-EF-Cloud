#!/bin/bash

i=0

for solr_node in $SOLR_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}

#  opt_s="-s /tmp/gc$i-solr-ef/solr"
  opt_s="-s /tmp/gc$i-solr-ef"

  echo "Starting solr cloud node on: $solr_host [port $solr_port]"
  solr start -cloud -z $ZOOKEEPER_SERVER -h $solr_host -p $solr_port $opt_s

  i=$((i+1))
done
