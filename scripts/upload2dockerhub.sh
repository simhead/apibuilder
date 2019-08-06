#!/bin/bash

namespace=$1
packageName=$2
buildNumber=$3
zippedContents=$4
artifactoryURL=$5

groupId="axway.com"
artifactId="tbd"

echo "List all pods for namespace: ${namespace}"
wget ${artifactoryURL}${zippedContents}
mkdir /tmp/${packageName}-${buildNumber}
tar -zxvf ./${zippedContents} -C  /tmp/${packageName}-${buildNumber}/

