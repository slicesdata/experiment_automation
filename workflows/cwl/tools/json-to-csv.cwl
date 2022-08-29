#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      jq:
requirements:
  - class: InlineJavascriptRequirement

baseCommand: "jq"
arguments:
  - "-r"
  - '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'

inputs:
  json_file:
    type: File
    inputBinding:
      position: 1
      
stdout: $(inputs.json_file.nameroot).csv
outputs:
  csv_file:
    type: stdout