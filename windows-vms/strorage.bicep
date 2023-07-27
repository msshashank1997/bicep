param location string

@maxLength(12)
param storageaccountname string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageaccountname
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  } 
}
