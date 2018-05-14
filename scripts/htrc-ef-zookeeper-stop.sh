#!/bin/bash

zookeeper_host=${ZOOKEEPER_SERVER%:*}

ssh $zookeeper_host zkServer.sh stop
