#!/bin/bash

if [ "$#" == "0" ] ; then
  echo "Usage: $0 top-level-dir1 depth-level1-dir1 [depth-level1-dir2 ...]"
  exit
fi


top_level=$1
shift

echo "++++"
echo "++++"
echo "Top-level dir: $top_level"
echo "++++"
echo "++++"

for d1 in $* ; do


  for d in /data/features/ef-full/${top_level}/pairtree_root/${d1}/* ; do
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
