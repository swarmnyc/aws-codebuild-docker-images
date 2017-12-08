#!/bin/sh

IMAGE_VERSION=1.13.7
docker build -t aws-docker:${IMAGE_VERSION} .
docker tag aws-docker:${IMAGE_VERSION} 195193742544.dkr.ecr.us-east-1.amazonaws.com/aws-docker:${IMAGE_VERSION}
eval $( aws ecr get-login --no-include-email --region us-east-1 --profile eleven )
docker push 195193742544.dkr.ecr.us-east-1.amazonaws.com/aws-docker:${IMAGE_VERSION}
