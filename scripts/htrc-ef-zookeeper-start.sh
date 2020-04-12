#!/bin/bash

zookeeper_host=${ZOOKEEPER_SERVER%:*}

# Zookeeper config file (which sets port etc) is determined by Zookeeper home
# Zookeeper home is auto-magically determined from filesystem location of where zkServer.sh

ssh $zookeeper_host "$ZOOKEEPER_HOME/bin/zkServer.sh" start
