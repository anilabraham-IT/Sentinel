#!/bin/bash

# <--- Change the following environment variables according to your Azure service principal name --->

echo "Exporting environment variables"
export subscriptionId='c18c0c92-fd76-46b2-8e03-3545239fabcb'
export appId='7657e386-748f-4429-a107-5b1b4bfad951'
export password='hqj8Q~P2EcQ_YuG35Jsy-kqNOf-2zmNx0JcQNc33'
export tenantId='94f7a4f9-2200-4052-b635-075069abe5d9'
export resourceGroup='AzureARCServers'
export location='uksouth'

# Determine Package Manager

if INST="$( which apt-get )" > /dev/null 2>&1; then
   sudo apt-get update
elif INST="$( which yum )" > /dev/null 2>&1; then
   sudo yum -y update
elif INST="$( which zypper )" > /dev/null 2>&1; then
   sudo zypper ref
   sudo zypper update -y
else
   echo "No package manager found, check Azure Arc enabled servers supported OS" >&2
   exit 1
fi

# Download the installation package
wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh

# Run connect command
sudo azcmagent connect \
  --service-principal-id "${appId}" \
  --service-principal-secret "${password}" \
  --resource-group "${resourceGroup}" \
  --tenant-id "${tenantId}" \
  --location "${location}" \
  --subscription-id "${subscriptionId}" \
  --correlation-id "d009f5dd-dba8-4ac7-bac9-b54ef3a6671a"