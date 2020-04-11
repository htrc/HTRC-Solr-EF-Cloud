#!/bin/bash

zookeeper_host=${ZOOKEEPER_SERVER%:*}

for zookeeper_host in solr3 solr4 solr5 ; do
    echo "Starting Zookeeper Ensemble node on $zookeeper_host"
    ssh $zookeeper_host zkServer.sh start
done