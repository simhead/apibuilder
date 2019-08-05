#!/bin/bash

jobname=$1
buildNumber=$2
workdir=$3
namespace=$4

groupId="axway.com"
artifactId="tbd"

echo "List all pods for namespace: ${namespace}"
kubectl get po -n ${namespace}
