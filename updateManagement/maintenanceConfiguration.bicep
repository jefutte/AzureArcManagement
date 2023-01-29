@description('Name of maintenance configuration, for example: \'Windows-Critical-and-Security-Ring-1\'')
param maintenanceConfigurationName string = 'Windows-Critical-and-Security-Ring-2'

@description('Location')
param location string = resourceGroup().location

@description('Scope of maintenance')
@allowed([
  'Extension'
  'Host'
  'InGuestPatch'
  'OSImage'
  'Resource'
  'SQLDB'
  'SQLManagedInstance'
])
param maintenanceScope string = 'InGuestPatch'

@description('Start date and time for maintenance, in format: 2023-01-27 22:00')
param startDateTime string = '2023-05-28 22:00'

@description('Expiration date and time for maintenance, in format: 2023-01-27 22:00')
param expirationDateTime string

@description('Duration in hours and minutes, format \'03:55\' - maximum 3 hours 59 minutes')
param duration string = '03:55'

@description('Select the classifications to include in update management')
param windowsClassifications array = [
  'Critical'
  'Security'
  'UpdateRollup'
  'Definition'
]

@description('Reboot after update')
@allowed([
  'Always'
  'IfRequired'
  'Never'
])
param rebootSetting string = 'IfRequired'

@description('Maintenance recurrence, for example every month, 3 days after the 2nd Tuesday: \'1Month Second Tuesday Offset3\'')
param recurEvery string = '1Month Third Tuesday Offset3'

resource maintenanceConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2022-07-01-preview' = {
  name: maintenanceConfigurationName
  location: location
  tags: {
  }
  properties: {
    namespace: null
    extensionProperties: {
      InGuestPatchMode: 'User'
    }
    installPatches: {
      linuxParameters: {
      }
      windowsParameters: {
        classificationsToInclude: windowsClassifications
      }
      rebootSetting: rebootSetting
      tasks: {
      }
    }
    maintenanceScope: maintenanceScope
    maintenanceWindow: {
      startDateTime: startDateTime
      expirationDateTime: expirationDateTime
      duration: duration
      timeZone: 'Romance Standard Time'
      recurEvery: recurEvery
    }
    visibility: 'Custom'
  }
  dependsOn: []
}
