#!/bin/bash

col=${1:-solr3456-faceted-htrc-full-ef16}

solr healthcheck -c $col -z $ZOOKEEPER_SERVER 

