# Copyright 2017-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use this file except in compliance with the License.
# A copy of the License is located at
#
#    http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file.
# This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied.
# See the License for the specific language governing permissions and limitations under the License.
#
FROM jetbrains/teamcity-agent

ENV DOCKER_COMPOSE_VERSION="1.13.0"

# Install Chrome(HeadlessChrome) for Karma Test
# From: https://gist.github.com/ziadoz/3e8ab7e944d02fe872c3454d17af31a5
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -y update \
    && apt-get -y install google-chrome-stable

# # Install bzip2, used by Node v8.
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends bzip2

# Install node & typescript
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install nodejs -y \
    && npm install typescript -g \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose
