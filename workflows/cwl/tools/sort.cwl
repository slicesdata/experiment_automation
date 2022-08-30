#!/usr/bin/env cwl-runner

#
# This tool sorts data using the sort tool. The sort_field determines which
# field the data should be sorted by.
#

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