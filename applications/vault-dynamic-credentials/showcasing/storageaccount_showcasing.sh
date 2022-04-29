#!/bin/sh

echo -e "
Before requesting role"

az storage account list --query "[].{resource:resourceGroup, name:name}" -o table

echo -e "


Request role"

TOKEN=$(vault read azure/creds/storage_manager_role -format=json)

export AWS_ACCESS_KEY_ID=$(echo $TOKEN | jq -r ."data" | jq -r ."access_key")
export AWS_SECRET_ACCESS_KEY=$(echo $TOKEN | jq -r ."data" | jq -r ."secret_key")

aws s3 ls --region eu-central-1

