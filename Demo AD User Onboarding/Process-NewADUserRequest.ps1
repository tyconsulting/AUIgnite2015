param ([object]$WebHookData)

#region variables
$AzureCredName = "AzureAutomationAccount"
$SubscriptionName = "Tao Yang Visual Studio Ultimate with MSDN"
$AutomationAccountName = "TaoYang"
$HybridWorkerGroupName = "TYANG-HybridWorker01"
$ADCredentialName = "LabADAutomationAccount"
Write-Verbose "Azure Credential Name: '$AzureCredName'"
Write-Verbose "Azure Subscription Name: '$SubscriptionName'"
Write-Verbose "Azure Automation Account Name: '$AutomationAccountName'"
Write-Verbose "Hybrid Worker Group Name: '$HybridWorkerGroupName'"
Write-Verbose "Active Directory Credential Name: '$ADCredentialName'"
#endregion

#Process inputs from webhook data
Write-Verbose "Processing inputs from webhook data."
$WebhookName    =   $WebhookData.WebhookName
Write-Verbose "Webhook name: '$WebhookName'"
$WebhookHeaders =   $WebhookData.RequestHeader
$WebhookBody    =   $WebhookData.RequestBody
Write-Verbose "Webhook body:"
Write-Verbose $WebhookBody
$Inputs = ConvertFrom-JSON $webhookdata.RequestBody
	
$FirstName = $Inputs.FirstName
$LastName = $Inputs.LastName
$Title = $Inputs.Title
$Description = $Inputs.Description
$Department = $Inputs.Department
$Company = $Inputs.Company
$Location = $Inputs.Location
$Telephone = $Inputs.Telephone
$RequesterEmail = $Inputs.RequesterEmail
$ListItemID = $Inputs.ListItemID
Write-Verbose "First Name: '$FirstName'"
Write-Verbose "Last Name: '$LastName'"
Write-Verbose "Job Title: '$Title'"
Write-Verbose "Description: '$Description'"
Write-Verbose "Department: '$Department'"
Write-Verbose "Company: '$Company'"
Write-Verbose "Location: '$Location'"
Write-Verbose "Telephone: '$Telephone'"
Write-Verbose "Requester's Email: '$RequesterEmail'"
Write-Verbose "List Item ID: '$ListItemID'"

#Setup parameters for Create-ADUser runbook
Write-Verbose "Setup parameters for Create-ADUser runbook"
$params = @{
    "ADCred" = $ADCredentialName;
    "FirstName" = $FirstName;
	"LastName" = $LastName;
	"Title" = $Title;
	"Description" = $Description;
	"Department" = $Department;
	"Company" = $Company;
	"Location" = $Location
	"Telephone" = $Telephone;
	"RequesterEmail" = $RequesterEmail;
	"ListItemID" = $ListItemID
	}

#Connecting to Azure Subscription
Write-Verbose "Connecting to Azure subscription $SubscriptionName"
$Cred = Get-AutomationPSCredential -Name $AzureCredName
Add-AzureAccount -Credential $Cred 
Select-AzureSubscription -SubscriptionName $SubscriptionName

#Starting Azure Automation runbook New-ADUser
Write-Verbose "Starting Azure Automation runbook Create-ADUser"
Start-AzureAutomationRunbook -AutomationAccountName $AutomationAccountName -Name "Create-ADUser" -Parameters $params -RunOn $HybridWorkerGroupName