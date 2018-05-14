
export MONGODB_HOME="$HTRC_EF_PACKAGE_HOME/mongodb"
export PATH="$MONGODB_HOME/bin:$PATH"
if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* Added in MongoDB into PATH"
fi

export MONGODB_DBDIR="/hdfsd05/dbbridge/mongodb-databases"
