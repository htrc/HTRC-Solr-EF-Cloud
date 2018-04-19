#!/bin/bash

repl_set="htrc-ef-config-metadata"

configdb_arg=""

for h in $MONGODB_CONFIG_HOSTS ; do
  if [ "x$configdb_arg" != "x" ] ; then
    configdb_arg="$configdb_arg,"
  fi

  configdb_arg="$configdb_arg$h:$MONGODB_CONFIG_PORT"
done


for h in $MONGODB_ROUTER_HOSTS ; do
  echo "* Starting MongoDB Router Server on $h:$MONGODB_ROUTER_PORT"

  ssh $h "mongos --configdb $repl_set/$configdb_arg --port $MONGODB_ROUTER_PORT > mongodb-output-$h-router.log &"

done

# mongos --configdb juan-mongodbspain:26050,juan-mongodbspain:26051,juan-mongodbspain:26052 --fork --logappend --logpath /var/lib/mongodb/shardedcluster/log.mongos0
# mongos --configdb juan-mongodbspain:26050,juan-mongodbspain:26051,juan-mongodbspain:26052 --fork --logappend --logpath /var/lib/mongodb/shardedcluster/log.mongos1 --port 26061
