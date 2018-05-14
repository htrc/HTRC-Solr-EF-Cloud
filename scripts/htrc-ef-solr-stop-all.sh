#!/bin/bash

for solr_node in $SOLR_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}
  echo "Stopping Solr cloud node: $solr_host"
  ssh $solr_host solr stop -p $solr_port
done
