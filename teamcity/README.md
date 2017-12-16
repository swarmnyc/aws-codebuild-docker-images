
![teamcity_status][tc_status_logo]

[tc_status_logo]: http://34.224.141.66/app/rest/builds/buildType:BuildAgentDockerImages_Build/statusIcon "Powered by TeamCity"

# How to Build and Push This Image
```
docker build -t swarmnyc/teamcity-agent:latest .
docker push swarmnyc/teamcity-agent:latest

# Tag a specified version for the image.
IMAGE_VERSION=1.0.0
docker tag swarmnyc/teamcity-agent:latest swarmnyc/teamcity-agent:${IMAGE_VERSION}
docker push swarmnyc/teamcity-agent:${IMAGE_VERSION}
```

# How to Use This Image
## Run in command line.
```
# COREOS_PRIVATE_IPV4=10.0.0.14
sudo /usr/bin/docker run -d -v /mnt/data/temp/teamcity:/opt/teamcity/temp -e SERVER_URL=$COREOS_PRIVATE_IPV4 \
    -e AGENT_NAME=DockerCompose --privileged -e DOCKER_IN_DOCKER=start --name teamcity-agent-dc \
    swarmnyc/teamcity-agent:latest
```

## Update the default service in AWS
```
# Change service script:
sudo vi /etc/systemd/system/teamcity-agent.service
# Reload the service:
sudo systemctl daemon-reload
# Restart service:
sudo systemctl restart teamcity-agent
```
The update will be gone if the ec2 instance reboot.
If you want to permenantly make the change, change the service content in 
* CloudFormation ==> TeamCity-BuildMachine
    * Other Actions ==> View/Edit teamplate in Designer
        * Template ==> Resouces ==> EC2Instance ==> Properties ==> UserData ==> coreos ==> units ==> name: "teamcity-agent.service"


## Create a new service: 
cat /etc/systemd/system/teamcity-agent-swarmnyc.service
```
[Unit]
Description=TeamCity Agent
After=teamcity-server.service coreos-metadata.service
Requires=teamcity-server.service coreos-metadata.service

[Service]
EnvironmentFile=/etc/teamcity-version
TimeoutStartSec=1200s
EnvironmentFile=/run/metadata/coreos
ExecStartPre=/bin/sh -c "docker images --filter 'before=swarmnyc/teamcity-agent:${TEAMCITY_VERSION}' --format '{{.ID}} {{.Repository}}' | grep 'swarmnyc/teamcity-agent' | grep -Eo '^[^ ]+' | xargs -r docker rmi"
ExecStart=/usr/bin/docker run \
  -v /mnt/data/temp/teamcity:/opt/teamcity/temp \
  -e SERVER_URL=${COREOS_EC2_IPV4_LOCAL} \
  -e AGENT_NAME=DockerCompose \
  --name teamcity-agent-dc \
  --privileged -e DOCKER_IN_DOCKER=start \
  swarmnyc/teamcity-agent:${TEAMCITY_VERSION}
ExecStop=-/usr/bin/docker stop teamcity-agent-dc
ExecStopPost=-/usr/bin/docker rm teamcity-agent-dc
Restart=always

[Install]
WantedBy=multi-user.target
```
Enable and start it
```
sudo systemctl enable teamcity-agent-swarmnyc.service
sudo systemctl start teamcity-agent-swarmnyc.service
```
