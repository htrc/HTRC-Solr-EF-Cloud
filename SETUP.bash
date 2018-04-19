
short_hostname=`hostname -s`

#export SPARK_MASTER_HOST=gchead
export SPARK_MASTER_HOST=192.168.64.1

export SPARK_MASTER_URL=spark://$SPARK_MASTER_HOST:7077
export SPARK_SLAVE_HOSTS="gc0 gc1 gc2 gc3 gc4 gc5 gc6 gc7 gc8 gc9"

if [ "$short_hostname" = "nema" ] ; then
  export ZOOKEEPER_SERVER=localhost:8181
  export SOLR_NODES="localhost:8983 localhost:8984 localhost:8985 localhost:8986 localhost:8987 localhost:8988 localhost:8989 localhost:8990 localhost:8991 localhost:8992"
  
elif [ "${short_hostname%[1-2]}" = "solr" ] ; then
  export ZOOKEEPER_SERVER=solr1:8181

  export SOLR_NODES="solr1:8983 solr1:8984 solr1:8985 solr1:8986 solr1:8987"
  export SOLR_NODES="$SOLR_NODES solr1:8988 solr1:8989 solr1:8990 solr1:8991 solr1:8992"
  export SOLR_NODES="$SOLR_NODES solr2:8983 solr2:8984 solr2:8985 solr2:8986 solr2:8987"
  export SOLR_NODES="$SOLR_NODES solr2:8988 solr2:8989 solr2:8990 solr2:8991 solr2:8992"

  export SOLR_SHARDS="/disk0/solr-full-ef /disk1/solr-full-ef /disk2/solr-full-ef /disk3/solr-full-ef /disk4/solr-full-ef"
  export SOLR_SHARDS="$SOLR_SHARDS /disk5/solr-full-ef /disk6/solr-full-ef /disk7/solr-full-ef /disk8/solr-full-ef /disk9/solr-full-ef"
  export SOLR_SHARDS="$SOLR_SHARDS /disk0/solr-full-ef /disk1/solr-full-ef /disk2/solr-full-ef /disk3/solr-full-ef /disk4/solr-full-ef"
  export SOLR_SHARDS="$SOLR_SHARDS /disk5/solr-full-ef /disk6/solr-full-ef /disk7/solr-full-ef /disk8/solr-full-ef /disk9/solr-full-ef"

  #export SOLR_JAVA_MEM="-Xms10g -Xmx15g"
  # export SOLR_JAVA_MEM="-Xms5g -Xmx7g"
  export SOLR_JAVA_MEM="-Xmx14g"  

#  export SOLR7_NODES="solr1:9983 solr1:9984 solr1:9985 solr1:9986 solr1:9987"
#  export SOLR7_NODES="$SOLR_NODES solr1:9988 solr1:9989 solr1:9990 solr1:9991 solr1:9992"
#  export SOLR7_NODES="$SOLR_NODES solr2:9983 solr2:9984 solr2:9985 solr2:9986 solr2:9987"
#  export SOLR7_NODES="$SOLR_NODES solr2:9988 solr2:9989 solr2:9990 solr2:9991 solr2:9992"

#  export SOLR7_SHARDS="/disk0/solr-full-ef /disk1/solr-full-ef /disk2/solr-full-ef /disk3/solr-full-ef /disk4/solr-full-ef"
#  export SOLR7_SHARDS="$SOLR_SHARDS /disk5/solr-full-ef /disk6/solr-full-ef /disk7/solr-full-ef /disk8/solr-full-ef /disk9/solr-full-ef"
#  export SOLR7_SHARDS="$SOLR_SHARDS /disk0/solr-full-ef /disk1/solr-full-ef /disk2/solr-full-ef /disk3/solr-full-ef /disk4/solr-full-ef"
#  export SOLR7_SHARDS="$SOLR_SHARDS /disk5/solr-full-ef /disk6/solr-full-ef /disk7/solr-full-ef /disk8/solr-full-ef /disk9/solr-full-ef"

  
else
  export ZOOKEEPER_SERVER=gchead:8181
#  export SOLR_NODES="gc0:8983 gc1:8983 gc2:8983 gc3:8983 gc4:8983 gc5:8983 gc6:8983 gc7:8983 gc8:8983 gc9:8983"
#  #export SOLR_NODES="$SOLR_NODES gc0:8984 gc1:8984 gc2:8984 gc3:8984 gc4:8984 gc5:8984 gc6:8984 gc7:8984 gc8:8984 gc9:8984"

  export ZOOKEEPER_SERVER=solr1-s:8181
  export SOLR_NODES="solr1-s:8983 solr1-s:8984 solr1-s:8985 solr1-s:8986 solr1-s:8987"
  export SOLR_NODES="$SOLR_NODES solr2-s:8983 solr2-s:8984 solr2-s:8985 solr2-s:8986 solr2-s:8987"

fi

if [ "$short_hostname" != "nema" ] && [ "${short_hostname%[1-2]}" != "solr" ] ; then
  HDFS_HEAD=hdfs://gchead:9000
fi

if [ "${short_hostname%[0-9]}" = "gc" ] ; then
  export HTRC_EF_PACKAGE_HOME="/hdfsd05/dbbridge/gslis-cluster"
else
  export HTRC_EF_PACKAGE_HOME=`pwd`
fi

HTRC_EF_NETWORK_HOME=`pwd`

if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo ""
  echo "****"
fi

if [ "${short_hostname%[1-2]}" = "solr" ] ; then
  export JAVA_HOME="/usr/lib/jvm/j2sdk1.8-oracle"
else
  export JAVA_HOME="$HTRC_EF_NETWORK_HOME/jdk1.8.0"
fi

export PATH="$JAVA_HOME/bin:$PATH"
#export _JAVA_OPTIONS="-Xmx512m"
#export _JAVA_OPTIONS="-Xmx1024m"
#export _JAVA_OPTIONS="-Xmx2048m"
export _JAVA_OPTIONS=
#export _JAVA_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError"

if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* Added in JDK 1.8 into PATH"
fi

if [ "$short_hostname" != "nema" ] && [ "${short_hostname%[1-2]}" != "solr" ] ; then
  source SETUP/setup-spark.bash
fi

source SETUP/setup-zookeeper.bash 
#source SETUP/setup-solr.bash
source SETUP/setup-solr7.bash

if [ "$short_hostname" = "gsliscluster1" ] ; then
  export MONGODB_CONFIG_HOSTS="gc0 gc1 gc2"
  export MONGODB_CONFIG_PORT="27019"

  export MONGODB_ROUTER_HOSTS="gc3 gc4 gc5"
  export MONGODB_ROUTER_PORT="27017"

  export MONGODB_REPLSET1_HOSTS="gc6 gc7"
  export MONGODB_REPLSET2_HOSTS="gc8 gc9"
  export MONGODB_REPLSET_PORT="27017"
  ##export MONGODB_REPLSET_ARRAY=("$MONGODB_REPLSET1_HOSTS" "$MONGODB_REPLSET2_HOSTS")
  export MONGODB_REPLSET_METALIST="MONGODB_REPLSET1_HOSTS MONGODB_REPLSET2_HOSTS"
  export MONGODB_SHARD_HOSTS="$MONGODB_REPLSET1_HOSTS $MONGODB_REPLSET2_HOSTS"

  source SETUP/setup-mongodb.bash
fi

export PATH="$HTRC_EF_NETWORK_HOME/SCRIPTS:$PATH"
if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "* Added in HTRC EF PACKAGE remote scripting into PATH"
fi

if [ "$short_hostname" != "nema" ] && [ "${short_hostname%[1-2]}" != "solr" ] ; then    
  spark_conf_slaves="$SPARK_HOME/conf/slaves" 
  if [ ! -f "$spark_conf_slaves" ] ; then
    echo "****"
    echo "* Populatig $spark_conf_slaves" 
    echo "* With: $SPARK_SLAVE_HOSTS"
    echo "****"
    for s in $SPARK_SLAVE_HOSTS ; do
      echo $s >> "$spark_conf_slaves"
    done
  else
    slaves=`cat "$spark_conf_slaves" | tr '\n' ' '`
    if [ "$short_hostname" = "gsliscluster1" ] ; then
      echo "****"
      echo "* Spark slaves: $slaves"
      echo "****"
    fi
  fi
fi


zookeeper_config_file="$ZOOKEEPER_HOME/conf/zoo.cfg"
zookeeper_data_dir="$ZOOKEEPER_HOME/data"

if [ ! -f "$zookeeper_config_file" ] ; then
  echo "****"
  echo "* Generating $zookeeper_config_file" 
  cat CONF/zoo.cfg.in | sed "s%@zookeeper-data-dir@%$zookeeper_data_dir%g" > "$zookeeper_config_file"

  if [ ! -d "$zookeeper_data_dir" ] ; then
    echo "* Creating Zookeeper dataDir:"
    echo "*   $zookeeper_data_dir"
    mkdir "$zookeeper_data_dir"
  fi
  echo "****"
fi

if [ "$short_hostname" = "gsliscluster1" ] ; then
  echo "****"
  echo "* Solr nodes: $SOLR_NODES"
  echo "****"
else
  
  solr_configsets="$SOLR_TOP_LEVEL_HOME/server/solr/configsets"
  if [ ! -d "$solr_configsets/htrc_configs" ] ; then
    echo "Untarring htrc_configs.tar.gz in Solr configtests directory"
    tar xvzf CONF/htrc_configs.tar.gz -C "$solr_configsets"
  fi
fi
