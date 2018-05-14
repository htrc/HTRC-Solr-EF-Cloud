#!/bin/bash



repl_set_core="htrc-ef"

MONGODB_REPLSET_META_ARRAY=($MONGODB_REPLSET_METALIST)

num_shards=${#MONGODB_REPLSET_META_ARRAY[*]}

i=0
while [ $i -lt $num_shards ]; do

  replset_meta_hosts=${MONGODB_REPLSET_META_ARRAY[$i]}
  eval replset_hosts="`echo \\$$replset_meta_hosts`"

  for h in $replset_hosts ; do
    echo "* Stopping MongoDB Replica-set Shard$i Server on $h:$MONGODB_REPLSET_PORT"
    repl_set="$repl_set_core-shard$i"
    repl_shard_dir="$MONGODB_DBDIR/$repl_set-$h"
    ssh $h "mongo --host localhost --port $MONGODB_REPLSET_PORT -eval \"db.getSiblingDB('admin').shutdownServer()\""
#    ssh $h "mongod --dbdir $repl_shard_dir --shutdown"
  done

  i=$((i+1))
  echo ""
done


