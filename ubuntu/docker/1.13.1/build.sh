#!/bin/sh

IMAGE_VERSION=1.13.1
docker build -t swarmnyc/aws-docker:${IMAGE_VERSION} .
docker push swarmnyc/aws-docker:${IMAGE_VERSION}
# docker tag swarmnyc/aws-docker:${IMAGE_VERSION} 195193742544.dkr.ecr.us-east-1.amazonaws.com/aws-docker:${IMAGE_VERSION}
# eval $( aws ecr get-login --no-include-email --region us-east-1 --profile eleven )
# docker push 195193742544.dkr.ecr.us-east-1.amazonaws.com/aws-docker:${IMAGE_VERSION}
