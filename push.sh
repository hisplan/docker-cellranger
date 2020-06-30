#!/bin/bash

docker login
docker tag cellranger:3.1.0 hisplan/cellranger:3.1.0
docker push hisplan/cellranger:3.1.0
