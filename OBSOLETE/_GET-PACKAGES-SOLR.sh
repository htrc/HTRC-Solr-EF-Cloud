#!/bin/bash

echo "***"
echo "Zookeeper 3.4.9"
echo "***"
wget http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
echo "***"
echo ""

solr_ver=6.4.0
echo "***"
echo "Solr $solr_ver"
echo "***"
#wget http://www-us.apache.org/dist/lucene/solr/6.2.1/solr-6.2.1.tgz
wget http://www-us.apache.org/dist/lucene/solr/$solr_ver/solr-$solr_ver.tgz

echo "***"
echo ""
