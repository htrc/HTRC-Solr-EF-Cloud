#!/bin/bash

htrc_ef_solr_cloud_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
htrc_ef_home=$( cd "$( dirname "$( dirname "$htrc_ef_solr_cloud_script_dir" )" )" && pwd )

if [ "x$SOLR7_TOP_LEVEL_HOME" == "x" ] ; then
    . "$htrc_ef_home/SETUP.bash"
fi

zookeeper_cmd=${1:-status}

if [ "x$ZOOKEEPER_SERVER_ENSEMBLE" != "x" ] ; then
    echo "For Zookeeper Ensemble Node on this host: Running command '$zookeeper_cmd'"    
else
    echo "Zookeeper in Standalone mode: Running command '$zookeeper_cmd'"
fi

# Zookeeper config file (which sets port etc) is determined by Zookeeper home
# Zookeeper home is auto-magically determined from filesystem location of where zkServer.sh

export ZOO_LOG_DIR="$ZOOKEEPER_HOME/logs"
"$ZOOKEEPER_HOME/bin/zkServer.sh" $zookeeper_cmd
