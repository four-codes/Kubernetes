Requirements

    1. master-server-1 10.0.0.6
    2. master-server-2 10.0.0.7

Requirement packages

    1. Kubeadm
    2. kubectl
    3. kubelet

Prerequites:

    echo "10.0.0.6 master-server-1" | sudo tee -a /etc/hosts
    echo "10.0.0.7 master-server-2" | sudo tee -a /etc/hosts


Installtion

master-server-1 and master-server-2

    sudo -i
    curl -s https://raw.githubusercontent.com/FourTimes/Kubernetes/master/kubeadm-docker-install.sh | bash

cluster initiate in master-server-1

    sudo kubeadm init --control-plane-endpoint "10.0.0.8:6443" --upload-certs --pod-network-cidr=192.168.0.0/16

credentials downlaods

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

master-server-1 to master-server-2

    scp -r $HOME/.kube node@master-server-2:/HOME/node/.kube

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 10.0.0.6:6443 --token i3tmvq.yhq7a6vp6exuajhj \
    --discovery-token-ca-cert-hash sha256:41da242f31ccefff945dd521d209ef3e900fa95ab35df0839fad99c6ab10a20e \
    --control-plane --certificate-key fba12263ee5e9fd9fb223cf478722c6541c0e098e77127d6d4c7ee40bc845a30

Then you can join any number of worker nodes by running the following on each as root:

    kubeadm join 10.0.0.6:6443 --token i3tmvq.yhq7a6vp6exuajhj \
        --discovery-token-ca-cert-hash sha256:41da242f31ccefff945dd521d209ef3e900fa95ab35df0839fad99c6ab10a20e 

You should now deploy a pod network to the cluster.

    $ kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml
    
 verify:
    
    master-server-1
    
        kubectl get all
        
    master-server-2
        
        kubectl get all
