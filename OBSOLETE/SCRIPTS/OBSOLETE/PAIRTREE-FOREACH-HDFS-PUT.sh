#!/bin/bash

if [ "$#" == "0" ] ; then
  echo "Usage: $0 top-level-dir1 [top-level-dir2 ...]"
  exit
fi


for t in $* ; do
    echo ""
    echo ""
    echo "++++"
    echo "++++"
    echo "Top-level dir: $t"
    echo "++++"
    echo "++++"


  for d in /data/features/ef-full/$t/pairtree_root/*/* ; do
    sub_dir=${d##/data/features/ef-full/}

    echo ""
    echo "****"
    echo "Processing: $sub_dir"
    echo "****"

    hdfs dfs -mkdir -p "full-ef-json-files/$sub_dir"

    into_dir=${sub_dir%/*}
    hdfs dfs -put $d "full-ef-json-files/$into_dir/."
  done
done

echo "===="
echo "===="
echo "===="
echo "Finished: processed top-level(s) $*"
echo "===="
echo "===="
echo "===="
