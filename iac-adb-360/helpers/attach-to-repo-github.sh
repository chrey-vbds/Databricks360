#!/bin/bash

resourcegroupname=$1 #'rg-wus3-adbmidp0912-dev'
echo "rgname : $resourcegroupname as parm 1"
tenantid=$2 #'12ce7121-18c7-4841-98f9-3b26fc8af34f'
echo "tenant : $tenantid as parm 2"
# client-id
clientid=$3 #'a439677f-074f-4dbe-9af3-b9f39fb74ba0'
echo "client id: $clientid as parm 3"
clientsecret=$4 
echo "$clientsecret as parm 4"
repourl=$5
echo "repourl: $repourl as parm 5"
ghuser=$6
echo "ghuser: $ghuser as parm 6"
ghpat=$7
echo "ghpat: $ghpat as parm 7"


# get workspace url and id
workspacestuff=$(az databricks workspace list -g $resourcegroupname --query "[].{url:workspaceUrl, id:id}" -o tsv)
workspaceUrl=$(echo $workspacestuff | cut -d " " -f 1)
workspaceId=$(echo $workspacestuff | cut -d " " -f 2)
echo "$workspaceUrl"
echo "$workspaceId"


# set env variables
export ARM_CLIENT_ID=$clientid
export ARM_CLIENT_SECRET=$clientsecret
export ARM_TENANT_ID=$tenantid
# this is going to add ths sp to the workspace
export DATABRICKS_AZURE_RESOURCE_ID=$workspaceId


# check for git-credentials
creds=$(databricks git-credentials list --output json)
if [ "null" == "$creds" ]
    then
        echo 'no git credentials found, create them'
        databricks git-credentials create --json '{"personal_access_token": "'$ghpat'", "git_username": "'$ghuser'", "git_provider": "gitHub"}' 
    else
        echo "git credentials found, do nothing"
fi

# connect to repo
echo "connecting repo: $repourl"
databricks repos create $repourl 'gitHub'

echo 'finished'