#!/bin/bash

repl_set_core="htrc-ef"


MONGODB_REPLSET_META_ARRAY=($MONGODB_REPLSET_METALIST)

num_shards=${#MONGODB_REPLSET_META_ARRAY[*]}

i=0

while [ $i -lt $num_shards ]; do

  replset_meta_hosts=${MONGODB_REPLSET_META_ARRAY[$i]}
  eval replset_hosts="`echo \\$$replset_meta_hosts`"

  for h in $replset_hosts ; do
    echo "* Starting MongoDB Replica-set Shard$i Server on $h:$MONGODB_REPLSET_PORT"
    repl_set="$repl_set_core-shard$i"
    repl_shard_dir="$MONGODB_DBDIR/$repl_set-$h"
    ssh $h "if [ ! -d $repl_shard_dir ] ; then mkdir $repl_shard_dir ; fi"
    ssh $h "mongod --shardsvr --replSet $repl_set --dbpath \"$repl_shard_dir\" --port $MONGODB_REPLSET_PORT > mongodb-output-$h-replset$i.log &"
  done

  i=$((i+1))
  echo ""
done





#for h in $MONGODB_REPLSET2_HOSTS ; do
#  repl_set="$repl_set_core-shard2"
#  repl_shard_dir="$MONGODB_DBDIR/$repl_set-$h"
#  ssh $h "if [ ! -d $repl_shard_dir ] ; then mkdir $repl_shard_dir ; fi"
#  echo "* Starting MongoDB Replica-set Shard2 Server on $h:$MONGODB_REPLSET_PORT"
#  ssh $h "mongod --shardsvr --replSet $repl_set --dbpath \"$repl_shard_dir\" --port $MONGODB_REPLSET_PORT > mongodb-output-$h-replset2.log &"
#done


## mongod --shardsvr --replSet a --dbpath /var/lib/mongodb/shardedcluster/a0 --logpath /var/lib/mongodb/shardedcluster/log.a0 --port 27000 --fork --logappend --smallfiles --oplogSize 50
## ...
## mongod --shardsvr --replSet a --dbpath /var/lib/mongodb/shardedcluster/a1 --logpath /var/lib/mongodb/shardedcluster/log.a1 --port 27001 --fork --logappend --smallfiles --oplogSize 50

# Then same for 'b'