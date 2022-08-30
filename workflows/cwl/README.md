## Description
This CWL code provides a workflow for the data processing step of the sample experiment referred to in SLICES-DS D4.5. It takes the AWS credentials and DynamoDB table name as input, retrieves the data generated in the MQTT experiment, converts it to CSV, sorts it, generates a data description and a line plot of the data.

The workflow file is `workflows/MQTT_data_processing.cwl`. An inputs file is provided in `inputs/MQTT_data_processing_input.yml`. The tools executed during the workflow steps are defined in `tools/`.

## Requirements
The following programs/packages are required
- [The CWL tool reference CWL-runner](https://github.com/common-workflow-language/cwltool)
- [Python](https://www.python.org/)
- [Boto3 (AWS python SDK)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [Pandas python module](https://pandas.pydata.org/)
- [jq](https://stedolan.github.io/jq/)
- [gnuplot](http://www.gnuplot.info/)

## How to run
Set the AWS credentials in `inputs/MQTT_data_processing_input.yml`. Then run the following command to run the workflow with the right inputs:

```
cwl-runner workflows/MQTT_data_processing.cwl inputs/MQTT_data_processing_input.yml
```
