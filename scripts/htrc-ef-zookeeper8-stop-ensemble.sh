#!/bin/bash

for zookeeper_host in solr3 solr4 solr5 ; do
    echo "Stopping Zookeeper Ensemble node on $zookeeper_host"

    # Zookeeper config file (which sets port etc) is determined by Zookeeper home
    # Zookeeper home is auto-magically determined from filesystem location of where zkServer.sh

    ssh $zookeeper_host "$ZOOKEEPER8_HOME/bin/zkServer.sh" stop
done
