#!/bin/bash


router_hosts_array=($MONGODB_ROUTER_HOSTS)
head_router_host=${router_hosts_array[0]}


col_init_syntax="db = db.getSiblingDB('htrc_ef') ; \
  sh.enableSharding(\\\"htrc_ef\\\") ; \
  db.volumes.ensureIndex( { _id : \\\"hashed\\\" } ) ; \
  sh.shardCollection(\\\"htrc_ef.volumes\\\", { \\\"_id\\\": \\\"hashed\\\" } )"

ssh $head_router_host "mongo --host localhost --port $MONGODB_ROUTER_PORT -eval \"$col_init_syntax\""

# use htrc_ef; 
# sh.enableSharding("htrc_ef")
# db.volumes.ensureIndex( { _id : "hashed" } )
# sh.shardCollection("htrc_ef.volumes", { "_id": "hashed" } )