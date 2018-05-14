#!/bin/bash

repl_set="htrc-ef-config-metadata"

member_elems=""

i=0
for h in $MONGODB_CONFIG_HOSTS ; do
  # aiming for lines that look like:
  #   ,{ _id : 0, host : "cfg1.example.net:27017" }

  if [ "x$member_elems" != "x" ] ; then
    member_elems="$member_elems,"
  fi

  member_elems="$member_elems{ _id : $i, host : \\\"$h:$MONGODB_CONFIG_PORT\\\" }"

  if [ $i == 0 ] ; then
    primary_host="$h"
  fi

  i=$((i+1))
done


init_syntax="rs.initiate(  { _id: \\\"$repl_set\\\", configsvr: true, members: [ $member_elems ] } )"

echo "* Initializing MongoDB Config Server Replica Set"


ssh $primary_host "mongo --host localhost --port $MONGODB_CONFIG_PORT -eval \"$init_syntax\""



#rs.initiate(
#  {
#    _id: "<replSetName>",
#    configsvr: true,
#    members: [
#      { _id : 0, host : "cfg1.example.net:27017" },
#      { _id : 1, host : "cfg2.example.net:27017" },
#      { _id : 2, host : "cfg3.example.net:27017" }
#    ]
#  }
#)

