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
