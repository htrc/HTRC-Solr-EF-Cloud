#!/usr/bin/python

import sys
import json


if len(sys.argv)>1 and sys.argv[1]:
    inf = open(sys.argv[1])
else:
    inf = sys.stdin

data_str = inf.read().replace('\n','')
    
json_data = json.loads(data_str)

if inf is not sys.stdin:
    inf.close()
    
gathers = json_data.get("gathers")
if isinstance(gathers, list):    
    for item in json_data.get("gathers"):    
        print item.get("id");
else:
    print gathers.get("id")
    
