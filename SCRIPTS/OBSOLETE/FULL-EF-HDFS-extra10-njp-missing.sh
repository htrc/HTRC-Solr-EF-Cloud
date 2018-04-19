#!/bin/bash




ssh gc0 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/0* > nohup-gc0-njp-32-10-10--00-star.out  2>&1 &"
ssh gc1 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/1* > nohup-gc1-njp-32-10-10--10-star.out  2>&1 &"
ssh gc2 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/2* > nohup-gc2-njp-32-10-10--20-star.out  2>&1 &"
ssh gc3 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/3* > nohup-gc3-njp-32-10-10--30-star.out  2>&1 &"

ssh gc0 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/4* > nohup-gc0-njp-32-10-10--40-star.out  2>&1 &"
ssh gc1 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/5* > nohup-gc1-njp-32-10-10--50-star.out  2>&1 &"
ssh gc2 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/6* > nohup-gc2-njp-32-10-10--60-star.out  2>&1 &"
ssh gc3 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/7* > nohup-gc3-njp-32-10-10--70-star.out  2>&1 &"

ssh gc0 "nohup PAIRTREE-TL-TARGET-DEPTH2-FOREACH-DEPTH3-HDFS-PUT.sh njp 32/10/10/8* > nohup-gc0-njp-32-10-10--80-star.out  2>&1 &"














