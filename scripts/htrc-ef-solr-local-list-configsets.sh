#!/bin/bash

echo ""
echo "Configsets in $SOLR_HOME:"
solr_configsets=`ls "$SOLR_HOME/configsets/"`
for sc in $solr_configsets ; do
    echo "  $sc"
done

echo ""
echo "Configsets/Collections in Zookeeper $ZOOKEEPER_SERVER"
zookeeper_configs=`htrc-ef-zookeeper-cli.sh ls /configs | htrc-ef-zookeeper-cli-sanitize.awk`

echo $zookeeper_configs | egrep '^\[' \
    | sed 's/^\[/ /' | sed 's/\]$//' | tr ',' '\n' \
    | sed 's/^ /  /' | sort
echo ""

