

export ZOOKEEPER_HOME="$HTRC_EF_PACKAGE_HOME/zookeeper"
export PATH="$ZOOKEEPER_HOME/bin:$PATH"
if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* Added in Zookeeper into PATH"
fi


