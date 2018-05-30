#!/bin/bash

echo ""
echo "Configsets in $SOLR_HOME:"
ls "$SOLR_HOME/configsets/"

echo ""
echo "Configsets/Collections in Zookeeper $ZOOKEEPER_SERVER"
htrc-ef-zookeeper-cli.sh ls /configs | htrc-ef-zookeeper-cli-sanitize.awk
echo ""

