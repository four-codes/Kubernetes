deployment process

    kubectl set image deployment/frontend www=image:v2                                 # Rolling update "www" containers of "frontend" deployment, updating the image
    
    kubectl rollout history statefulset.apps/deployment-version-1                      # Check the history of deployments including the revision 
    
    kubectl rollout undo statefulset.apps/deployment-version-1                         # Rollback to the previous deployment
    
    kubectl rollout undo statefulset.apps/deployment-version-1 --to-revision=2         # Rollback to a specific revision
    
    kubectl rollout status -w statefulset.apps/deployment-version-1                    # Watch rolling update status of "frontend" deployment until completion
    
    kubectl rollout restart statefulset.apps/deployment-version-1                      # Rolling restart of the "frontend" deployment

    cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into std

    # Force replace, delete and then re-create the resource. Will cause a service outage.
    kubectl replace --force -f ./pod.json

    # Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
    kubectl expose rc nginx --port=80 --target-port=8000

    # Update a single-container pod's image version (tag) to v4
    kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -

    kubectl label pods my-pod new-label=awesome                                       # Add a Label
    kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq                        # Add an annotation
    kubectl autoscale deployment foo --min=2 --max=10 deployment "foo"                # Auto scale a 