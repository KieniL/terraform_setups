#!/bin/sh

echo -e "
Before requesting role"

aws s3 ls --region eu-central-1

echo -e "


Request role"
TOKEN=$(vault read aws/creds/storage_manager_role -format=json)

export AWS_ACCESS_KEY_ID=$(echo $TOKEN | jq -r ."data" | jq -r ."access_key")
export AWS_SECRET_ACCESS_KEY=$(echo $TOKEN | jq -r ."data" | jq -r ."secret_key")

# Wait for AWS to sync the credentials
sleep 10

aws s3 ls --region eu-central-1