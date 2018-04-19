#/bin/bash

htrc-ef-mongodb-start-configservers.sh \
&& htrc-ef-mongodb-start-shardservers.sh \
&& htrc-ef-mongodb-start-routerservers.sh
