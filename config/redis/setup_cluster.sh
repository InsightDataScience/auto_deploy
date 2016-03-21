#!/bin/bash

# check input arguments
if [ "$#" -ne 1 ]; then
    echo "Please specify cluster name!" && exit 1
fi

PEG_ROOT=$(dirname ${BASH_SOURCE})/../..
source ${PEG_ROOT}/util.sh

CLUSTER_NAME=$1

get_cluster_publicdns_arr ${CLUSTER_NAME}

# Install and configure nodes for redis
single_script="${PEG_ROOT}/config/redis/setup_single.sh"
for dns in "${PUBLIC_DNS_ARR[@]}"; do
  run_script_on_node ${dns} ${single_script} &
done

wait

echo "Redis configuration complete!"
