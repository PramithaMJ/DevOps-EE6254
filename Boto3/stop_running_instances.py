import boto3
import os

def stop_running_instances():
    # Set the AWS region
    os.environ['AWS_DEFAULT_REGION'] = 'us-east-1'

    # Create an EC2 client
    ec2_client = boto3.client('ec2')

    # Describe instances
    response = ec2_client.describe_instances()

    # Iterate through reservations and instances
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            instance_state = instance['State']['Name']

            # Print instance details
            print("Instance ID:", instance_id)
            print("Instance State:", instance_state)

            # Stop running instances
            if instance_state == 'running':
                print("Stopping instance:", instance_id)
                ec2_client.stop_instances(InstanceIds=[instance_id])
                print("Instance stopped.")
            else:
                print("Instance is not running.")

            print("\n")

if __name__ == "__main__":
    stop_running_instances()