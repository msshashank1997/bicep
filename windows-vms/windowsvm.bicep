param vmName string
param location string
param adminUsername string
@secure()
param adminPassword string
param virtualMachineSize string
param networkInterfaceid string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: vmName
  location: location
  properties: {
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${vmName}-osdisk'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
      dataDisks:[
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceid
        }
      ]
    }
  }
}

resource windowsVMExtensions 'Microsoft.Compute/virtualMachines/extensions@2022-11-01' = {
  name: vmName
  location: location
  parent: virtualMachine
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings:{
      fileUris:[
        'https://raw.githubusercontent.com/msshashank1997/Powershell/main/psscript.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File psscript.ps1'
    }  
  }
}
