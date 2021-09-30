
Ingres resources are not getting deleted even though the alb ingress controller deployment is deleted 


```bash

kubectl patch ingress api -n staging -p '{"metadata":{"finalizers":[]}}' --type=merge

```
