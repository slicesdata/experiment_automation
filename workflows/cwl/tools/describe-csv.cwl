#!/usr/bin/env cwl-runner

#
# This tool uses the pandas python module to create a description of CSV data.
# The description lists the number of data points, the mean, the standard
# deviation, the minimum/maximum value and the 25%/50%/75% quantiles.
#

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      pandas:

requirements:
  - class: InlineJavascriptRequirement
  # temporarily create python script which processes the input file.
  - class: InitialWorkDirRequirement
    listing:
      - entryname: script.py
        entry: |
          import pandas as pd
    
          with open("describe_$(inputs.csv_file.nameroot).txt", "w") as f:
            f.write(str(pd.read_csv("$(inputs.csv_file.path)").describe()))

baseCommand: ["python3", "script.py"]

inputs:
  csv_file:
    type: File
outputs:
  data_description:
    type: File
    outputBinding:
      glob: "*.txt"