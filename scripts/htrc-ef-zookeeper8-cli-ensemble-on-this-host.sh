#!/bin/bash

htrc_ef_solr_cloud_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
htrc_ef_home=$( cd "$( dirname "$( dirname "$htrc_ef_solr_cloud_script_dir" )" )" && pwd )

if [ "x$SOLR8_TOP_LEVEL_HOME" == "x" ] ; then
    . "$htrc_ef_home/SETUP8.bash"
fi

zookeeper_cmd=${1:-status}

echo "For Zookeeper Ensemble Node on this host: Running command '$zookeeper_cmd'"

# Zookeeper config file (which sets port etc) is determined by Zookeeper home
# Zookeeper home is auto-magically determined from filesystem location of where zkServer.sh

"$ZOOKEEPER8_HOME/bin/zkServer.sh" $zookeeper_cmd
