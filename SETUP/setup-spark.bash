
export SPARK_HOME="$HTRC_EF_PACKAGE_HOME/spark"
export PATH="$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH"
if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* Added in Spark's bin and sbin into PATH"
fi


