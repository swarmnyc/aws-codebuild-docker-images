# How to Build and Push This Image
```
docker build -t swarmnyc/teamcity-agent .
docker push swarmnyc/teamcity-agent

# Tag a specified version for the image.
docker tag swarmnyc/teamcity-agent swarmnyc/teamcity-agent:1.0.0
docker push swarmnyc/teamcity-agent:1.0.0
```

# How to Use This Image
## Run in command line.
```
# COREOS_PRIVATE_IPV4=10.0.0.14
sudo /usr/bin/docker run -d -v /mnt/data/temp/teamcity:/opt/teamcity/temp -e SERVER_URL=$COREOS_PRIVATE_IPV4 \
    -e AGENT_NAME=DockerCompose --privileged -e DOCKER_IN_DOCKER=start --name teamcity-agent-dc \
    swarmnyc/teamcity-agent:latest
```

## Setup a service in coreos in AWS
```
# Change service script:
sudo vi /etc/systemd/system/teamcity-agent.service
# Reload the service:
sudo systemctl daemon-reload
# Restart service:
sudo systemctl restart teamcity-agent
```