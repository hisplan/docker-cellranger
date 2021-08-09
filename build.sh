#!/bin/bash -e

source config.sh

docker build \
    --tag ${image_name}:${version} \
    --build-arg DOWNLOAD_URL=${download_url} \
    --build-arg VDJ_REFERENCE_VERSION=${vdj_ref_version} \
    --build-arg CELLRANGER_VERSION=${version} .

# hack: comment the ENTRYPOINT and CMD lines to make it work for cromwell
# this will generate `Dockerfile.cromwell` and build it under the name `cromwell-${image_name}:${version}`
# https://github.com/broadinstitute/cromwell/issues/2461
cat Dockerfile \
    | sed 's/^ENTRYPOINT \[/# ENTRYPOINT \[/g' \
    | sed 's/^CMD \[/# CMD \[/g' > Dockerfile.cromwell

# build it
docker build \
    --tag cromwell-${image_name}:${version} \
    --build-arg DOWNLOAD_URL=${download_url} \
    --build-arg VDJ_REFERENCE_VERSION=${vdj_ref_version} \
    --build-arg CELLRANGER_VERSION=${version} \
    -f Dockerfile.cromwell .
