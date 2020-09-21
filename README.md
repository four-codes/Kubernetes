Kubernetes Cluster Requirments

    master-server           2 CPU   4GB RAM
    worker-server-one       2 CPU   4GB RAM
    worker-server-two       2 CPU   4GB RAM

[Installing kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
    
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
      
  Check required ports
  
        Protocol	Direction  Port Range	   Purpose	                 Used By
        -------------------------------------------------------------------------------------
        TCP	        Inbound	    6443*	    Kubernetes API server	 All
        TCP	        Inbound	    2379-2380	    etcd server client API	 kube-apiserver, etcd
        TCP	        Inbound	    10250	    Kubelet API	                 Self, Control plane
        TCP	        Inbound	    10251	    kube-scheduler	         Self
        TCP	        Inbound	    10252	    kube-controller-manager	 Self
    
 Worker node(s)

    Protocol	Direction	Port Range	Purpose	                Used By
    ---------------------------------------------------------------------------------------
    TCP	        Inbound	        10250	        Kubelet API	        Self, Control plane
    TCP	        Inbound	        30000-32767	NodePort Services	All


Installtion 

    # curl -L https://raw.githubusercontent.com/FourTimes/Kubernetes/master/kubeadm-docker-install.sh | bash
    
[Master Initiate Process](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

    # kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr=192.168.0.0/16
    # mkdir -p $HOME/.kube
    # sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    # sudo chown $(id -u):$(id -g) $HOME/.kube/config

[kube proxy addons installation](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#configuration-options)

    # kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"


[kube proxy addons installation Manual](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#configuration-options)
    
    # export kubever=$(kubectl version | base64 | tr -d '\n')
    # kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

Cluster Verification Process

    # kubectl cluster-info
    # kubectl get events
    # kubectl get nodes
    # kubectl get nodes -o wide
    # kubectl get nodes --show-lables
    # kubectl get namespaces
    # kubectl get pods --all-namespaces
    
Token Creation process:
    
    # kubeadm token list
    # kubeadm token create --print-join-command
    

Token Create process Manual ( optional )
    
    # openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null |  openssl dgst -sha256 -hex | sed 's/^.* //'
    # kubeadm join --token <token> <master-ip>:6443 --discovery-token-ca-cert-hash sha256:<hash>
    

Node add verification process
    
    # kubectl get nodes
    # kubectl get nodes -o wide
    # kubectl get nodes --show-lables
    # kubectl get pods -n kube-system



Master Act as node

    kubectl taint nodes --all node-role.kubernetes.io/master-



Cloud Kubernetes API Access

    # curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` /bin/linux/amd64/kubectl
    # chmod +x kubectl
    # sudo mv kubectl /usr/local/bin/
    # kubectl version
    
 Autocomplete kubectl

    echo 'source <(kubectl completion bash)' >>~/.bashrc
    
