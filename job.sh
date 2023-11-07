#!/usr/bin/env bash

### LOGGING ###
echo "FILENAME: $FILENAME"
echo "AWS_BATCH_CE_NAME: $AWS_BATCH_CE_NAME"
echo "AWS_BATCH_JOB_ARRAY_INDEX: $AWS_BATCH_JOB_ARRAY_INDEX"
echo "AWS_BATCH_JOB_ATTEMPT: $AWS_BATCH_JOB_ATTEMPT"
echo "AWS_BATCH_JOB_ID: $AWS_BATCH_JOB_ID"
echo "AWS_BATCH_JQ_NAME: $AWS_BATCH_JQ_NAME"
echo "INPUT_BUCKET_S3_URL: $INPUT_BUCKET_S3_URL"
echo "OUTPUT_BUCKET: $OUTPUT_BUCKET"
echo "TAG: $TAG"

fn_url=$(pipeline-utils genpath "$INPUT_BUCKET_S3_URL" "$FILENAME")
aws s3 cp "${fn_url}" . 

cctyper \
  --prodigal meta \
  --no_plot \
  -t $CPU \
  $FILENAME \
  output
  
parse_cctyper_out.py

aws s3 cp cctyper_output_${FILENAME}.parquet $OUTPUT_BUCKET

