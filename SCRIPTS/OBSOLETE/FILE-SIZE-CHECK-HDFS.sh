#!/bin/bash

hdfs  dfs -du -s full-ef-json-files/* | awk '{ print $1 " " $3 }' | sed 's/full-ef-json-files\///'

