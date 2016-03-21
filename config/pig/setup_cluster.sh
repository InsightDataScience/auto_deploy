#!/bin/bash

# check input arguments
if [ "$#" -ne 1 ]; then
    echo "Please specify the cluster name" && exit 1
fi

PEG_ROOT=$(dirname ${BASH_SOURCE})/../..
source ${PEG_ROOT}/util.sh

CLUSTER_NAME=$1

MASTER_DNS=$(get_public_dns_with_name_and_role ${CLUSTER_DNS} master)

single_script="${PEG_ROOT}/config/pig/setup_pig.sh"
run_script_on_node ${MASTER_DNS} ${single_script}

echo "Pig configuration complete!"
