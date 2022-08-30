#!/usr/bin/env cwl-runner

#
# This tool retrieves data from a AWS DynamoDB table using the boto3 python
# module and dumps it into a JSON file. It takes the AWS credentials and
# the table name as input.
#

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      boto3:

requirements:
  - class: InlineJavascriptRequirement
  # set the enviroment variables to the AWS credentials provided as input
  - class: EnvVarRequirement
    envDef:
      - envName: AWS_ACCESS_KEY_ID
        envValue: $(inputs.AWS_ACCESS_KEY_ID)
      - envName: AWS_SECRET_ACCESS_KEY
        envValue: $(inputs.AWS_SECRET_ACCESS_KEY)
  # create a temporary python script to be executed
  - class: InitialWorkDirRequirement
    listing:
      - entryname: script.py
        entry: |
          import boto3, os, json

          # connect to the DynamoDB table
          table = boto3.resource(
              "dynamodb",
              region_name="us-east-1"
          ).Table("$(inputs.table_name)")
          
          # get all data from paginated responses
          res = table.scan()
          data = res["Items"]
          while 'LastEvaluatedKey' in res:
              res = table.scan(ExclusiveStartKey=res['LastEvaluatedKey'])
              data += response["Items"]
          
          # convert Decimal datatype to str representation for compatibility
          data_no_decimal = [{x: str(item[x]) for x in item} for item in data]

          # save results
          with open("$(inputs.table_name)_dynamodb_data.json", "w") as f:
            f.write(json.dumps(data_no_decimal, indent=2))

baseCommand: ["python3", "script.py"]

inputs:
  AWS_ACCESS_KEY_ID:
    type: string
  AWS_SECRET_ACCESS_KEY:
    type: string
  table_name:
    type: string

outputs:
  dynamodb_data:
    type: File
    outputBinding:
      glob: "*.json"