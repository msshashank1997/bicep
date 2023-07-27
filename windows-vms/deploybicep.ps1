$DeploymentID = 'DID'
$rgname = 'host-'+$DeploymentID

#region Login
# This logs into Azure with a Service Principal Account
#
Write-Output "Logging in to Azure with a service principal..."
az login `
    --service-principal `
    --username $servicePrincipal `
    --password $servicePrincipalSecret `
    --tenant $servicePrincipalTenantId
Write-Output "Done"
Write-Output ""
#endregion

#region Subscription
#This sets the subscription the resources will be created in
Write-Output "Setting default azure subscription..."
az account set `
    --subscription $azureSubscriptionName
Write-Output "Done"
Write-Output ""
#endregion

New-AzResourceGroup -Name $rgname -Location "eastus"

New-AzResourceGroupDeployment -ResourceGroupName $rgname -TemplateFile .\main.bicep -TemplateParameterFile .\parameters.json
