[Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

    Kubernetes supports multiple virtual clusters backed by the same physical cluster. These virtual clusters are called namespaces.

When to Use Multiple Namespaces?
    
    Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

    Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces. Namespaces cannot be nested inside one another and each Kubernetes resource can only be in one namespace.

Viewing namespaces

    kubectl get namespace

Kubernetes starts with four initial namespaces:

    1. default 
        
        The default namespace for objects with no other namespace
    
    2. kube-system 
        
        The namespace for objects created by the Kubernetes system
    
    3. kube-public
        
        This namespace is created automatically and is readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.
    
    4. kube-node-lease 
        
        This namespace for the lease objects associated with each node which improves the performance of the node heartbeats as the cluster scales.

Pod Run

    kubectl run httpd --image=httpd

Setting the namespace for a request

    kubectl create namespace test
    kubectl get ns

Setting the namespace preference
 
    kubectl config set-context --current --namespace=test
    
    # Validate it

    kubectl config view --minify | grep namespace:


test Run

    kubectl run nginx --image=nginx --namespace=test


diffrence between yml vs json

    # json format

    {
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "name": "animals",
        "labels": {
        "name": "lion"
        }
    }
    }

    # Yml format  
    ---
    apiVersion: v1
    kind: Namespace
    metadata:
      name: animals
      labels:
        name: lion