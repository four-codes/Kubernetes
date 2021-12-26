#!/usr/binv/env bash

# KUBECTL
alias k='kubectl'

# GET and SWITCH namespaces
alias ns='kubens'

# GET and SWITCH CONTEXT
alias ctx='kubectx'

# GET PODS
alias po='kubectl get po'
alias dpo='kubectl describe pod'

# GET ALL DEDAULT RESOURCES
alias all='kubectl get all'

# GET SERVICES
alias svc='kubectl get svc'
alias dsvc='kubectl describe svc'

# GET SECRET
alias se='kubectl get secret'
alias dse='kubectl describe secret'

# GET CONFIGMAP
alias cm='kubectl get cm'
alias dcm='kubectl describe cm'

# GET DEAMONSET
alias ds='kubectl get ds'
alias dds='kubectl describe ds'

# GET STATEFULSET
alias sts='kubectl get sts'
alias dsts='kubectl describe sts'

# GET DEPLOYMENTSET
alias deps='kubectl get deploy'
alias ddeps='kubectl describe deploy'

# GET INGRESS
alias ing='kubectl get ingress'
alias ding='kubectl describe ingress'

#GET POD SECURITY POLICY
alias psp='kubectl get psp'
alias dpsp='kubectl describe psp'

# GET POD DISTRIBUTIONS
alias pdp='kubectl get pdp'
alias dpdp='kubectl describe pdp'

# GET STORAGECLASS
alias sc='kubectl get sc'
alias dsc='kubectl describe sc'

# GET PVC
alias pvc='kubectl get pvc'
alias dpvc='kubectl describe pvc'

# GET NODE
alias no='kubectl get no'
alias dno='kubectl describe no'

# GET SERVICE ACCOUNT
alias no='kubectl get sa'
alias dno='kubectl describe sa'

# GET ROLE
alias r='kubectl get roles'
alias dr='kubectl describe roles'

# GET ROLEBINDING
alias rb='kubectl get rolebindings'
alias drb='kubectl describe rolebindings'

# GET CLUSTER ROLE
alias cr='kubectl get clusterroles'
alias dcr='kubectl describe clusterroles'

# GET CLUSTER ROLEBINDING
alias crb='kubectl get clusterrolebindings'
alias dcrb='kubectl describe clusterrolebindings'

# kubectx installation
# wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz

# kubectx installation
# wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz
