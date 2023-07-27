Connect-AzAccount
$DeploymentID = 'DID'
$rgname = 'host-'+$DeploymentID

New-AzResourceGroup -Name $rgname -Location "eastus"

New-AzResourceGroupDeployment -ResourceGroupName $rgname -TemplateFile .\main.bicep -TemplateParameterFile .\parameters.json