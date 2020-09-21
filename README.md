# Kubernetes
    
    One or more machines running one of:
    
        Ubuntu 16.04+
        Debian 9+
        CentOS 7
        Red Hat Enterprise Linux (RHEL) 7
        Fedora 25+
        HypriotOS v1.0.1+
        Flatcar Container Linux (tested with 2512.3.0)
        
    2 GB or more of RAM per machine (any less will leave little room for your apps)
    2 CPUs or more
    Full network connectivity between all machines in the cluster (public or private network is fine)
    Unique hostname, MAC address, and product_uuid for every node.
    Certain ports are open on your machines.
    Swap disabled. You MUST disable swap in order for the kubelet to work properly.

    Verify the MAC address and product_uuid are unique for every node

      1. You can get the MAC address of the network interfaces using the command ip link or ifconfig -a
      2. The product_uuid can be checked by using the command sudo cat /sys/class/dmi/id/product_uuid
      
    
 Reference Link:
    
    # https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
