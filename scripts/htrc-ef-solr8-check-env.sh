# This script is typically sourced, for example:
#  . ./htrc-ef-solr8-check-env.sh


# Method for running solr cloud based by environment variables that specify
# Nodes (host and port) and Shards (top-level directory of where collection shard is)
#
# => Done this to allow for multiple shards to be running on same host machine (different port)
#    But at the same time, allow for those different shards to be stored on different local
#    disks on that particular machine
#
# => To launch a particular solr process, this info is then pulled apart and used to specify
#    particular Solr8 variables and parameters.
#    A key parameter to specify is '-s' with sets SOLR_HOME (in the Apache's 'solr' script),
#    which in turn sets the Java property 'solr.home'
#
#    Also note: When SOLR_PID_DIR is undefined, it is set based on SOLR_TIP/server/solr
#    (SOLR_TIP is auto-magically set to be the parent directory of where 'solr' script is)


if [ "x$SOLR8_NODES" == "x" ] ; then    
    echo "Error: Missing environment variable SOLR8_NODES" >&2
    echo "       This needs to be defined to control which hosts and port numbers the Solr8 cloud operates on" >&2
    echo "For example:" >&2
    echo "    export SOLR8_NODES=\"solr1:9983 solr1:9984 solr2:9983 solr2:9984\"" >&2
    exit 1
elif [ "x$SOLR8_SHARDS" == "x" ] ; then    
    echo "Error: Missing environment variable SOLR8_SHARDS" >&2
    echo "       This is the companion environment variable used to specify where the Solr8 indexes are on the file system" >&2
    echo "For example:" >&2
    echo "    export SOLR8_NODES=\"/disk0/solr8-full-ef /disk1/solr8-full-ef /disk0/solr8-full-ef /disk1/solr8-full-ef\"" >&2
    exit 1
fi
