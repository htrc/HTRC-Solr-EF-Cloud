#!/bin/bash

for solr_node in $SOLR8_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}
  solr_stop_port=$((solr_port-100))
  
  export SOLR_HOME=
  export SOLR_PID_DIR=

  echo "Stopping Solr8 cloud node: $solr_host"
  ssh $solr_host "export STOP_PORT=$solr_stop_port" \&\& \
      \"\$SOLR8_TOP_LEVEL_HOME/bin/solr\" stop -p $solr_port 
done
