#!/bin/bash

unique_hosts=`echo $SOLR_NODES | tr ' ' '\n' | sed 's/:.*$//' | sort | uniq`

local_dir="/hdfsd05/dbbridge/solr-ef"

for solr_host in $unique_hosts ; do
  echo "Running 'rsync' on $solr_host -> nema:/tmp/$solr_host/solr-ef"
#  ssh $solr_host rsync -pav /tmp/solr-ef/solr nema:/tmp/${solr_host}-solr-ef
  ssh nema "if [ ! -d /tmp/${solr_host}-solr-ef ] ; then mkdir /tmp/${solr_host}-solr-ef ; fi"
  ssh $solr_host rsync -pav $local_dir/. nema:/tmp/${solr_host}-solr-ef/.
done
