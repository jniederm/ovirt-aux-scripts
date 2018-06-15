#!/usr/bin/bash

set -e

STATUS_OUTPUT=$(oc cluster status) || CLUSTER_RUNNING=true

if [ CLUSTER_RUNNING == 'true' ] ; then 
  echo cluster seems to be runing
  echo ---
  echo $STATUS_OUTPUT
  echo ---
  exit 1
fi

oc cluster up --service-catalog=true

oc login -u system:admin

oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-privileged
oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-controller
oc apply -f https://github.com/kubevirt/kubevirt/releases/download/v0.6.0/kubevirt.yaml

oc adm policy add-cluster-role-to-user cluster-admin admin
oc adm policy add-cluster-role-to-user cluster-admin system:admin

oc new-project project1