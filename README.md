Kubernetes Cluster Requirments

| server name | CPU | memory | operating system |
| --------------- | --------------- | --------------- | --------------- |
| master-server | 2 CPU | 4GB RAM | ubuntu os 16+ |
| worker-server-one | 2 CPU | 4GB RAM | ubuntu os 16+ |
| worker-server-two | 2 CPU | 4GB RAM | ubuntu os 16+ |

[GitHub Reference](https://www.pluralsight.com/guides/working-tables-github-markdown)

[local development](https://kubernetes.io/docs/tasks/tools/install-minikube/)

    curl -L https://raw.githubusercontent.com/FourTimes/Kubernetes/master/minikube.sh | bash

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
      
[Master ports](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components)

| Protocol | Direction | Port Range | Purpose | Used By |
| --------------- | --------------- | --------------- | --------------- | --------------- |
| TCP | Inbound | 6443* | Kubernetes API server | All  |
| TCP | Inbound | 2379-2380 | etcd server client API | kube-apiserver, etcd |
| TCP | Inbound | 10250 | Kubelet API | Self, Control plane |
| TCP | Inbound | 10251 | kube-scheduler | Self |
| TCP | Inbound | 10252 |  kube-controller-manager | Self |


[Worker node](https://kubernetes.io/docs/concepts/overview/components/#node-components)


| Protocol | Direction | Port Range | Purpose | Used By |
| --------------- | --------------- | --------------- | --------------- | --------------- |
| TCP | Inbound | 10250 | Kubelet API | Self, Control plane  |
| TCP | Inbound | 30000-32767 | NodePort Services | All |
      		

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
    
    or 
    
    # kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

Cluster Verification Process

    # kubectl cluster-info
    # kubectl get events
    # kubectl get nodes
    # kubectl get nodes -o wide
    # kubectl get nodes --show-lables
    # kubectl get namespaces
    # kubectl get pods --all-namespaces
    
[Token Creation process](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-token/):
    
    # kubeadm token list
    # kubeadm token create --print-join-command
    

[Token Create process Manual](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-token/)
    
    # openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null |  openssl dgst -sha256 -hex | sed 's/^.* //'
    # kubeadm join --token <token> <master-ip>:6443 --discovery-token-ca-cert-hash sha256:<hash>
    

Node add verification process
    
    # kubectl get nodes
    # kubectl get nodes -o wide
    # kubectl get nodes --show-lables
    # kubectl get pods -n kube-system

Worker Node Label set

    Add Label

        kubectl label nodes <your_node> kubernetes.io/role=<your_label>
    
    Update Label

        kubectl label --overwrite nodes <your_node> kubernetes.io/role=<your_node>

    Remove Label

        kubectl label node <node name> node-role.kubernetes.io/<role name>-

Master Act as node

    kubectl taint nodes --all node-role.kubernetes.io/master-
    kubectl taint nodes --all node-role.kubernetes.io/control-plane-

[kubeadm commands reference](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)

[Kubernetes API Access](https://kubernetes.io/docs/reference/kubectl/overview/)

    # curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` /bin/linux/amd64/kubectl
    # chmod +x kubectl
    # sudo mv kubectl /usr/local/bin/
    # kubectl version
    
 Autocomplete kubectl

    echo 'source <(kubectl completion bash)' >>~/.bashrc
    
[kubectl commands refer](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

API Mechanisam
    
    https://[MasterIP]/api/v1/namespaces/[Namespace Name]/pods/[Pod Name]
    
  | Namespace Name | Pod Name | 
  | --------------- | --------------- |
  | default | webserver | 

        
    https://104.196.160.178/api/v1/namespaces/default/pods/webserver
 
Pod security check command

    kubectl auth can-i use psp/permissive --as=any-user
    kubectl auth can-i use psp/permissive



Kubectl context and configuration

    kubectl config view # Show Merged kubeconfig settings.

    # use multiple kubeconfig files at the same time and view merged config
    KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 

    kubectl config view

    # get the password for the e2e user
    kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'

    kubectl config view -o jsonpath='{.users[].name}'    # display the first user
    kubectl config view -o jsonpath='{.users[*].name}'   # get a list of users
    kubectl config get-contexts                          # display list of contexts 
    kubectl config current-context                       # display the current-context
    kubectl config use-context my-cluster-name           # set the default context to my-cluster-name

    # add a new user to your kubeconf that supports basic auth
    kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword

    # permanently save the namespace for all subsequent kubectl commands in that context.
    kubectl config set-context --current --namespace=ggckad-s2

    # set a context utilizing a specific username and namespace.
    kubectl config set-context gce --user=cluster-admin --namespace=foo && kubectl config use-context gce

    kubectl config unset users.foo                       # delete user foo


Viewing, finding resources

    # Get commands with basic output
    kubectl get services                          # List all services in the namespace
    kubectl get pods --all-namespaces             # List all pods in all namespaces
    kubectl get pods -o wide                      # List all pods in the current namespace, with more details
    kubectl get deployment my-dep                 # List a particular deployment
    kubectl get pods                              # List all pods in the namespace
    kubectl get pod my-pod -o yaml                # Get a pod's YAML

    # Describe commands with verbose output
    kubectl describe nodes my-node
    kubectl describe pods my-pod

    # List Services Sorted by Name
    kubectl get services --sort-by=.metadata.name

    # List pods Sorted by Restart Count
    kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

    # List PersistentVolumes sorted by capacity
    kubectl get pv --sort-by=.spec.capacity.storage

    # Get the version label of all pods with label app=cassandra
    kubectl get pods --selector=app=cassandra -o \
      jsonpath='{.items[*].metadata.labels.version}'

    # Retrieve the value of a key with dots, e.g. 'ca.crt'
    kubectl get configmap myconfig \
      -o jsonpath='{.data.ca\.crt}'

    # Get all worker nodes (use a selector to exclude results that have a label
    # named 'node-role.kubernetes.io/master')
    kubectl get node --selector='!node-role.kubernetes.io/master'

    # Get all running pods in the namespace
    kubectl get pods --field-selector=status.phase=Running

    # Get ExternalIPs of all nodes
    kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'

    # List Names of Pods that belong to Particular RC
    # "jq" command useful for transformations that are too complex for jsonpath, it can be found at https://stedolan.github.io/jq/
    sel=${$(kubectl get rc my-rc --output=json | jq -j '.spec.selector | to_entries | .[] | "\(.key)=\(.value),"')%?}
    echo $(kubectl get pods --selector=$sel --output=jsonpath={.items..metadata.name})

    # Show labels for all pods (or any other Kubernetes object that supports labelling)
    kubectl get pods --show-labels

    # Check which nodes are ready
    JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}' \
     && kubectl get nodes -o jsonpath="$JSONPATH" | grep "Ready=True"

    # List all Secrets currently in use by a pod
    kubectl get pods -o json | jq '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq

    # List all containerIDs of initContainer of all pods
    # Helpful when cleaning up stopped containers, while avoiding removal of initContainers.
    kubectl get pods --all-namespaces -o jsonpath='{range .items[*].status.initContainerStatuses[*]}{.containerID}{"\n"}{end}' | cut -d/ -f3

    # List Events sorted by timestamp
    kubectl get events --sort-by=.metadata.creationTimestamp

    # Compares the current state of the cluster against the state that the cluster would be in if the manifest was applied.
    kubectl diff -f ./my-manifest.yaml

    # Produce a period-delimited tree of all keys returned for nodes
    # Helpful when locating a key within a complex nested JSON structure
    kubectl get nodes -o json | jq -c 'path(..)|[.[]|tostring]|join(".")'

    # Produce a period-delimited tree of all keys returned for pods, etc
    kubectl get pods -o json | jq -c 'path(..)|[.[]|tostring]|join(".")'

Updating resources

    kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
    kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision 
    kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
    kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
    kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
    kubectl rollout restart deployment/frontend                      # Rolling restart of the "frontend" deployment

    cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into std

    # Force replace, delete and then re-create the resource. Will cause a service outage.
    kubectl replace --force -f ./pod.json

    # Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
    kubectl expose rc nginx --port=80 --target-port=8000

    # Update a single-container pod's image version (tag) to v4
    kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -

    kubectl label pods my-pod new-label=awesome                      # Add a Label
    kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
    kubectl autoscale deployment foo --min=2 --max=10                # Auto scale a deployment "foo"

Patching resources

    # Partially update a node
    kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}'

    # Update a container's image; spec.containers[*].name is required because it's a merge key
    kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'

    # Update a container's image using a json patch with positional arrays
    kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'

    # Disable a deployment livenessProbe using a json patch with positional arrays
    kubectl patch deployment valid-deployment  --type json   -p='[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'

    # Add a new element to a positional array
    kubectl patch sa default --type='json' -p='[{"op": "add", "path": "/secrets/1", "value": {"name": "whatever" } }]'

Editing resources

    kubectl edit svc/docker-registry                      # Edit the service named docker-registry
    KUBE_EDITOR="nano" kubectl edit svc/docker-registry   # Use an alternative editor

Scaling resources

    kubectl scale --replicas=3 rs/foo                                 # Scale a replicaset named 'foo' to 3
    kubectl scale --replicas=3 -f foo.yaml                            # Scale a resource specified in "foo.yaml" to 3
    kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # If the deployment named mysql's current size is 2, scale mysql to 3
    kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale multiple replication controllers

Deleting resources

    kubectl delete -f ./pod.json                                              # Delete a pod using the type and name specified in pod.json
    kubectl delete pod,service baz foo                                        # Delete pods and services with same names "baz" and "foo"
    kubectl delete pods,services -l name=myLabel                              # Delete pods and services with label name=myLabel
    kubectl -n my-ns delete pod,svc --all                                      # Delete all pods and services in namespace my-ns,
    # Delete all pods matching the awk pattern1 or pattern2
    kubectl get pods  -n mynamespace --no-headers=true | awk '/pattern1|pattern2/{print $1}' | xargs  kubectl delete -n mynamespace pod

Interacting with running Pods

    kubectl logs my-pod                                 # dump pod logs (stdout)
    kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
    kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
    kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
    kubectl logs -l name=myLabel -c my-container        # dump pod logs, with label name=myLabel (stdout)
    kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
    kubectl logs -f my-pod                              # stream pod logs (stdout)
    kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
    kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
    kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
    kubectl run nginx --image=nginx -n 
    mynamespace                                         # Run pod nginx in a specific namespace
    kubectl run nginx --image=nginx                     # Run pod nginx and write its spec into a file called pod.yaml
    --dry-run=client -o yaml > pod.yaml

    kubectl attach my-pod -i                            # Attach to Running Container
    kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
    kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
    kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
    kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers

Interacting with Nodes and cluster

    kubectl cordon my-node                                                # Mark my-node as unschedulable
    kubectl drain my-node                                                 # Drain my-node in preparation for maintenance
    kubectl uncordon my-node                                              # Mark my-node as schedulable
    kubectl top node my-node                                              # Show metrics for a given node
    kubectl cluster-info                                                  # Display addresses of the master and services
    kubectl cluster-info dump                                             # Dump current cluster state to stdout
    kubectl cluster-info dump --output-directory=/path/to/cluster-state   # Dump current cluster state to /path/to/cluster-state

    # If a taint with that key and effect already exists, its value is replaced as specified.
    kubectl taint nodes foo dedicated=special-user:NoSchedule

Resource types

    kubectl api-resources
    kubectl api-resources --namespaced=true      # All namespaced resources
    kubectl api-resources --namespaced=false     # All non-namespaced resources
    kubectl api-resources -o name                # All resources with simple output (just the resource name)
    kubectl api-resources -o wide                # All resources with expanded (aka "wide") output
    kubectl api-resources --verbs=list,get       # All resources that support the "list" and "get" request verbs
    kubectl api-resources --api-group=extensions # All resources in the "extensions" API group

Formatting output

    # All images running in a cluster
    kubectl get pods -A -o=custom-columns='DATA:spec.containers[*].image'

     # All images excluding "k8s.gcr.io/coredns:1.6.2"
    kubectl get pods -A -o=custom-columns='DATA:spec.containers[?(@.image!="k8s.gcr.io/coredns:1.6.2")].image'

    # All fields under metadata regardless of name
    kubectl get pods -A -o=custom-columns='DATA:metadata.*'

[command Reference](https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns) | [kubernetes books](https://kubectl.docs.kubernetes.io/) | [kubectl command](https://kubernetes.io/docs/reference/kubectl/kubectl/)


WorkLoads

[Pods](https://kubernetes.io/docs/concepts/workloads/pods/)

[ServicesDocs](https://kubernetes.io/docs/concepts/services-networking/)

[ControllerDocs](https://kubernetes.io/docs/concepts/workloads/controllers/)

[Storage](https://kubernetes.io/docs/concepts/storage/)

[Configuration](https://kubernetes.io/docs/concepts/configuration/)

[Security](https://kubernetes.io/docs/concepts/security/)

[Policies](https://kubernetes.io/docs/concepts/policy/)

[Scheduling and Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/)

[Practical Tasks](https://kubernetes.io/docs/tasks/)

[Access Applications in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/)

[Logging & Monitoring](https://kubernetes.io/docs/tasks/debug-application-cluster/)

[Extend Kubernetes](https://kubernetes.io/docs/tasks/extend-kubernetes/)

[TLS](https://kubernetes.io/docs/tasks/tls/)

[Manage Cluster Daemons](https://kubernetes.io/docs/tasks/manage-daemon/)

[Service Catalog](https://kubernetes.io/docs/tasks/service-catalog/)

[Tutorials](https://kubernetes.io/docs/tutorials/)
