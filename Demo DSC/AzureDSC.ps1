
# Import PowerShell module and authenticate to sub

Import-Module AzureRM.Profile
Import-Module AzureRM.Automation

Add-AzureRmAccount

#Step 1: Setting up the pull server and automation account

#Add an authenticated (Add-AzureAccount) PowerShell command line: (can take a few minutes while the pull server is set up)

New-AzureRmResourceGroup –Name "MyIgniteAURG" –Location "South Central US"

New-AzureRmAutomationAccount –ResourceGroupName "MyIgniteAURG" -Name "MyIgniteAUAutoAcct" –Location "South Central US" 

# Step 2: Pull the Dsc module(s) from the PowerShell Gallery
Install-Module -Name xWebAdministration

# Step 3: Zip and upload to a publicly accessible URL (like Azure blob storage)
# Make the module available in a public place (like an Azure blob)
# How-to at https://azure.microsoft.com/en-us/documentation/articles/storage-use-azcopy/

    CD C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy
    AzCopy /Source:C:\Temp\xWebAdmin\ /Dest:https://mmsdemorg8421.blob.core.windows.net/vhds /DestKey:1O0FF1HeUOvqjr4uf4NlkjsdfZHZ1K3lcEqcO34m2ocsjb3EKW/rPkQC/2oWnd5YJIC6ZIFcCTLf1A== /Pattern *.zip

# Step 4: register the module 
New-AzureRmAutomationModule -ResourceGroupName "MyIgniteAURG" -AutomationAccountName "MyIgniteAUAutoAcct" `
    -Name 'xWebAdministration' –ContentLink "https://mmsdemorg7420.blob.core.windows.net/vhds/xWebAdministration.zip"

