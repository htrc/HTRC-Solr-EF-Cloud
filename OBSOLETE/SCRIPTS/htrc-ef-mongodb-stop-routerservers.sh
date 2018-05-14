#!/bin/bash

for h in $MONGODB_ROUTER_HOSTS ; do
  echo "*"
  echo "* Stopping MongoDB Router Server on $h:$MONGODB_ROUTER_PORT"
  echo "*"
  ssh $h "mongo --host localhost --port $MONGODB_ROUTER_PORT -eval \"db.getSiblingDB('admin').shutdownServer()\""

  echo "*****"
  echo ""
done
