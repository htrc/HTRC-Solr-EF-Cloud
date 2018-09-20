#!/bin/bash

#source ./SOLR3456-Workset-Streams/_setcol.sh
source ./_setcol.sh

# Example JSON add record:
#
#  "add": {
#    "commitWithin": 10000, 
#    "overwrite": false,  
#    "doc": {
#      "id": "aeu.ark:/13960/t8tb20k08",
#      "worksetid_ss": "09fecd10-b543-11e8-bd63-2587a66f96d9"
#    }
#  }


for full_wsid_txt in `ls WORKSETS-PER-ID/*.txt` ; do
    wsid_txt=${full_wsid_txt##*/}
    wsid=${wsid_txt%.*}
    echo "Processing $wsid"

    wsid_solr_json=${full_wsid_txt%.*}.json

    #echo "Generating $wsid_solr_json"
    echo '[' > $wsid_solr_json    

    needs_comma=""
    for vid in `cat $full_wsid_txt` ; do
	echo "  $vid"
	echo $needs_comma   >> $wsid_solr_json
	echo ' {'                         >> $wsid_solr_json
#	echo '  "add": {'                 >> $wsid_solr_json
#	echo '    "commitWithin": 10000,' >> $wsid_solr_json
#	echo '    "overwrite": false,'    >> $wsid_solr_json

#	echo '    "doc": {' >> $wsid_solr_json
	echo '      "id": "'$vid'",'           >> $wsid_solr_json
	echo '      "worksetid_ss": { "add" : [ "'$wsid'"' '] }' >> $wsid_solr_json
#	echo '     }'       >> $wsid_solr_json

#	echo '  }'                        >> $wsid_solr_json
	echo ' }'                         >> $wsid_solr_json
	needs_comma=","
    done

    echo ']' >> $wsid_solr_json
done



#echo ""
#echo "Launching nohup YARN ingest to collection: $solrcol"
#echo ""


#nohup ./SCRIPTS-CWD/FULL-RUN-YARN-SPARK.sh $solrcol &

# ./JSONLIST-YARN-INGEST.sh $solrcol $solrconfig $solrShardCount /user/dbbridge/fict-full-pairtree-ids.txt
