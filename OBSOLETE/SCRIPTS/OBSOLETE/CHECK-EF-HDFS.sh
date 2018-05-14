#!/bin/bash

for f in gc0 gc1 gc2 gc3 ; do 
  echo "*** $f"; 
  ssh $f jps; 
  echo ; 
done
