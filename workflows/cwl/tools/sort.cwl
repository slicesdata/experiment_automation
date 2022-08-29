#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: sort
arguments:
  - "-o"
  - "$(inputs.file_to_sort.nameroot)_sorted$(inputs.file_to_sort.nameext)"

inputs:
  file_to_sort:
    type: File
    inputBinding:
      position: 1
  sort_field:
    type: int?
    inputBinding:
      prefix: -k
outputs:
  sorted_file:
    type: File
    outputBinding:
      glob: "*"