## Description
This AWS CloudFormation creates sets up the sample experiment reffered to in SLICES-DS D4.5. In the experiment three AWS EC2 instances are created to, so simulate IoT devices using the MQTT protocol. One instance acts as the broker and runs [mosquitto](https://mosquitto.org/) while the other two act as subscriber and publisher using the[ Paho Python Client](https://www.eclipse.org/paho/clients/python/).

The publisher generates random "sensor data" which is sent to the broker. This broker then sends this data on to the subscriber which saves the measurements in a AWS DynamoDB database.

## Requirements

None.

## How to run

Create a new CloudFormation stack via the [AWS Management console](https://us-east-1.console.aws.amazon.com/cloudformation/home) (or via another AWS API). Provide the AWS credentials the MQTT subscriber script will use to connect to the DynamoDB table as parameters.