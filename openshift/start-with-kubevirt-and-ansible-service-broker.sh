#!/usr/bin/bash

set -e

CURRENT_DIR=$(dirname ${BASH_SOURCE[0]})

# ORIGIN_VERSION=v3.9.0-alpha.3 bash $CURRENT_DIR/from-ansible-service-broker/run_latest_build.sh
oc cluster up --service-catalog=true --metrics=true
oc login -u system:admin

oc adm policy add-cluster-role-to-user cluster-admin admin
oc adm policy add-cluster-role-to-user cluster-admin system:admin

oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-privileged
oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-controller

#docker pull docker.io/ansibleplaybookbundle/kubevirt-apb
#docker run --rm --net=host -v $HOME/.kube:/opt/apb/.kube:z -u $UID docker.io/ansibleplaybookbundle/kubevirt-apb provision --extra-vars 'namespace=kube-system' --extra-vars 'admin_user=admin' --extra-vars 'admin_password=admin' --extra-vars 'namespace=kube-system' --extra-vars 'cluster=openshift' --extra-vars 'tag=v0.3.0'

kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/v0.3.0/kubevirt.yaml

oc login -u admin

#apb setup

oc new-project project1
oc project project1
oc create -f $CURRENT_DIR/blank-ovm.yaml
