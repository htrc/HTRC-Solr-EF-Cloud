#!/bin/bash

export SOLR_HOME=
export SOLR_PID_DIR=

if [ "x$ZOOKEEPER_SERVER_ENSEMBLE" != "x" ] ; then
    zookeeper_server_list=$ZOOKEEPER_SERVER_ENSEMBLE
else
    zookeeper_server_list=$ZOOKEEPER_SERVER
fi

short_hostname=`uname -n | sed 's/\..*//'`

if [ "${short_hostname%[1-2]}" = "solr" ] ; then
    col=${1:-faceted-htrc-full-ef20}
else 
    col=${1:-solr3456-faceted-htrc-full-ef16}
fi

#solr healthcheck -c $col -z $ZOOKEEPER_SERVER 
"$SOLR7_TOP_LEVEL_HOME/bin/solr" healthcheck -c "$col" -z $zookeeper_server_list
