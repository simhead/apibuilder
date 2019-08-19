#!/bin/bash

namespace=$1
apiname=$2
imagelocation=$3
yamllocation=$4
artifactorylogin=$5
buildnum=$6
artifactoryURL=$7

echo ${imagelocation}
echo "Generate k8s yaml files"

sed -i 's/\${apiname}/'${apiname}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml
sed -i 's/\${version}/'${buildnum}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml
sed -i 's/\${namespace}/'${namespace}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml
sed -i 's/\${imagelocation}/axwayaustralia\/'${imagelocation}'/g' $yamllocation/apibuilder-deploy.yaml $yamllocation/apibuilder-gw.yaml $yamllocation/apibuilder-vs.yaml

echo "Upload to Artifactory"
k8sdeployment=${artifactoryURL}"/yaml/"${buildnum}"/apibuilder-deploy.yaml"
k8sgateway=${artifactoryURL}"/yaml/"${buildnum}"/apibuilder-gw.yaml"
k8svirtualservice=${artifactoryURL}"/yaml/"${buildnum}"/apibuilder-vs.yaml"
curl -u${artifactorylogin} -T $yamllocation/apibuilder-deploy.yaml ${k8sdeployment}
curl -u${artifactorylogin} -T $yamllocation/apibuilder-gw.yaml ${k8sgateway}
curl -u${artifactorylogin} -T $yamllocation/apibuilder-vs.yaml ${k8svirtualservice}