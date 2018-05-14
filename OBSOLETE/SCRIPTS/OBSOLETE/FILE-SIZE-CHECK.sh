#!/bin/bash

for f in `ls ef-full-*txt | grep -v filename` ; do 
  f_txt=${f#ef-full-}
  d=${f_txt%.*} 
  fs=`cat $f | awk '{ sum += $1 } END { print sum}' `
  echo "$fs $d"
done
