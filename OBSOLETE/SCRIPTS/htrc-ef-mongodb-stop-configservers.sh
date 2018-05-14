#!/bin/bash

for h in $MONGODB_CONFIG_HOSTS ; do
  echo "*"
  echo "* Stopping MongoDB Config Server on $h:$MONGODB_CONFIG_PORT"
  echo "*"
  ssh $h "mongo --host localhost --port $MONGODB_CONFIG_PORT -eval \"db.getSiblingDB('admin').shutdownServer()\""
  echo "*****"
  echo ""
done
