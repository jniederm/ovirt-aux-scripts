#!/usr/bin/bash

set -e

oc login -u system:admin

oc new-project ansible-service-broker
curl -s https://raw.githubusercontent.com/openshift/ansible-service-broker/master/templates/simple-broker-template.yaml |
  oc process -n "ansible-service-broker" -f - |
  oc create -f -

# show available service classes (~ APBs)
oc get clusterserviceclasses --all-namespaces -o custom-columns=NAME:.metadata.name,DISPLAYNAME:spec.externalMetadata.displayName |
  grep APB