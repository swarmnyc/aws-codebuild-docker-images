# AWS CodeBuild curated Docker images

This repository holds Dockerfiles of official AWS CodeBuild curated Docker images. Please refer to [the AWS CodeBuild User Guide](http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html) for list of environments supported by AWS CodeBuild.

### How to build Docker images

Steps to build aws-docker-1.13.1 image

* Run `git clone https://github.com/swarmnyc/aws-codebuild-docker-images.git` to download this repository to your local machine
* Run `cd ubuntu/docker/1.13.1` to change the directory in your local workspace. This is the location of aws-docker-1.13.1 Dockerfile with Ubuntu base.
* Run `./build.sh` to build Docker image locally and push to Docker Hub.
* Once succeeded, your can run `docker run --privileged -it swarmnyc/aws-docker:1.13.1 /bin/bash` to start container running `bash` shell with the aws-docker-1.13.1 image.
* In bash shell, run `nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=overlay&` to start the docker server. See [Sample buildspec.yml]


```
$ git clone https://github.com/swarmnyc/aws-codebuild-docker-images.git
$ cd aws-codebuild-docker-images
$ cd ubuntu/docker/1.13.1
$ docker build -t swarmnyc/aws-docker:1.13.1 .
$ docker run --privileged -it swarmnyc/aws-docker:1.13.1 /bin/bash
(in bash run below to start docker server)
# nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=overlay&
```

# Some documnets about Docker-in-Docker
* [dind](https://github.com/jpetazzo/dind)
* [Using Docker-in-Docker for your CI or testing environment?](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
* [Docker in Custom Image Sample](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html#sample-docker-custom-image-running)


[Sample buildspec.yml]: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html#sample-docker-custom-image-files