#!/usr/bin/bash

set -e

ORIGIN_VERSION=v3.9.0-alpha.3 bash <(curl -s https://raw.githubusercontent.com/openshift/ansible-service-broker/master/scripts/run_latest_build.sh)
oc adm policy add-cluster-role-to-user cluster-admin admin
oc adm policy add-cluster-role-to-user cluster-admin system:admin
docker pull docker.io/ansibleplaybookbundle/kubevirt-apb
docker run --rm --net=host -v $HOME/.kube:/opt/apb/.kube:z -u $UID docker.io/ansibleplaybookbundle/kubevirt-apb provision --extra-vars 'namespace=kube-system' --extra-vars 'admin_user=admin' --extra-vars 'admin_password=admin' --extra-vars 'namespace=kube-system' --extra-vars 'cluster=openshift' --extra-vars 'tag=v0.3.0'
apb setup

oc new-project project1
oc project project1
oc create -f $(dirname ${BASH_SOURCE[0]})/blank-ovm.yaml