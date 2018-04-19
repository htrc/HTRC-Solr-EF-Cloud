#!/bin/bash

repl_set=htrc-ef-config-metadata

for h in $MONGODB_CONFIG_HOSTS ; do
  echo "* Starting MongoDB Config Server on $h:$MONGODB_CONFIG_PORT"
  repl_dir="$MONGODB_DBDIR/$repl_set-$h"
  ssh $h "if [ ! -d $repl_dir ] ; then mkdir $repl_dir ; fi"

  ssh $h "mongod --configsvr --replSet $repl_set --dbpath \"$repl_dir\" --port $MONGODB_CONFIG_PORT > mongodb-output-$h-config.log &"
done

# mongod --configsvr --port 26050 --logpath /var/lib/mongodb/shardedcluster/log.cfg0 --logappend --dbpath /var/lib/mongodb/shardedcluster/cfg0 --fork
# mongod --configsvr --port 26051 --logpath /var/lib/mongodb/shardedcluster/log.cfg1 --logappend --dbpath /var/lib/mongodb/shardedcluster/cfg1 --fork
# mongod --configsvr --port 26052 --logpath /var/lib/mongodb/shardedcluster/log.cfg2 --logappend --dbpath /var/lib/mongodb/shardedcluster/cfg2 --fork