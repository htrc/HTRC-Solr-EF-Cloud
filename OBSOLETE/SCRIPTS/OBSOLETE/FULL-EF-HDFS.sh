#!/bin/bash

ssh gc0 "nohup PAIRTREE-FOREACH-HDFS-PUT.sh mdp > nohup-gc0-mdp.out 2>&1 &"
ssh gc1 "nohup PAIRTREE-FOREACH-HDFS-PUT.sh uc1 > nohup-gc1-uc1.out 2>&1 &"
ssh gc2 "nohup PAIRTREE-FOREACH-HDFS-PUT.sh hvd > nohup-gc2-hvd.out 2>&1 &"
#ssh gc3 "nohup PAIRTREE-FOREACH-HDFS-PUT.sh wu  > nohup-gc3-wu.out  2>&1 &"
ssh gc3 "nohup PAIRTREE-FOREACH-HDFS-PUT.sh inu  > nohup-gc3-inu.out  2>&1 &"


#ssh gc0 "nohup hdfs dfs -put /data/features/ef-full/mdp full-ef-json-files/. > nohup-mdp.out 2>&1 &"
#ssh gc1 "nohup hdfs dfs -put /data/features/ef-full/uc1 full-ef-json-files/. > nohup-uc1.out 2>&1 &"
#ssh gc2 "nohup hdfs dfs -put /data/features/ef-full/hvd full-ef-json-files/. > nohup-hvd.out 2>&1 &"
##ssh gc3 "nohup hdfs dfs -put /data/features/ef-full/wu  full-ef-json-files/. > nohup-wu.out  2>&1 &"

#ssh gc3 "nohup hdfs dfs -put /data/features/ef-full/inu full-ef-json-files/. > nohup-inu.out 2>&1 &"
##ssh gc1 "nohup hdfs dfs -put /data/features/ef-full/coo full-ef-json-files/. > nohup-coo.out 2>&1 &"
