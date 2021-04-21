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
    
    
Enabling the APIs
  
    Enable the Kubernetes Engine and Container Registry APIs. For example:
    
    $ gcloud services enable containerregistry.googleapis.com
    $ gcloud services enable container.googleapis.com

Create a new service account:

    $ gcloud iam service-accounts create $SA_NAME
    
Retrieve the email address of the service account you just created:

    $ gcloud iam service-accounts list

Add roles to the service account. Note: Apply more restrictive roles to suit your requirements.

    $ gcloud projects add-iam-policy-binding $GKE_PROJECT --member=serviceAccount:$SA_EMAIL --role=roles/container.admin --role=roles/storage.admin
    
Download the JSON keyfile for the service account:

    $ gcloud iam service-accounts keys create key.json --iam-account=$SA_EMAIL
    
Store the project ID as a secret named GKE_PROJECT:

    $ export GKE_SA_KEY=$(cat key.json | base64)
    $ echo $GKE_SA_KEY (cpoy it)

Configuring a service account and storing its credentials

-------
      This procedure demonstrates how to create the service account for your GKE integration. 
      It explains how to create the account, add roles to it, retrieve its keys, and store them as a base64-encoded encrypted
      repository secret named GKE_SA_KEY 
      
      https://docs.github.com/en/actions/reference/encrypted-secrets
-------
