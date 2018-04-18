
* install centos
* add repo http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/ (to get old docker)
* add repo     yum install http://resources.ovirt.org/pub/yum-repo/ovirt-release-master.rpm (to get 2.5 ansible)
* clone repo openshift-ansible
* tweak localhost inventory file
  * add insecure-registry registry.access.redhat.com
  * add add-registry registry.access.redhat.com
* insecure registry at /etc/sysconfig/docker
* delete broken symlink at ... redhat-ca.crt
* install python-passlib
