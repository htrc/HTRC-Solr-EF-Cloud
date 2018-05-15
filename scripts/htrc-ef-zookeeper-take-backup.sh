#!/bin/bash

backup_file=${1:-zoocreeper-backup.json}

echo ""
echo "Saving backup to: $backup_file"
echo ""

zoocreeper dump -z $ZOOKEEPER_SERVER > $backup_file


