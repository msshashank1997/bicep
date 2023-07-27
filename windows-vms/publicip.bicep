param publicIpAddressName string
param location string
param publicIpAddressDNSName string

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: publicIpAddressName
  location: location
  sku:{
    name:'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: publicIpAddressDNSName
    }
  }
}

output dns string = publicIPAddress.properties.dnsSettings.fqdn
output publicaddressid string = publicIPAddress.id
