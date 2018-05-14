#!/bin/bash

htrc-ef-mongodb-stop-routerservers.sh \
&& htrc-ef-mongodb-stop-shardservers.sh \
&& htrc-ef-mongodb-stop-configservers.sh
