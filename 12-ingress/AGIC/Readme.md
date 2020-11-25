**kubernetes azure application gateway ingress controller (rbac)**

   The ingress controller runs as a pod within the AKS cluster. It consumes Kubernetes Ingress Resources and converts them to an Azure Application Gateway configuration which allows the gateway to load-balance traffic to Kubernetes pods.

*Identity*

| serial number | identity type |
| --------------- | --------------- |
| 1 | User Assigned Identity |
| 2 | Service Principle |

*User Assigned Identity access*

| serial number | Access type |
| --------------- | --------------- |
| 1 | Contributor access to Application Gateway  |
| 2 | Reader accesss to Application Gateway's resource group |
| 3 | NetworkContributorRole  |

*Service Principle Access*

| serial number | Access type |
| --------------- | --------------- |
| 1 | Contributor access to Application Gateway |
| 2 | Reader accesss to Application Gateway's resource group |
| 3 | NetworkContributorRole  |


*Requirements Pods*

    1. Managed Identity Controller (MIC)
    2. Node Managed Identity (NMI)

*Managed Identity Controller (MIC)*

   It runs with multiple replicas and one Pod is elected leader. It is responsible to do the assignment of the identity to the AKS nodes

*Node Managed Identity (NMI)*

   It runs as daemon on every node. It is responsible to enforce the IP table rules to allow AGIC to GET the access token

*Require variables for Service Principle*

| Key | Value |
| --------------- | --------------- |
| APPGW_VERBOSITY_LEVEL | 3 |
| HTTP_SERVICE_PORT | 8123 |
| APPGW_SUBSCRIPTION_ID | xxxxxxxxxxxxxxxxxxxxe  |
| APPGW_RESOURCE_GROUP | miga-portal-dev  |
| APPGW_NAME | agw-demoslock-dev  |
| APPGW_SUBNET_NAME | agw-demoslock-dev-subnet  |

For example

    APPGW_RESOURCE_GROUP:  "miga-portal-dev"

*Require variables for User Assigned Identity*

| Key | Value |
| --------------- | --------------- |
| identityResourceID | identityResourceId |
| identityClientID | identityClientId |

*To find the resources use labels*

| Labels | Values |
| --------------- | --------------- |
| app.kubernetes.io/name | azure-agic-ingress |

*commandLine*

      kubectl get ServiceAccount,configmap,secret,pods,deployment,replicaset,daemonset,CustomResourceDefinition,ClusterRole,ClusterRoleBinding -l app.kubernetes.io/name=azure-agic-ingress -A

*Require api components*

| kubernetes api components | namespace |
| --------------- | --------------- |
| serviceaccount | true |
| configmap | true |
| secret | true |
| pod | true |
| replicaset | true |
| deployment | true |
| daemonset | true |
| customresourcedefinition | false |
| clusterrole | false |
| clusterrolebinding | false |



*Reference*
  
    1. https://azure.github.io/application-gateway-kubernetes-ingress/logging-levels/
    2. https://github.com/Azure/application-gateway-kubernetes-ingress/tree/master/helm/ingress-azure
