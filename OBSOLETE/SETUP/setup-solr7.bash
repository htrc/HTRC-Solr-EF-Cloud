

_SOLR_TOP_LEVEL_HOME="$HTRC_EF_PACKAGE_HOME/solr7"

if [ "$short_hostname" = "nema" ] || [ "${short_hostname%[1-2]}" = "solr" ] ; then
  _SOLR_HOME="$_SOLR_TOP_LEVEL_HOME/server/solr"
else 
  _SOLR_HOME="/hdfsd05/dbbridge/solr-ef"
fi

if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* For-each Solr Node"
  echo "*   Added Solr bin into PATH"
  echo "*     $_SOLR_TOP_LEVEL_HOME/bin"
  echo "*   Set Solr node (home) conf dir to:"
  echo "*     $_SOLR_HOME"
  # The following is needed on gsliscluster1 for something like 
  #   htrc-ef-solr-setup-local-disk-all.sh to work
  export SOLR_HOME="$HTRC_EF_PACKAGE_HOME/solr/server/solr"
else
  # on one of the gc nodes (or nema)
  export SOLR_TOP_LEVEL_HOME="$_SOLR_TOP_LEVEL_HOME"
  export PATH="$SOLR_TOP_LEVEL_HOME/bin:$PATH"

  # on solr1 and solr2 these will be locally overriden when solr-server started/stopped
  export SOLR_HOME="$_SOLR_HOME"
  export SOLR_PID_DIR="$SOLR_HOME"

fi

#export PATH="$HTRC_EF_PACKAGE_HOME/solr/bin:$PATH"
#if [ "$short_hostname" = "gsliscluster1" ] ; then
#  echo "* Added in Solr into PATH"
#fi
#
#export SOLR_TOP_LEVEL_HOME="$HTRC_EF_PACKAGE_HOME/solr"
#export SOLR_HOME="$SOLR_TOP_LEVEL_HOME/server/solr"
#if [ "$short_hostname" = "gsliscluster1" ] ; then
#  echo "* Set Solr node (home) conf dir to:"
#  echo "*   $SOLR_HOME"
#fi

