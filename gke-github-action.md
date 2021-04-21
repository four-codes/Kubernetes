Creating a GKE cluster

  To create the GKE cluster, you will first need to authenticate using the gcloud CLI. For more information on this step, see the following articles:

------------

    1. gcloud auth login
    2. gcloud CLI
    3. gcloud CLI and Cloud SDK
  
------------


create the gke cluster

    $ GKE_PROJECT=xxxx
    $ GKE_ZONE=xxxx
    $ gcloud container clusters create $GKE_CLUSTER --project=$GKE_PROJECT --zone=$GKE_ZONE
    
    
