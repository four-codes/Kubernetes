Labels and Selectors

    Labels are key/value pairs that are attached to objects, such as pods. Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system. Labels can be used to organize and to select subsets of objects. Labels can be attached to objects at creation time and subsequently added and modified at any time. Each object can have a set of key/value labels defined. Each Key must be unique for a given object.

Reference

    release = stable 
    release = canary

    environment = dev 
    environment = qa 
    environment = production

    tier = frontend
    tier = backend
    tier = cache

    partition = customerA 
    partition = customerB

    track = daily
    track = weekly


Examples:

    kubectl get namespaces --show-labels

LIST and WATCH filtering

    kubectl get pods -l environment=production,tier=frontend
    kubectl get pods -l 'environment in (production),tier in (frontend)'
    kubectl get pods -l 'environment,environment notin (frontend)'    kubectl get pods -l 'environment in (production, qa)'
