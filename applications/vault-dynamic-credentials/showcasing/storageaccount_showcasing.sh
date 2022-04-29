#!/bin/sh


echo -e "
Before requesting role"

az storage account list --query "[].{resource:resourceGroup, name:name}" -o table

echo -e "


Request role"

TOKEN=$(vault read azure/creds/storage_manager_role -format=json)

export AZURE_CLIENT_ID=$(echo $TOKEN | jq -r ."data" | jq -r ."client_id")
export AZURE_CLIENT_SECRET=$(echo $TOKEN | jq -r ."data" | jq -r ."client_secret")


echo -e "


Request subscription and tenant id"

ADDITIONAL_AZURE_DATA=$(vault kv get -format=json secret/azure_data)


export SUBSCRIPTION_ID=$(echo $ADDITIONAL_AZURE_DATA | jq -r ."data" | jq -r ."data" | jq -r ."subscription_id")
export TENANT_ID=$(echo $ADDITIONAL_AZURE_DATA | jq -r ."data"| jq -r ."data" | jq -r ."tenant_id")




az login \
    --service-principal \
    --username "${AZURE_CLIENT_ID}" \
    --password "${AZURE_CLIENT_SECRET}" \
    --tenant "${TENANT_ID}" -o none

az account set -s "${SUBSCRIPTION_ID}" -o none

az storage account list --query "[].{resource:resourceGroup, name:name}" -o table

az logout