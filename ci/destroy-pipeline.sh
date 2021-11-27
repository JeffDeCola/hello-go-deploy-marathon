#!/bin/bash
# hello-go-deploy-marathon destroy-pipeline.sh

echo " "
echo "Destroy pipeline on target jeffs-ci-target which is team jeffs-ci-team"
fly --target jeffs-ci-target \
    destroy-pipeline \
    --pipeline hello-go-deploy-marathon
echo " "
