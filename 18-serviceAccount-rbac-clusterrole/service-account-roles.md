--------------

    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: deployment-clusterrole
      namespace: app-teaml
    rules:
      - apiGroups: ["apps", "extensions"]
        resources: ["DaemonSet", "Deployment", "ReplicaSet", "StatefulSet"]
        verbs: ["get", "watch", "list", "create", "update", "delete"]
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: deployment-clusterrole
      namespace: app-teaml
    subjects:
      - kind: ServiceAccount
        name: cicd-token
        namespace: app-teaml
    roleRef:
      kind: Role
      name: deployment-clusterrole
      apiGroup: rbac.authorization.k8s.io
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: cicd-token
      namespace: app-teaml

-------------
