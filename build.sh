#!/bin/bash

source version.sh

docker build -t cellranger:${version} .
