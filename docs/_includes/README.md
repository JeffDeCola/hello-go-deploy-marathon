  _built with
  [concourse](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/ci-README.md)_

# OVERVIEW

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
docker run --rm --privileged -p 5050:5050 -p 5051:5051 -p 8080:8080 mesos/mesos-mini
http://localhost:8080
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
