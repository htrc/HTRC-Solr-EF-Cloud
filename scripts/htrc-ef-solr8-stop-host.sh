#!/bin/bash

if [ $# != 1 ] ; then
    prog_name=${0##*/}
    echo "" >&2
    echo "Usgae: $prog_name <hostname>" >&2
    echo "  e.g. $prog_name solr3" >&2
    echo "" >&2
    exit 1
fi

cmd_host=$1

for solr_node in $SOLR8_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}
  solr_stop_port=$((solr_port-100))
  
  if [ $solr_host = $cmd_host ] ; then
    export SOLR_HOME=
    export SOLR_PID_DIR=
    echo "Stopping Solr8 cloud node: $solr_host"
    ssh $solr_host "export STOP_PORT=$solr_stop_port" \&\& \
	\"\$SOLR8_TOP_LEVEL_HOME/bin/solr\" stop -p $solr_port 
  fi
done
