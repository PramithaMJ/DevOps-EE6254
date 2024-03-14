import json
import boto3
from pprint import pprint

def lambda_handler(event, context):
    client = boto3.client("ec2")
    
    # Describe instance status
    status = client.describe_instance_status(IncludeAllInstances=True)
    
    # Extract and print instance statuses
    #instance_statuses = status.get('InstanceStatuses', [])
    #pprint(instance_statuses)
    
    for i in status["InstanceStatuses"]:
        print("Availability Zone: ", i["AvailabilityZone"])
        print("Instance ID: ", i["InstanceId"])
        print("Instance State: ", i["InstanceState"])
        print("Instance Status: ", i["InstanceStatus"])
        print("System Status: ", i["SystemStatus"])
        print("\n")
    
    # TODO: Further processing or actions
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
