#!/bin/bash

if [ ! -d zoocreeper-backups ] ; then
    echo ""
    echo "Creating directory 'zookcreeper-backups'"
    mkdir zoocreeper-backups
    echo ""
fi

htrc-ef-zookeeper-take-backup.sh zoocreeper-backups/backup-`date +%s`.json
