#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      gnuplot:
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: plot_csv.gnuplot
        entry: |
          set datafile separator ','
          set xdata time
          set timefmt "%Y-%m-%d %H:%M:%S"
          set format x "%H:%M:%S"
          set key autotitle columnhead noenhance bottom left

          set term png
          set output 'gnuplot.png'
          plot '$(inputs.csv_to_plot.path)' using 1:3 with linespoints

baseCommand: ["gnuplot", plot_csv.gnuplot]

inputs:
  csv_to_plot:
    type: File
outputs:
  plot:
    type: File
    outputBinding:
      glob: "*.png"