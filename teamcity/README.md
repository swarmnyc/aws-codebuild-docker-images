# How to Use This Image
## Run in command line.
```
/usr/bin/docker run -v /mnt/data/temp/teamcity:/opt/teamcity/temp -e SERVER_URL=10.0.0.14 \
    -e AGENT_NAME=DockerComposite --privileged -e DOCKER_IN_DOCKER=start --name teamcity-agent \
    swarmnyc/teamcity-agent:1.0.0
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