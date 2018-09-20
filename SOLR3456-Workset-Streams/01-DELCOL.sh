#!/bin/bash

#source ./SOLR3456-Workset-Streams/_setcol.sh
source ./_setcol.sh

#echo ""
#echo "Deleting collection:   $solrcol"
#echo "Through Solr node:     $solrhead"
#echo "Through Solr endpoint: $solradminurl"
#echo ""

echo ""
echo "*** This is the FULL version of the HTRC Extracted Features collection"
echo "*** IF YOU ARE REALLY SURE YOU WANT TO DELETE THIS, then run the following"
echo "*** wget command from terminal:"
echo ""

#echo '  wget "http://'$solrhead'/solr/admin/collections?action=DELETE&name='$solrcol'" -O -'
echo '  wget "'$solradminurl'/collections?action=DELETE&name='$solrcol'" -O -'
