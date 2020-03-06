gcloud services enable compute.googleapis.com
gcloud services enable cloudbuild.googleapis.com
export PROJECT=$(gcloud info --format='value(config.project)')
export MEMBER=$(gcloud projects describe $PROJECT --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/compute.admin'
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/iam.serviceAccountUser'

# @TODO: insert a check or retry here, the permissions may not have propagated yet and can cause this to fail
# as workaround for now just re-run the script after ~2 minutes.
gcloud builds submit --config=builder/cloudbuild.yaml builder/ --verbosity debug

