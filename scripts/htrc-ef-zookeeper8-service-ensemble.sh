#!/bin/bash

zookeeper_cmd=${1:-status}

zookeeper_servers_host_port=$(echo $ZOOKEEPER8_SERVER_ENSEMBLE | sed 's/,/ /g')

for zookeeper_host_port in $zookeeper_servers_host_port ; do
    zookeeper_host=${zookeeper_host_port%:*}
    echo "======"
    echo "For Zookeeper Ensemble Node $zookeeper_host_port: Running command '$zookeeper_cmd'"

    # Zookeeper config file (which sets port etc) is determined by Zookeeper home
    # Zookeeper home is auto-magically determined from filesystem location of where zkServer.sh

    ssh $zookeeper_host "$ZOOKEEPER8_HOME/bin/zkServer.sh" $zookeeper_cmd
    echo "======"
done
