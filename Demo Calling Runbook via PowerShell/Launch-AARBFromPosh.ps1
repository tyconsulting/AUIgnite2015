#######################################################################################################
#
# Launch an Azure Automation Runbook from PowerShell
#
# Use with the "Hello World" sample from MS Ignite AU session with @MrTaoYang and @pzerger
#
#######################################################################################################

# Import Azure Modules
Import-Module AzureRM.Profile
Import-Module AzureRM.Automation


# Select Subscription 
Select-AzureRmSubscription -SubscriptionId '0b62f50c-c15a-40e2-b1ab-7ac2596a1d74'

# Authenticate with Azure AD credentials
$cred = Get-Credential
Add-AzureAccount -Credential $cred

Login-AzureRmAccount -Credential $cred

$params = @{"Message"="Hello MMS!";}

Start-AzureRmAutomationRunbook –AutomationAccountName "contoso-testrba" –Name "Hello-World" -ResourceGroupName 'Default-Networking'  –Parameters $params -RunOn 'ConfigMgrPool' 
