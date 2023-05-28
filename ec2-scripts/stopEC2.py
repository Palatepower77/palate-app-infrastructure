import boto3

AWS_REGION = ["ap-south-1"]

for region in AWS_REGION:
  session = boto3.Session(profile_name='lab')
  client = session.client("ec2",region_name=region)
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
