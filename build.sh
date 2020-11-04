#!/bin/bash

currentDir=$(dirname $0)
currentDir=$(cd ${currentDir} && basename $(pwd))

docker image build \
  --build-arg USER_ID=$(id -u ${USER}) \
  --build-arg GROUP_ID=$(id -g ${USER}) \
  -t ${currentDir}:latest  \
  .
