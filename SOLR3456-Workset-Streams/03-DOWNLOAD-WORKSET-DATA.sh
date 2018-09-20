#!/bin/bash


if [ ! -f all-workset-ids.txt ] ; then
    echo "Download workset ids to: all-workset-ids.txt"

    wget -q https://worksets.hathitrust.org/api/worksets?vis=public -O - \
	| ./extract-workset-ids.py > all-workset-ids.txt
fi

if [ ! -d WORKSETS-PER-ID ] ; then
    echo "Creating WORKSETS-PER_ID"
    mkdir WORKSETS-PER-ID
fi

echo "Processing each workset in all-workset-ids.txt"

for wid_url in `cat all-workset-ids.txt` ; do
    echo "  Processing $wid_url"
    wid=${wid_url##*/}
    download_url="https://worksets.hathitrust.org/api/worksets/$wid_url"

    wget -q $download_url -O - \
	| ./extract-vol-ids-from-workset.py > WORKSETS-PER-ID/$wid.txt
    
done

