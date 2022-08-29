#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      boto3:

requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: AWS_ACCESS_KEY_ID
        envValue: $(inputs.AWS_ACCESS_KEY_ID)
      - envName: AWS_SECRET_ACCESS_KEY
        envValue: $(inputs.AWS_SECRET_ACCESS_KEY)
  - class: InitialWorkDirRequirement
    listing:
      - entryname: script.py
        entry: |
          import boto3, os, json

          table = boto3.resource(
              "dynamodb",
              region_name="us-east-1"
          ).Table("$(inputs.table_name)")
          
          res = table.scan()
          data = res["Items"]
          while 'LastEvaluatedKey' in res:
              res = table.scan(ExclusiveStartKey=res['LastEvaluatedKey'])
              data += response["Items"]
          
          data_no_decimal = [{x: str(item[x]) for x in item} for item in data]
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