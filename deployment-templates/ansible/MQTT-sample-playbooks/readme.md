## Description
In this example experiment three AWS EC2 instances are created to, simulate IoT devices using the MQTT protocol. One instance acts as the broker and runs [mosquitto](https://mosquitto.org/) while the other two act as subscriber and publisher using the [Paho Python Client](https://www.eclipse.org/paho/clients/python/).

The publisher generates random "sensor data" which is sent to the broker. This broker then sends this data on to the subscriber which saves the measurements in a AWS dynamodb database.

This folder contains three playbooks. One to setup the experiment creating the dynamodb table, the EC2 SSH keypair, the security group as well as launching and installing the three EC2 instances. The execution playbook runs the subscribing and publishing scripts on the respective EC2 instances while the cleanup playbook removes/terminates everything created during the setup.

As inventory the playbooks make use of the "aws_ec2" dynamic inventory plugin so the user does not have to manage the inventory manually.

## Requirements
The following programs/packages are required
- [Python](https://www.python.org/)
- [Ansible](https://www.ansible.com/)
- [Boto3 (AWS python SDK)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)

The following enviroment variables need to be set as such:
```
export AWS_ACCESS_KEY_ID=<AWS Access key id>
export AWS_SECRET_ACCESS_KEY=<AWS Secret access key>
export ANSIBLE_HOST_KEY_CHECKING=FALSE
```

The community AWS collection needs to be installed. This can be done with:
```
ansible-galaxy collection install community.aws
```
## How to run
The setup, execution and cleanup phases of the sample experiment can be run their running their respective playbooks as shown below. The `aws_ec2.yml` file needs to be provided as inventory, `ansible_keypair.pem` as SSH key (this file will be created during the setup playbook) and the SSH user should be `ubuntu`.
```
ansible-playbook -i aws_ec2.yml -u ubuntu experiment-setup.yml --private-key ansible_keypair.pem
```
