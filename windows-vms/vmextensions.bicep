param vmName string
param location string

resource windowsVMExtensions 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${vmName}/CustomScriptExtension'
  location: location
  //parent: virtualMachine
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings:{
      fileUri:[
        'https://raw.githubusercontent.com/msshashank1997/Powershell/main/psscript.ps1'
      ]
      commandToExecute: 'powershell -ExecutionPolicy Bypass -file Powershell/main/psscript.ps1'
    }
  }
}
