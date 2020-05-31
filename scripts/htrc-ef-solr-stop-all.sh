#!/bin/bash

solr_pid_dir="$SOLR_SERVER_BASE_JETTY_DIR"

for solr_node in $SOLR_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}
  solr_stop_port=$((solr_port-100))

  export SOLR_HOME=
  export SOLR_PID_DIR=

  echo "Stopping Solr cloud node: $solr_host"
  #  ssh $solr_host solr stop -p $solr_port

  ssh $solr_host "export STOP_PORT=$solr_stop_port" \&\& "export SOLR_PID_DIR=$solr_pid_dir" \&\& \
      \"\$SOLR7_TOP_LEVEL_HOME/bin/solr\" stop -p $solr_port 

done
