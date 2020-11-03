#!/bin/bash

set -e

SPARK_VERSION="3.0.1"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd "$DIR/.."
# build for k8s and hadoop
dev/make-distribution.sh -Pkubernetes -Dhadoop.version=3.2.0

pushd dist
# java
docker build -t rcpai/spark:${SPARK_VERSION} \
  -f kubernetes/dockerfiles/spark/Dockerfile .

# python
docker build --build-arg base_img=rcpai/spark:${SPARK_VERSION} \
  -t rcpai/spark-python:${SPARK_VERSION} \
  -f kubernetes/dockerfiles/spark/bindings/python/Dockerfile .

popd
popd
