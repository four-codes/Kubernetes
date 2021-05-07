```yml

apiVersion: v1
kind: Secret
metadata:
  name: postgres
type: Opaque
data:
  password: cG9zdGdyZXM=
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: sonar-data
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: custom-gp2
  resources:
    requests:
      storage: 10Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: sonar-extensions
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: custom-gp2
  resources:
    requests:
      storage: 10Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: sonarqube
  name: sonarqube
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
  selector:
    matchLabels:
      app: sonarqube
  template:
    metadata:
      labels:
        app: sonarqube
    spec:
      containers:
        - name: sonarqube
          image: sonarqube:latest
          ports:
          - containerPort: 9000
            protocol: TCP
          resources:
            requests:
              cpu: 500m
              memory: 1024Mi
            limits:
              cpu: 2000m
              memory: 2048Mi
          volumeMounts:
          - mountPath: "/opt/sonarqube/data/"
            name: sonar-data
          - mountPath: "/opt/sonarqube/extensions/"
            name: sonar-extensions
          env:
          - name: "SONARQUBE_JDBC_USERNAME"
            value: "postgres"
          - name: "SONARQUBE_JDBC_URL"
            value: "jdbc:postgresql://postgres-service/sonar"
          - name: "SONARQUBE_JDBC_PASSWORD"
            valueFrom:
              secretKeyRef:
                name: postgres
                key: password
      volumes:
      - name: sonar-data
        persistentVolumeClaim:
          claimName: sonar-data
      - name: sonar-extensions
        persistentVolumeClaim:
          claimName: sonar-extensions
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: sonarqube
  name: sonarqube
spec:
  type: ClusterIP
  selector:
    app: sonarqube
  ports:
  - port: 9000
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: sonar
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/proxy-body-size: "20m"
spec:
  rules:
  - host: sonar.tspring.co
    http:
      paths:
      - path: / 
        backend:
          serviceName: sonarqube
          servicePort: 9000
        
#  2004  wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
#  2005  unzip sonar-scanner-cli-4.2.0.1873-linux.zip
#  2006  mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner
#  2009  export PATH=$PATH:/opt/sonar-scanner/bin
#  2010  sonar-scanner -v
#  2012  sonar-scanner   -Dsonar.projectKey=demo   -Dsonar.sources=.   -Dsonar.host.url=https://sonar.tspring.co   -Dsonar.login=2d911a190a4f0cb75985babb79a


```
