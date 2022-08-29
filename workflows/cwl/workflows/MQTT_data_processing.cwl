#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: StepInputExpressionRequirement
  
steps:
  get_data:
    run: ../tools/get-dynamodb-data.cwl
    in:
      AWS_ACCESS_KEY_ID: AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY: AWS_SECRET_ACCESS_KEY
      table_name: table_name
    out: [dynamodb_data]
  
  convert_to_csv:
    run: ../tools/json-to-csv.cwl
    in:
      json_file: get_data/dynamodb_data
    out: [csv_file]

  sort_csv:
    run: ../tools/sort.cwl
    in:
      file_to_sort: convert_to_csv/csv_file
      sort_field:
        default: 2
    out: [sorted_file]

  describe_data:
    run: ../tools/describe-csv.cwl
    in:
      csv_file: sort_csv/sorted_file
    out: [data_description]

  generate_graph:
    run: ../tools/graph-csv.cwl
    in:
      csv_to_plot: sort_csv/sorted_file
    out: [plot]

inputs:
  AWS_ACCESS_KEY_ID: string
  AWS_SECRET_ACCESS_KEY: string
  table_name: string

outputs:
  data_csv:
    type: File
    outputSource: sort_csv/sorted_file
  description:
    type: File
    outputSource: describe_data/data_description
  plot:
    type: File
    outputSource: generate_graph/plot