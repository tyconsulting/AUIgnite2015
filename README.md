# AUIgnite2015

##Description
This repository contains all the demo runbooks and other related information for the Azure Automation session in Microsoft Ignite Australia 2015.

####Presenter: Pete Zerger & Tao Yang

##Demo
###Demo: AD User Onboarding Request
Folder: Demo AD User Onboarding

Required Modules (in both Azure Automation account and Hybrid Workers):

01. SharePointSDK (http://www.powershellgallery.com/packages/SharePointSDK/)
02. SendEmail (https://www.powershellgallery.com/packages/SendEmail/)

Required Systems:

01. SharePoint (either On-Prem or SharePoint Online)
02. Active Directory
03. Email system (i.e. On-Prem MS Exchange or Office 365)

###Demo: Graphical Runbook Start-AzureV2VM
Folder: Demo Graphical Runbook Start-AzureV2VM

Required Modules:

01. AzureRm.Profile (https://www.powershellgallery.com/packages/AzureRM.profile/)
02. AzureRm.Compute (https://www.powershellgallery.com/packages/AzureRM.Compute/)

###Demo: Add Computer to SCCM Collection
Folder: Demo Add Computer to SCCM Collection

###Demo: Place a SCOM group into maintenance mode
Folder: Demo Place SCOM Group To Maintenance Mode

Required Modules:

01. OpsMgrExtended (http://www.tyconsulting.com.au/portfolio/opsmgrextended-powershell-and-sma-module/)

###Demo: Invoke OMS Saved Searches
Folder: Demo Invoke OMS Saved Searches

Required Modules

01. OMSSearch (https://www.powershellgallery.com/packages/OMSSearch/)

##Other Resources
### Hybrid Worker Registration Sample Commands
Script Name: Hybrid Worker Registration.ps1
Description:
This sampel command demonstrates how to register a directly connected OMS agent as an Azure Automation Hybrid Worker. Before executing the commands in this script, you will firstly need to get the EndPoint URL and access token (Primary or Secondary access key) from your Azure Automation account.