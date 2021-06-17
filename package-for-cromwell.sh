#!/bin/bash -e

source version.sh

hub="hisplan"
image_name="cromwell-cellranger"

echo "Building ${image_name}:${version}..."

# hack: comment the ENTRYPOINT and CMD lines
# https://github.com/broadinstitute/cromwell/issues/2461
cat Dockerfile \
    | sed 's/^ENTRYPOINT \[/# ENTRYPOINT \[/g' \
    | sed 's/^CMD \[/# CMD \[/g' > Dockerfile.cromwell

cat Dockerfile.cromwell

# build it
docker build -t ${image_name}:${version} -f Dockerfile.cromwell .

echo "Packaging ${hub}/${image_name}:${version}..."

#
# tag it and push it to docker hub
#

docker login
docker tag ${image_name}:${version} ${hub}/${image_name}:${version}
docker push ${hub}/${image_name}:${version}
