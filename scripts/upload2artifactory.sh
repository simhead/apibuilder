#!/bin/bash

namespace=$1
apiname=$2
imagelocation=$3
yamllocation=$4
artifactorylogin=$5
buildnum=$6

echo "Generate k8s yaml files"

sed -i 's/\${apiname}/'${apiname}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml
sed -i 's/\${namespace}/'${namespace}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml
sed -i 's/\${imagelocation}/'${imagelocation}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml

echo "Upload to Artifactory"
k8s-deployment="http://jfrog.dev.axway-aus.de/artifactory/axway-aus/apibuilder/"${buildnum}"/apibuilder-deploy.yaml"
k8s-gateway="http://jfrog.dev.axway-aus.de/artifactory/axway-aus/apibuilder/"${buildnum}"/apibuilder-gw.yaml"
k8s-virtualservice="http://jfrog.dev.axway-aus.de/artifactory/axway-aus/apibuilder/"${buildnum}"/apibuilder-vs.yaml"
curl -u${artifactorylogin} -T $yamllocation/apibuilder-deploy.yaml ${k8s-deployment}
curl -u${artifactorylogin} -T $yamllocation/apibuilder-gw.yaml ${k8s-gateway}
curl -u${artifactorylogin} -T $yamllocation/apibuilder-vs.yaml ${k8s-virtualservice}