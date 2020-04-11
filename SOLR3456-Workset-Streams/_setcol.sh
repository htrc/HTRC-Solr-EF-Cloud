solrconfig=htrc-configs-docvals
solrcol=solr3456-worksets-htrc-full-ef16

solrShardCount=16
solrReplCount=2

# Better if this could be done as 'solr3-s' through dedicated switch
solrhead=solr3.ischool.illinois.edu:8983

solradminurl="http://solr1/robust-solr/admin"

export SOLR_NODES=$solrhead
echo "Set Environment Variable SOLR_NODES to: $SOLR_NODES"
