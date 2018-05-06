#!/bin/bash

#echo "***"
#echo "Zookeeper 3.4.9"
#echo "***"
#wget http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
#echo "***"
#echo ""

solr_ver=7.2.1

echo ""
echo "***"
echo "Solr $solr_ver"
echo "Note: There is a newer version out (7.3 released April 2018)"
echo " => consider upgrading?"
echo "***"
echo ""
wget http://archive.apache.org/dist/lucene/solr/$solr_ver/solr-$solr_ver.tgz

echo "***"
echo ""
