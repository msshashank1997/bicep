param networkSecurityGroupName string
param location string

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: networkSecurityGroupName
  location:location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 110
          protocol: 'TCP'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
        }
      }
    ]
  }
}


output nsfid string = networkSecurityGroup.id
