```yml
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: spring-config
    app.kubernetes.io/usage: Database
  name: spring-config-staging
data:
  SMTP_TLS: "True"
  SMTP_PORT: "587"
  SMTP_HOST: ""
  SMTP_USER: ""
  SMTP_PASSWORD: ""
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/name: spring-secret
    app.kubernetes.io/usage: Database
  name: spring-secret-staging
data:
  SECRET_KEY: YmU1YTYxYmFmMTg2YWM3ZmY0 # echo -n "dsjv12344!@#$%^&**((jdmdml" | base64 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
spec:
  selector:
    matchLabels:
      app: api-server
  replicas: 1
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api-server
          image: nginx
          imagePullPolicy: "IfNotPresent"
          ports:
            - containerPort: 80
          envFrom:
            - configMapRef:
                name: spring-config-staging
            - secretRef:
                name: spring-secret-staging

```
