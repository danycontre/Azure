param KeyVaultName string
param Location string
param ManagedIdentityResourceId string
param NamingStandard string
@secure()
param SasToken string
param ScriptsUri string
param Timestamp string

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2019-10-01-preview' = {
  name: 'ds-${NamingStandard}-bitlockerKek'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${ManagedIdentityResourceId}': {}
    }
  }
  location: Location
  kind: 'AzurePowerShell'
  tags: {}
  properties: {
    azPowerShellVersion: '5.4'
    cleanupPreference: 'OnSuccess'
    primaryScriptUri: '${ScriptsUri}New-AzureKeyEncryptionKey.ps1${SasToken}'
    arguments: ' -KeyVault ${KeyVaultName}'
    forceUpdateTag: Timestamp
    retentionInterval: 'P1D'
    timeout: 'PT30M'
  }
}
