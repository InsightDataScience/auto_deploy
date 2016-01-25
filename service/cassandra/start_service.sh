#!/bin/bash

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

# import AWS public DNS's
NODE_DNS=()
while read line; do
    NODE_DNS+=($line)
done < tmp/$INSTANCE_NAME/public_dns

# Start each cassandra node
for dns in "${NODE_DNS[@]}";
do
    ssh -i $PEMLOC ubuntu@$dns '/usr/local/cassandra/bin/cassandra'
done

echo "Cassandra started!"
