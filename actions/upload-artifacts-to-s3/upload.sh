#!/bin/bash

set -e

for artifacts in "${ARTIFACTS[@]}"; do
  for artifact_path in `ls ${artifacts}`; do
    filename=`basename ${artifact_path}`
    if [[ -z "${S3_DESTINATION}" ]]; then
      aws s3 cp ${artifact_path} "s3://${S3_BUCKET}/${filename}" --no-progress
    else
      aws s3 cp ${artifact_path} "s3://${S3_BUCKET}/${S3_DESTINATION}/${filename}" --no-progress
    fi
  done
done
