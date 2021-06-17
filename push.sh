#!/bin/bash

source version.sh

docker login
docker tag cellranger:${version} hisplan/cellranger:${version}
docker push hisplan/cellranger:${version}
