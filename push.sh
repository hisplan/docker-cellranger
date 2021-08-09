#!/bin/bash -e

source config.sh

echo "${registry}/${image_name}:${version}"

scing push --image=${registry}/${image_name}:${version}
scing push --image=${registry}/cromwell-${image_name}:${version}
