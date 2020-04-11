#!/bin/bash

#source ./SOLR3456-Workset-Streams/_setcol.sh
source ./_setcol.sh

echo ""
echo "Creating collection:   $solrcol"
#echo "Through Solr node:     $solrhead"
echo "Through Solr endpoint: $solradminurl"
echo ""


#wget "http://$solrhead/solr/admin/collections?action=CREATE&$name=solrcol&numShards=16&replicationFactor=2&collection.configName=$solrconfig" -O -

wget "$solradminurl/collections?action=CREATE&name=$solrcol&numShards=$solrShardCount&replicationFactor=$solrReplCount&collection.configName=$solrconfig" -O -
