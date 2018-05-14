#!/bin/bash

function generate_member_elems
{
  hosts=$1

  member_elems=""

  mi=0
  for h in $hosts ; do
    # aiming for lines that look like:
    #   ,{ _id : 0, host : "shard1-rep1.example.net:27017" }

    if [ "x$member_elems" != "x" ] ; then
      member_elems="$member_elems,"
    fi

    member_elems="$member_elems{ _id : $mi, host : \\\"$h:$MONGODB_REPLSET_PORT\\\" }"

    if [ $mi == 0 ] ; then
      primary_host="$h"
    fi

    mi=$((mi+1))
  done

}


repl_set_core="htrc-ef"

MONGODB_REPLSET_META_ARRAY=($MONGODB_REPLSET_METALIST)
num_shards=${#MONGODB_REPLSET_META_ARRAY[*]}

i=0
while [ $i -lt $num_shards ]; do

  repl_set="$repl_set_core-shard$i"

  replset_meta_hosts=${MONGODB_REPLSET_META_ARRAY[$i]}
  eval replset_hosts="`echo \\$$replset_meta_hosts`"

  generate_member_elems "$replset_hosts"

  init_syntax="rs.initiate(  { _id: \\\"$repl_set\\\", members: [ $member_elems ] } )"

  echo "* Initializing MongoDB Shard Server Replica Set$i"

  ssh $primary_host "mongo --host localhost --port $MONGODB_REPLSET_PORT -eval \"$init_syntax\""


  i=$((i+1))
  echo ""
done



