import boto3
import sys

AWS_REGION = ["us-east-1","us-east-2"]

aws_access_key_id=sys.argv[1]
aws_secret_access_key=sys.argv[2]

for region in AWS_REGION:
    client = boto3.client("ec2", aws_access_key_id=aws_access_key_id,
                       aws_secret_access_key=aws_secret_access_key, 
                       region_name=region)
    instance_ids=[]
    

    def get_ec2_details():
        reservations = client.describe_instances()

        for reservation in reservations['Reservations']:
            for instance in reservation['Instances']:
                if instance['State']['Name'] == 'running':
                    instance_ids.append(instance['InstanceId'])
        
        print(instance_ids)
        return instance_ids

    def stop_ec2_instances(instance_ids):
        for ec2_id in instance_ids:
            response = client.stop_instances(InstanceIds=[ec2_id])
            print(response)

    instance_ids = get_ec2_details()
    stop_ec2_instances(instance_ids)
