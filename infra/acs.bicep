param name string
param location string = 'global'

param tags object = {
  'azd-env-name': name
}

@allowed([
  'Africa'
  'Asia Pacific'
  'Australia'
  'Brazil'
  'Canada'
  'Europe'
  'France'
  'Germany'
  'India'
  'Japan'
  'Korea'
  'Norway'
  'Switzerland'
  'United Arab Emirates'
  'United Kingdom'
  'United States'
])
param dataLocation string

param domainName string

var azureCommunicationService = {
  name: 'acs-${name}'
  location: location
  tags: tags
  dataLocation: dataLocation
  domainName: domainName
}

resource acs 'Microsoft.Communication/CommunicationServices@2023-06-01-preview' = {
  name: azureCommunicationService.name
  location: azureCommunicationService.location
  tags: azureCommunicationService.tags
  properties: {
    dataLocation: azureCommunicationService.dataLocation
  }
}

output id string = acs.id
output endpoint string = 'https://${acs.properties.hostName}/'
output accessKey string = listKeys(acs.id, '2023-06-01-preview').primaryKey
output connectionString string = 'endpoint=https://${acs.properties.hostName}/;accesskey=${listKeys(acs.id, '2023-06-01-preview').primaryKey}'
