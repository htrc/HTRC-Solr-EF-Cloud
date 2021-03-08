#!/bin/bash

# To make short (local) hostname:
#   i) remove full domain trailing suffix
#   ii) remove 'is-' prefix that turns up on machines like solr3
#   iii) remove 'htrc-' prefix that turns up on machines like solr7

echo $(uname -n | sed 's/\..*//' | sed 's/^is-//' | sed 's/^htrc-//' | sed 's/peachpalm/solr7/' | sed 's/royalpalm/solr8/')
