#!/bin/bash

source version.sh

docker run -it --rm \
    cellranger:${version} --help

docker run -it --rm \
    cellranger:${version} count --help

docker run -it --rm \
    cellranger:${version} vdj --help

docker run -it --rm \
    cellranger:${version} --version