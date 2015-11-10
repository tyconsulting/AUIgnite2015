Param(
[Parameter(Mandatory=$true)][PSCredential]$ADCred,
[Parameter(Mandatory=$true)][String]$FirstName,
[Parameter(Mandatory=$true)][String]$LastName,
[Parameter(Mandatory=$false)][String]$Title,
[Parameter(Mandatory=$false)][String]$Description,
[Parameter(Mandatory=$false)][String]$Department,
[Parameter(Mandatory=$false)][String]$Company,
[Parameter(Mandatory=$false)][String]$Location,
[Parameter(Mandatory=$false)][String]$Telephone
)

#region functions
function Generate-UserID
{
	[CmdletBinding()]
	PARAM (
		[Parameter(Mandatory=$true)][String]$FirstName,
		[Parameter(Mandatory=$true)][String]$LastName
	)
	$strID = "$FirstName`.$LastName"
	#The User ID cannot be more than 20 characters long. Need to be shortened if that's the case
	if ($strID.length -gt 20)
	{
		if ($LastName.length -ge 10)
		{
			$LastName = $LastName.substring(0,9)
			$strID = "$FirstName`.$LastName"
		}
		#if the ID is still longer than 20 characters, chop the first name
		#remember leave 1 character for "."
		if ($strID.length -gt 20)
		{
			$FirstName = $FirstName.substring(0,10)
			$strID = "$FirstName`.$LastName"
		}
	}
	$strID
}

function Generate-TempPassowrd
{
    [CmdletBinding()]
	PARAM (
		[Parameter(Mandatory=$true)][int]$Length,
		[Parameter(Mandatory=$true)][int]$NumberOfSpecialCharacters
	)
    Add-Type -Assembly System.Web
    [Web.Security.Membership]::GeneratePassword($length,$NumberOfSpecialCharacters)
}

#endregion

Write-Verbose "retriving automation variables"
$DomainController = Get-AutomationVariable LabDomainController
$UserOU = Get-AutomationVariable LabADUserOU
Write-Verbose "Domain Controller: $DomainController"
Write-Verbose "User OU: '$UserOU'."
#$ADCred = Get-Credential

#Connect to domain using ADSI
$DomainDN = $(([adsisearcher]$DomainController).Searchroot.path)
$Domain = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $DomainDN,$($ADCred.UserName),$($ADCred.GetNetworkCredential().password)
Write-Verbose "Domain DN: '$DomainDN'."
#Get Domain FQDN
$arrDNs = $Domain.distinguishedName.Replace("DC=","").Split(",")
$DomainFQDN = [string]::Join(".", $arrDNs)
Write-Verbose "Domain FQDN: '$DomainFQDN'."

#Create User account
$UserName = Generate-UserID $FirstName $LastName

$ADLocation = $objUser.ADLocation
$searcher = New-Object System.DirectoryServices.DirectorySearcher
$searcher.SearchRoot = $Domain
$searcher.filter = "(&(objectCategory=person)(givenName=$FirstName)(sn=$LastName))"
$searcher.SearchScope = "subTree"
$userResult = $searcher.findOne()

#Check if the user is found in AD
if ($userResult -ne $null)
{
	$user = $userResult.GetDirectoryEntry()
	$sAMAccountName = $user.sAMAccountName

	Write-Error "AD Account creation failed: $FirstName $Surname already in AD, the ID is $sAMAccountName"

} else {
	$UserName = Generate-UserID -FirstName $FirstName -LastName $LastName

	#start creating the user AD account
	Write-Verbose "Creating account for '$FirstName $LastName'. User ID is: '$UserName'."
	$OU = New-Object DirectoryServices.DirectoryEntry("LDAP://$UserOU",$($ADCred.UserName),$($ADCred.GetNetworkCredential().password))
		
	$user = $OU.Create("User", "CN=$UserName")
	$user.SetInfo()
	Write-Verbose "Setting sAMAccountName for '$FirstName $LastName' to $UserName"
	$user.put("sAMAccountName", $UserName)
	$user.SetInfo()
	Write-Verbose "Setting password for '$FirstName $LastName'"
    $TempPassword = Generate-TempPassowrd -Length 8 -NumberOfSpecialCharacters 2
	$user.SetPassword($TempPassword)
    Write-Verbose "Saving User account."
	$user.SetInfo()
	Write-Verbose "Setting additional properties for ID '$UserName'"
    $UPN = "$UserName`@$DomainFQDN"
    Write-Verbose "UPN: '$UPN'."
	$user.put("userprincipalname", $UPN)
	$user.sn = $LastName
	$user.givenName =$FirstName
	$user.displayName = $LastName + ", " + $FirstName
    Write-Verbose "Setting mandatory attributes."
	$user.SetInfo()
    If ($Description) {$user.Description = $Description}
    If ($Title) {$user.title = $Title}
    If ($Location) {$user.l = $Location}
	If ($Company) {$user.company = $Company}
    If ($Department) {$user.department = $Department}
	If ($Telephone) {$user.telephoneNumber = $Telephone}
	Write-Verbose "Updating user ID with additional optional attributes."
	$user.SetInfo()
	$user.pwdLastSet = 0
	$user.userAccountControl = 512
    Write-Verbose "Set 'User must change password at next logon' flag and enable user ID."
	$user.SetInfo()
	if ($Error.Count -eq 0)
	{
		Write-Output "AD account `"$UserName`" is created!"
        Write-Output "Temporary password is `"$TempPassword`". User must change password during the first logon."
	} else {
		Write-Error "AD Account creation failed for ID `"$UserName`"."
	}
}