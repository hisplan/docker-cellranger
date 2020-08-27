#!/bin/bash

docker login
docker tag cellranger:4.0.0 hisplan/cellranger:4.0.0
docker push hisplan/cellranger:4.0.0
