targetScope = 'subscription'

param name string
param location string

// The data location where the resources should be deployed.
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
param senderUsername string
param senderDisplayName string

// tags that should be applied to all resources.
var tags = {
  // Tag all resources with the environment name.
  'azd-env-name': name
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${name}'
  location: location
  tags: tags
}

module ecs './ecs.bicep' = {
  name: 'EmailCommunicationService'
  scope: rg
  params: {
    name: name
    location: 'global'
    tags: tags
    dataLocation: dataLocation
    domainName: domainName
    senderUsername: senderUsername
    senderDisplayName: senderDisplayName
  }
}

module acs './acs.bicep' = {
  name: 'AzureCommunicationService'
  scope: rg
  dependsOn: [
    ecs
  ]
  params: {
    name: name
    location: 'global'
    tags: tags
    dataLocation: dataLocation
    domainName: domainName
  }
}

output customDomainName string = ecs.outputs.customDomainName
output customSenderEmail string = ecs.outputs.customSenderEmail
output endpoint string = acs.outputs.endpoint
output accessKey string = acs.outputs.accessKey
output connectionString string = acs.outputs.connectionString
