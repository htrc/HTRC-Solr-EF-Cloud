#!/bin/bash

if [ ! -d zoocreeper8-backups ] ; then
    echo ""
    echo "Creating directory 'zookcreeper8-backups'"
    mkdir zoocreeper8-backups
    echo ""
fi

htrc-ef-zookeeper8-take-backup.sh zoocreeper8-backups/backup-`date +%s`.json
