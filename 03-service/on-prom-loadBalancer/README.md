[OFFICIAL GITHUB](https://github.com/metallb/metallb)

     MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.


[OFFICIAL SITE](https://metallb.universe.tf/)

Reference
     
- [LINK1](https://www.definit.co.uk/2019/08/lab-guide-kubernetes-load-balancer-and-ingress-with-metallb-and-contour/)
- [LINK2](https://dzone.com/articles/kubernetes-metallb-bare-metal-loadbalancer)

Installtion process:

     kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl diff -f - -n kube-system

     # actually apply the changes, returns nonzero returncode on errors only
     kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

     # On first install only
     kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

To change config file

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 10.1.0.100-10.1.0.200 # This is your localnetwork IP address Range
EOF