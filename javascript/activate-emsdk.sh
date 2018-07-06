#!/bin/bash

cd "$(cd "$(dirname "$0")"; pwd)"

source ./emsdk/emsdk_env.sh
emsdk activate latest
# To update paths
source ./emsdk/emsdk_env.sh
