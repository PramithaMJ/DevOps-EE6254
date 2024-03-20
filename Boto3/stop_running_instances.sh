#!/bin/bash

# Specify the AWS region
AWS_REGION="us-east-1"

# Install jq if not already installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y jq
fi

# List EC2 instances and extract instance IDs and states
instance_info=$(aws ec2 describe-instances --region $AWS_REGION --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' --output json)

# Loop through instance info
for instance in $(echo "${instance_info}" | jq -c '.[][]'); do
    instance_id=$(echo "${instance}" | jq -r '.[0]')
    state=$(echo "${instance}" | jq -r '.[1]')

    echo "Instance ID: ${instance_id}"
    echo "State: ${state}"

    # If instance is running, stop it
    if [ "${state}" == "running" ]; then
        echo "Stopping instance ${instance_id}"
        aws ec2 stop-instances --region $AWS_REGION --instance-ids "${instance_id}"
    fi
done
