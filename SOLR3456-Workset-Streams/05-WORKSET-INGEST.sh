#!/bin/bash

#source ./SOLR3456-Workset-Streams/_setcol.sh
source ./_setcol.sh

# curl -X POST -H 'Content-Type: application/json' 'https://solr1.ischool.illinois.edu/robust-solr/solr3456-worksets-htrc-full-ef16/update' --data-binary '
# {
#   ...
# }'

#wget -S -header='Content-Type: application/json' -O - -post-data '{ ... }'  http://server:8080/application2/params2

solr_update_url="https://solr1.ischool.illinois.edu/robust-solr/$solrcol/update?commit=true"

for full_wsid_json in `ls WORKSETS-PER-ID/*.json` ; do
    wsid_json=${full_wsid_json##*/}
    wsid=${wsid_json%.*}
    echo "Ingesting into Solr $solrcol: $wsid"

    json_data=`cat $full_wsid_json`
    wget -S --header="Content-Type: application/json" --header="Accept-Charset: UTF-8" \
	 -O - --post-data "$json_data"  $solr_update_url
    
done


