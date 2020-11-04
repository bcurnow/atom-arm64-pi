#!/bin/bash

currentDir=$(dirname $0)
currentDir=$(cd ${currentDir} && basename $(pwd))

docker run -it --mount src="$(pwd)",target=/workspace,type=bind ${currentDir}:latest /bin/bash
