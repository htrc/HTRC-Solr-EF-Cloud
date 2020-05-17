#!/bin/bash

# To make short (local) hostname:
#   i) remove full domain trailing suffix
#   ii) remove 'is-' prefix that turns up on machines like solr3

echo $(uname -n | sed 's/\..*//' | sed 's/^is-//')
