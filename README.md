# AUIgnite2015

##Description
This repository contains all the demo runbooks and other related information for the Azure Automation session (ARC311) in Microsoft Ignite Australia 2015.

####Presenters: Pete Zerger & Tao Yang

##Demo
###Demo: AD User Onboarding Request
Folder: Demo AD User Onboarding

Required Modules (in both Azure Automation account and Hybrid Workers)
1. SharePointSDK (http://www.powershellgallery.com/packages/SharePointSDK/)
2. SendEmail (https://www.powershellgallery.com/packages/SendEmail/)

Required Systems:

1. SharePoint (either On-Prem or SharePoint Online)
2. Active Directory
3. Email system (i.e. On-Prem MS Exchange or Office 365)

###Demo: Graphical Runbook Start-AzureV2VM
Folder: Demo Graphical Runbook Start-AzureV2VM

Required Modules:

1. AzureRm.Profile (https://www.powershellgallery.com/packages/AzureRM.profile/)
2. AzureRm.Compute (https://www.powershellgallery.com/packages/AzureRM.Compute/)

###Demo: Add Computer to SCCM Collection
Folder: Demo Add Computer to SCCM Collection

###Demo: Place a SCOM group into maintenance mode
Folder: Demo Place SCOM Group To Maintenance Mode

Required Modules:

1. OpsMgrExtended (http://www.tyconsulting.com.au/portfolio/opsmgrextended-powershell-and-sma-module/)

###Demo: Invoke OMS Saved Searches
Folder: Demo Invoke OMS Saved Searches

Required Modules:

1. OMSSearch (https://www.powershellgallery.com/packages/OMSSearch/)

##Other Resources
### Hybrid Worker Registration Sample Commands
####Script Name: Hybrid Worker Registration.ps1
####Description:
This sampel command demonstrates how to register a directly connected OMS agent as an Azure Automation Hybrid Worker. Before executing the commands in this script, you will firstly need to get the EndPoint URL and access token (Primary or Secondary access key) from your Azure Automation account.

###Demo: Launch Azure Automation Runbook via PowerSehll:
Folder: Demo Calling Runbook via PowerShell

Required Modules:

1. AzureRm.Profile (https://www.powershellgallery.com/packages/AzureRM.profile/)
2. AzureRm.Automation (https://www.powershellgallery.com/packages/AzureRM.Automation/)

###Demo: Azure DSC
Folder: Demo DSC

Required Modules:

1. AzureRm.Profile (https://www.powershellgallery.com/packages/AzureRM.profile/)
2. AzureRm.Automation (https://www.powershellgallery.com/packages/AzureRM.Automation/)
