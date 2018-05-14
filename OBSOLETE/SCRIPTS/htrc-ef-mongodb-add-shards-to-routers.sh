#!/bin/bash

repl_set_core="htrc-ef"

MONGODB_REPLSET_META_ARRAY=($MONGODB_REPLSET_METALIST)
num_shards=${#MONGODB_REPLSET_META_ARRAY[*]}

router_hosts_array=($MONGODB_ROUTER_HOSTS)
head_router_host=${router_hosts_array[0]}

i=0
while [ $i -lt $num_shards ]; do

  repl_set="$repl_set_core-shard$i"

  replset_meta_hosts=${MONGODB_REPLSET_META_ARRAY[$i]}
  eval replset_hosts="`echo \\$$replset_meta_hosts`"

  shard_hosts_array=($replset_hosts)
  primary_shard_host=${shard_hosts_array[0]}

  # e.g., sh.addShard( "<replSetName>/s1-mongo1.example.net:27017")
  add_syntax="sh.addShard( \\\"$repl_set/$primary_shard_host:$MONGODB_REPLSET_PORT\\\" )"

  echo "* Adding MongoDB Shard Server Replica Set$i to Router $head_router_host"
  ssh $head_router_host "mongo --host localhost --port $MONGODB_ROUTER_PORT -eval \"$add_syntax\""

  i=$((i+1))
  echo ""
done


