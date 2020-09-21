[What is a Pod?](https://kubernetes.io/docs/concepts/workloads/pods/#what-is-a-pod)
  
    The shared context of a Pod is a set of Linux namespaces, cgroups, and potentially other facets of isolation - the same things that isolate a Docker container. Within a Pod's context, the individual applications may have further sub-isolations applied.

In the above we have 2 containers in single pod.If I want to check logs in one of the container then do below command.


kubectl logs pod/multicontainer-pods -c web ---> i can see logs from web container
kubectl logs pod/multicontainer-pods -c db ---> i can see logs from db container
kubectl exec -it pod/multicontainer-pods -c web bash --> i can login to web container