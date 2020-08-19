#!/bin/bash

if [ "x$ZOOKEEPER_SERVER_ENSEMBLE" != "x" ] ; then
    zookeeper_server=${ZOOKEEPER_SERVER_ENSEMBLE%%,*}
else
    zookeeper_server=$ZOOKEEPER_SERVER
fi

"$ZOOKEEPER_HOME/bin/zkCli.sh" -server $zookeeper_server $*
