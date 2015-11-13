#region variables
$HybridWorkerGroup = "HomeLab"

#Note: This is not a real endpoint URL and token for my Azure Automation account
$EndPointUrl = "https://eus2-agentservice-prod-1.azure-automation.net/accounts/b74bb20b-db11-47e4-a789-2a09bc32e3ed"
$Token = "bpjPc0ZZ46dR01hR30qxZNfEY0UqaEoLAdpF2utcQKXfoIjpaatettPdIZqasrgwrFNslR9dGKsjTkFF79Kq2g=="
#endregion

#Import HybridRegistration Module
Import-Module "C:\Program Files\Microsoft Monitoring Agent\Agent\AzureAutomation\7.2.7037.0\HybridRegistration\HybridRegistration.psd1"

#Perform Registration
Add-HybridRunbookWorker -Name $HybridWorkerGroup -EndPoint $EndPointUrl -Token $Token