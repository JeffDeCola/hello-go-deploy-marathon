#!/bin/bash
# hello-go-deploy-marathon build.sh

set -e -x

# The code is located in /hello-go-deploy-marathon
echo "List whats in the current directory"
ls -lat 
echo ""

# Setup the gopath based on current directory.
export GOPATH=$PWD

# Now we must move our code from the current directory ./hello-go-deploy-marathon to $GOPATH/src/github.com/JeffDeCola/hello-go-deploy-marathon
mkdir -p src/github.com/JeffDeCola/
cp -R ./hello-go-deploy-marathon src/github.com/JeffDeCola/.

# All set and everything is in the right place for go
echo "Gopath is: $GOPATH"
echo "pwd is: $PWD"
echo ""
cd src/github.com/JeffDeCola/hello-go-deploy-marathon

# Put the binary hello-go-deploy-marathon filename in /dist
go build -o dist/hello-go-deploy-marathon ./main.go

# cp the Dockerfile into /dist
cp ci/Dockerfile dist/Dockerfile

# Check
echo "List whats in the /dist directory"
ls -lat dist
echo ""

# Move what you need to $GOPATH/dist
# BECAUSE the resource type docker-image works in /dist.
cp -R "./dist" "$GOPATH/."

cd "$GOPATH"
# Check whats here
echo "List whats in top directory"
ls -lat 
echo ""

# Check whats in /dist
echo "List whats in /dist"
ls -lat dist
echo ""