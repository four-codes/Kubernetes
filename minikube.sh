!#/usr/bin/env bash

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo chmod +x minikube

sudo mv minikube /usr/local/bin/
\
minikube version
