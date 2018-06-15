## openshift

1. install docker
2. download full openshift form github, add `oc` to the PATH env variable
3. sudo groupadd docker
4. sudo usermod -aG docker $USER
5. su - $USER  # to reload effective group list
6. enable ipv4 routing - temporarily, permanently
   `sudo sysctl net.ipv4.ip_forward=1`, add following line to /etc/sysctl.conf

       net.ipv4.ip_forward=1
   
7. add insecure-registry, see https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md#getting-started
   add following into file /etc/containers/registries.conf

       [registries.insecure]
       registries = ['172.30.0.0/16']

8. enable docker service
   `sudo systemctl enable docker`
9. start docker service
   `sudo systemctl start docker`
10. setup firewall
    
        firewall-cmd --permanent --new-zone dockerc
        firewall-cmd --permanent --zone dockerc --add-source $(docker network inspect -f "{{range .IPAM.Config }}{{ .Subnet }}{{end}}" bridge)
        firewall-cmd --permanent --zone dockerc --add-port 8443/tcp
        firewall-cmd --permanent --zone dockerc --add-port 53/udp
        firewall-cmd --permanent --zone dockerc --add-port 8053/udp
        firewall-cmd --reload

    or alternatively 

        sudo systemctl stop firewalld
        sudo systemctl disable firewalld

11. oc cluster up

## kubevirt

    oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-privileged
    oc adm policy add-scc-to-user privileged system:serviceaccount:kube-system:kubevirt-controller
    oc apply -f https://github.com/kubevirt/kubevirt/releases/download/v0.6.0/kubevirt.yaml

## extend admin permissions

Make users `admin` and `system:admin` superusers.

    oc login -u system:admin
    oc adm policy add-cluster-role-to-user cluster-admin admin
    oc adm policy add-cluster-role-to-user cluster-admin system:admin