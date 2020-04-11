#!/usr/bin/python

import sys
import json
import re


if len(sys.argv)>1 and sys.argv[1]:
    inf = open(sys.argv[1])
else:
    inf = sys.stdin

data_str = inf.read().replace('\n','')
#print data
    
json_data = json.loads(data_str)

#data=myfile.read().replace('\n', '')

if inf is not sys.stdin:
    inf.close()
    
        
#print '['
#print '  '+',\n  '.join(json.dumps(i) for i in json_data)
#print ']'

for item in json_data.get("graph"):
    id=item.get("id")
    if re.match("^.*/wsid/.*$", id):
        print id
        
