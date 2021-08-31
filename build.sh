#!/bin/bash

source config.sh

# get download url for Cell Ranger
if [ ! -n "$download_url" ]
then
    if [ ! -x "$(command -v scing)" ]
    then
        echo "Please install SCING CLI (https://github.com/hisplan/scing)."
        exit 1
    fi

    out=`scing --no-logo download --site-url ${site_url}`
    if [ $? != 0 ]
    then
        echo "$out"
        exit 1
    fi
    download_url=$out
fi

# build ${image_name}:${version}
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

# build cromwell-${image_name}:${version}
docker build \
    --tag cromwell-${image_name}:${version} \
    --build-arg DOWNLOAD_URL=${download_url} \
    --build-arg VDJ_REFERENCE_VERSION=${vdj_ref_version} \
    --build-arg CELLRANGER_VERSION=${version} \
    -f Dockerfile.cromwell .
