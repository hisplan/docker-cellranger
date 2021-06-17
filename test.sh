#!/bin/bash

source version.sh

# cellranger
docker run -it --rm \
    cellranger:${version} --help

# cellranger count
docker run -it --rm \
    cellranger:${version} count --help

# cellranger vdj
docker run -it --rm \
    cellranger:${version} vdj --help

# cellranger version
docker run -it --rm \
    cellranger:${version} --version
