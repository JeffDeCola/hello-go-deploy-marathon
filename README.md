# HELLO GO DEPLOY MARATHON

[![Tag Latest](https://img.shields.io/github/v/tag/jeffdecola/hello-go-deploy-marathon)](https://github.com/JeffDeCola/hello-go-deploy-marathon/tags)
[![Go Reference](https://pkg.go.dev/badge/github.com/JeffDeCola/hello-go-deploy-marathon.svg)](https://pkg.go.dev/github.com/JeffDeCola/hello-go-deploy-marathon)
[![Go Report Card](https://goreportcard.com/badge/github.com/JeffDeCola/hello-go-deploy-marathon)](https://goreportcard.com/report/github.com/JeffDeCola/hello-go-deploy-marathon)
[![codeclimate Maintainability](https://api.codeclimate.com/v1/badges/24c711ac3a1ec5155969/maintainability)](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/maintainability)
[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/issues)
[![Docker Pulls](https://badgen.net/docker/pulls/jeffdecola/hello-go-deploy-marathon?icon=docker&label=pulls)](https://hub.docker.com/r/jeffdecola/hello-go-deploy-marathon/)
[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_Deploy a "hello-world" docker image to
mesos/marathon._

Other Services

* PaaS
  * [hello-go-deploy-aws-elastic-beanstalk](https://github.com/JeffDeCola/hello-go-deploy-aws-elastic-beanstalk)
  * [hello-go-deploy-azure-app-service](https://github.com/JeffDeCola/hello-go-deploy-azure-app-service)
  * [hello-go-deploy-gae](https://github.com/JeffDeCola/hello-go-deploy-gae)
  * [hello-go-deploy-marathon](https://github.com/JeffDeCola/hello-go-deploy-marathon)
    **(You are here)**
* CaaS
  * [hello-go-deploy-amazon-ecs](https://github.com/JeffDeCola/hello-go-deploy-amazon-ecs)
  * [hello-go-deploy-amazon-eks](https://github.com/JeffDeCola/hello-go-deploy-amazon-eks)
  * [hello-go-deploy-aks](https://github.com/JeffDeCola/hello-go-deploy-aks)
  * [hello-go-deploy-gke](https://github.com/JeffDeCola/hello-go-deploy-gke)
* IaaS
  * [hello-go-deploy-amazon-ec2](https://github.com/JeffDeCola/hello-go-deploy-amazon-ec2)
  * [hello-go-deploy-azure-vm](https://github.com/JeffDeCola/hello-go-deploy-azure-vm)
  * [hello-go-deploy-gce](https://github.com/JeffDeCola/hello-go-deploy-gce)

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/hello-go-deploy-marathon#overview)
* [PREREQUISITES](https://github.com/JeffDeCola/hello-go-deploy-marathon#prerequisites)
* [SOFTWARE STACK](https://github.com/JeffDeCola/hello-go-deploy-marathon#software-stack)
* [RUN](https://github.com/JeffDeCola/hello-go-deploy-marathon#run)
* [STEP 1 - TEST](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-1---test)
* [STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-2---build-docker-image-via-dockerfile)
* [STEP 3 - PUSH (TO DOCKERHUB)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-3---push-to-dockerhub)
* [STEP 4 - DEPLOY (TO MARATHON)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-4---deploy-to-marathon)
* [CONTINUOUS INTEGRATION & DEPLOYMENT](https://github.com/JeffDeCola/hello-go-deploy-marathon#continuous-integration--deployment)

Documentation and Reference

* [marathon](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/cluster-managers-resource-management-scheduling/marathon-cheat-sheet),
  [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)
  and
  [docker](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)
  cheat sheets
* The
  [hello-go-deploy-marathon docker image](https://hub.docker.com/r/jeffdecola/hello-go-deploy-marathon)
  on DockerHub
* This repos
  [github webpage](https://jeffdecola.github.io/hello-go-deploy-marathon/)
  _built with
  [concourse](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/ci-README.md)_

## OVERVIEW

Every 2 seconds this App will print,

```txt
    INFO[0000] Let's Start this!
    Hello everyone, count is: 1
    Hello everyone, count is: 2
    Hello everyone, count is: 3
    etc...
```

## PREREQUISITES

You will need the following go packages,

```bash
go get -u -v github.com/sirupsen/logrus
go get -u -v github.com/cweill/gotests/...
```

## SOFTWARE STACK

* DEVELOPMENT
  * [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)
* OPERATIONS
  * [concourse/fly](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/continuous-integration-continuous-deployment/concourse-cheat-sheet)
    (optional)
  * [docker](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)
  * [mesos](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/cluster-managers-resource-management-scheduling/mesos-cheat-sheet)
    /
    [marathon](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/cluster-managers-resource-management-scheduling/marathon-cheat-sheet)
* SERVICES
  * [dockerhub](https://hub.docker.com/)

## RUN

To
[run.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/run.sh),

```bash
cd hello-go-deploy-marathon-code
go run main.go
```

To
[create-binary.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/bin/create-binary.sh),

```bash
cd hello-go-deploy-marathon-code/bin
go build -o hello-go ../main.go
./hello-go
```

This binary will not be used during a docker build
since it creates it's own.

## STEP 1 - TEST

To create unit `_test` files,

```bash
cd hello-go-deploy-marathon-code
gotests -w -all main.go
```

To run
[unit-tests.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/tree/master/hello-go-deploy-marathon-code/test/unit-tests.sh),

```bash
go test -cover ./... | tee test/test_coverage.txt
cat test/test_coverage.txt
```

## STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)

This docker image is built in two stages.
In **stage 1**, rather than copy a binary into a docker image (because
that can cause issues), the Dockerfile will build the binary in the
docker image.
In **stage 2**, the Dockerfile will copy this binary
and place it into a smaller docker image based
on `alpine`, which is around 13MB.

To
[build.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/build/build.sh)
with a
[Dockerfile](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/build/Dockerfile),

```bash
cd hello-go-deploy-marathon-code/build
docker build -f Dockerfile -t jeffdecola/hello-go-deploy-marathon .
```

You can check and test this docker image,

```bash
docker images jeffdecola/hello-go-deploy-marathon
docker run --name hello-go-deploy-marathon -dit jeffdecola/hello-go-deploy-marathon
docker exec -i -t hello-go-deploy-marathon /bin/bash
docker logs hello-go-deploy-marathon
docker rm -f hello-go-deploy-marathon
```

## STEP 3 - PUSH (TO DOCKERHUB)

You must be logged in to DockerHub,

```bash
docker login
```

To
[push.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/push/push.sh),

```bash
docker push jeffdecola/hello-go-deploy-marathon
```

Check the
[hello-go-deploy-marathon docker image](https://hub.docker.com/r/jeffdecola/hello-go-deploy-marathon)
at DockerHub.

## STEP 4 - DEPLOY (TO MARATHON)

The
[app.json](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/deploy/app.json)
tells marathon how to deploy the docker image from dockerhub.

To run mesos/marathon in a docker container,

```bash
docker run --rm --privileged -p 5050:5050 -p 5051:5051 -p 8080:8080 mesos/mesos-mini:1.9.x
http://localhost:8080
http://192.168.20.122:8080
```

To
[deploy.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/hello-go-deploy-marathon-code/deploy/deploy.sh),

```bash
cd hello-go-deploy-marathon-code/deploy
curl -X PUT http://localhost:8080/v2/apps/hello-go-long-running \
-d @app.json \
-H "Content-type: application/json"
```

## CONTINUOUS INTEGRATION & DEPLOYMENT

Refer to
[ci-README.md](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/ci-README.md)
on how I automated the above steps using concourse.
