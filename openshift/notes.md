* oc whoami

oc policy add-role-to-user cluster-admin developer
oc adm policy add-cluster-role-to-user cluster-admin developer

## Openshift & Ansible Service Broker & Kubevirt developer environment

1. install `oc`
1. make sure `/run/docker.sock` is accesible to you operating system user
1. make sure docker daemon is started with option `insecure-registry` covering your docker network. E.g. `--insecure-registry 172.30.0.0/16`.  
   On Fedora 27 it's configured in file `/etc/sysconfig/docker`. If more addresses (address ranges) are required to cover, option `insecure-registry` can be user multiple times.
1. run `scripts/run_latest_build.sh` from repository https://github.com/openshift/ansible-service-broker with variable `ORIGIN_VERSION` set to version of `oc`. `oc` version can be printed using `oc version`. The version has to match a tag Docker Hub https://hub.docker.com/r/openshift/origin/tags/ repo.

    ORIGIN_VERSION=v3.9.0-alpha.3 scripts/run_latest_build.sh

1. set user roles

   ```
   oc adm policy add-cluster-role-to-user cluster-admin admin
   oc adm policy add-cluster-role-to-user cluster-admin system:admin
   ```

1. create apb users and setup their permissions

   ```
   apb setup
   ```

### Building and deploying APB

1. `apb build`
1. `apb push`

### List available APBs

1. oc get clusterserviceclasses -o=custom-columns=NAME:.metadata.name,EXTERNAL\ NAME:.spec.externalName

### List of provisioned services (serviceinstances)

    oc get serviceinstances

### List all catalog related entities

    oc get clusterservicebrokers,clusterserviceclasses,serviceinstances,servicebindings

### Kubevirt installation

In case Kubevirt APB doesn't work.

    docker pull docker.io/ansibleplaybookbundle/kubevirt-apb
    docker run --rm --net=host -v $HOME/.kube:/opt/apb/.kube:z -u $UID docker.io/ansibleplaybookbundle/kubevirt-apb provision --extra-vars 'namespace=kube-system' --extra-vars 'admin_user=admin' --extra-vars 'admin_password=admin' --extra-vars 'namespace=kube-system' --extra-vars 'cluster=openshift' --extra-vars 'tag=v0.3.0'