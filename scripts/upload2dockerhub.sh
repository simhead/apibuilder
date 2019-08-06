#!/bin/bash

namespace=$1
packageName=$2
buildNumber=$3
zippedContents=$4

groupId="axway.com"
artifactId="tbd"

echo "List all pods for namespace: ${namespace}"
tar -zxvf ./${zippedContents} -C  /tmp/${packageName}-${buildNumber}/
