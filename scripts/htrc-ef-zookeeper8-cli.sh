#!/bin/bash

if [ "x$ZOOKEEPER8_SERVER_ENSEMBLE" != "x" ] ; then
    zookeeper8_server=${ZOOKEEPER8_SERVER_ENSEMBLE%%,*}
else
    zookeeper8_server=$ZOOKEEPER8_SERVER
fi

"$ZOOKEEPER8_HOME/bin/zkCli.sh" -server $zookeeper8_server $*
