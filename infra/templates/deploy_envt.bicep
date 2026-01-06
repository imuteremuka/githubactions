param storageAccountNamePrefix string

param location string = resourceGroup().location

param acr_namePrefix string = 'mygithubacr'


var acr_name = '${toLower(substring(acr_namePrefix, 0, 11))}acr${uniqueString(resourceGroup().id)}'

var stgacc_name = '${toLower(substring(storageAccountNamePrefix, 0, 11))}${uniqueString(resourceGroup().id)}'

resource storage_account 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: stgacc_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}


resource container_registry 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: acr_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}
