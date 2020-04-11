#!/bin/bash

export SOLR_HOME=
export SOLR_PID_DIR=

if [ "x$short_hostname" = "x" ] ; then
    echo "" 1>&2
    echo "Error: Unclear which Solr cloud is being used (short_hostname not defined)" 1>&2
    echo "Please specify the name of Solr8 collection check healthcheck, for example:" 1>&2
    echo "  htrc-ef-solr8-healthcheck solr3456-faceted-htrc-full-ef16" 1>&2
    echo ""
    exit 1
elif [ "${short_hostname%[1-2]}" = "solr" ] ; then
    col=${1:-faceted-htrc-full-ef20}
else 
    col=${1:-solr3456-faceted-htrc-full-ef16}
fi

"$SOLR8_TOP_LEVEL_HOME/bin/solr" healthcheck -c "$col" -z $ZOOKEEPER8_SERVER -s "$SOLR8_HOME"

