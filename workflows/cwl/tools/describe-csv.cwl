#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      pandas:

requirements:
  - class: InlineJavascriptRequirement
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