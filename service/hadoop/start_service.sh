#!/bin/bash

# must be called from the top level

# check input arguments
if [ "$#" -ne 2 ]; then
    echo "Please specify pem-key location and cluster name!" && exit 1
fi

# get input arguments [aws region, pem-key location]
PEMLOC=$1
INSTANCE_NAME=$2

# check if pem-key location is valid
if [ ! -f $PEMLOC ]; then
    echo "pem-key does not exist!" && exit 1
fi

MASTER_DNS=$(head -n 1 tmp/$INSTANCE_NAME/public_dns)

ssh -i $PEMLOC ubuntu@$MASTER_DNS '. ~/.profile; $HADOOP_HOME/sbin/start-dfs.sh'
ssh -i $PEMLOC ubuntu@$MASTER_DNS '. ~/.profile; $HADOOP_HOME/sbin/start-yarn.sh'
ssh -i $PEMLOC ubuntu@$MASTER_DNS '. ~/.profile; $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver'

echo "Hadoop started!"
