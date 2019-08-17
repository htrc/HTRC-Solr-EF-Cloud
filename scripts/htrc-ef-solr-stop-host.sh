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

for solr_node in $SOLR_NODES ; do
  solr_host=${solr_node%:*}
  solr_port=${solr_node##*:}
  if [ $solr_host = $cmd_host ] ; then
    echo "Stopping Solr cloud node: $solr_host"
    ssh $solr_host solr stop -p $solr_port
  fi
done
