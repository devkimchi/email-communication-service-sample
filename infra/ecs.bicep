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
param senderUsername string
param senderDisplayName string

var emailCommunicationService = {
  name: 'ecs-${name}'
  location: location
  tags: tags
  dataLocation: dataLocation
  domain: {
    name: domainName
    sender: {
      username: senderUsername
      displayName: senderDisplayName
    }
  }
}

resource ecs 'Microsoft.Communication/emailServices@2023-06-01-preview' = {
  name: emailCommunicationService.name
  location: emailCommunicationService.location
  tags: emailCommunicationService.tags
  properties: {
    dataLocation: emailCommunicationService.dataLocation
  }
}

resource ecsAzureDomain 'Microsoft.Communication/emailServices/domains@2023-06-01-preview' = {
  name: 'AzureManagedDomain'
  parent: ecs
  location: emailCommunicationService.location
  tags: emailCommunicationService.tags
  properties: {
    domainManagement: 'AzureManaged'
    userEngagementTracking: 'Disabled'
  }
}

resource ecsAzureDomainEmail 'Microsoft.Communication/emailServices/domains/senderUsernames@2023-06-01-preview' = {
  name: emailCommunicationService.domain.sender.username
  parent: ecsAzureDomain
  properties: {
    username: emailCommunicationService.domain.sender.username
    displayName: emailCommunicationService.domain.sender.displayName
  }
}

resource ecsCustomDomain 'Microsoft.Communication/emailServices/domains@2023-06-01-preview' = if (emailCommunicationService.domain.name != null && emailCommunicationService.domain.name != '') {
  name: (emailCommunicationService.domain.name == null || emailCommunicationService.domain.name == '') ? 'dummy' : emailCommunicationService.domain.name
  parent: ecs
  location: emailCommunicationService.location
  tags: emailCommunicationService.tags
  properties: {
    domainManagement: 'CustomerManaged'
    userEngagementTracking: 'Disabled'
  }
}

resource ecsCustomDomainEmail 'Microsoft.Communication/emailServices/domains/senderUsernames@2023-06-01-preview' = if (emailCommunicationService.domain.name != null && emailCommunicationService.domain.name != '') {
  name: emailCommunicationService.domain.sender.username
  parent: ecsCustomDomain
  properties: {
    username: emailCommunicationService.domain.sender.username
    displayName: emailCommunicationService.domain.sender.displayName
  }
}
  
output id string = ecs.id
output customDomainName string = (ecsCustomDomain.name == null || ecsCustomDomain.name == '') ? '' : ecsCustomDomain.name
output customSenderEmail string = (ecsCustomDomain.name == null || ecsCustomDomain.name == '') ? '' : '${ecsCustomDomainEmail.name}@${ecsCustomDomain.name}'
