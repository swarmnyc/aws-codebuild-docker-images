#!/bin/sh

IMAGE_VERSION=1.13.1
docker build -t swarmnyc/aws-docker:${IMAGE_VERSION} .
docker push swarmnyc/aws-docker:${IMAGE_VERSION}
