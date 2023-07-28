# Login to Azure using Service Principal credentials from Github Secrets
Write-Output "Logging in to Azure with a service principal..."
az login `
    --service-principal `
    --username $Env:SERVICE_PRINCIPAL_APPID `
    --password $Env:SERVICE_PRINCIPAL_SECRET `
    --tenant $Env:SERVICE_PRINCIPAL_TENANTID
Write-Output "Done"

# Select Azure subscription
az account set `
    --subscription $Env:AZURE_SUBSCRIPTION_NAME

# Create the VM configuration object
$ResourceGroupName = "my-resource-group"
$VmName = "Demo-vm-from-gh"

# Create a VM in Azure
Write-Output "Creating VM..."
try {
    az vm create  `
        --resource-group $ResourceGroupName `
        --name $VmName `
        --image win2016datacenter `
        --admin-password $Env:SP_CLIENT_SECRET `
    }
catch {
    Write-Output "VM already exists"
    }
Write-Output "Done creating VM"
