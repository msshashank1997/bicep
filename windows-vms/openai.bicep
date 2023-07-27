param DID string = '11290'
param cap int = 5

var ainame = 'openai-${DID}'

resource CognitiveServices 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: ainame
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: ainame
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource gpt35 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: CognitiveServices
  name: 'gptmodel'
  sku: {
    name: 'Standard'
    capacity: cap
  }
  properties: {
    model: {
      format: 'OpenAI'
      source: 'gpt-35-turbo'
      version: '0301'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    raiPolicyName: 'Microsoft.Default'
  }
}

resource ada002 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: CognitiveServices
  name: 'ada002'
  sku: {
    name: 'Standard'
    capacity: cap
  }
  properties: {
    model: {
      format: 'OpenAI'
      source: 'text-embedding-ada-002'
      version: '1'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    raiPolicyName: 'Microsoft.Default'
  }
}
