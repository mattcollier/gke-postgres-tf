export USER_EMAIL=your.email@example.com
gcloud projects add-iam-policy-binding gke-postgres-collier --member="${USER_EMAIL}" --role=roles/container.admin
gcloud projects add-iam-policy-binding gke-postgres-collier --member="${USER_EMAIL}" --role=roles/compute.networkAdmin
gcloud projects add-iam-policy-binding gke-postgres-collier --member="${USER_EMAIL}" --role=roles/iam.serviceAccountUser