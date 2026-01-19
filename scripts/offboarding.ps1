<#
.SYNOPSIS
Automates Microsoft 365 user offboarding.
#>

Import-Module Microsoft.Graph.Users
Import-Module ExchangeOnlineManagement

Connect-MgGraph -Scopes "User.ReadWrite.All"
Connect-ExchangeOnline

$UserPrincipalName = "john.doe@company.com"

# Block sign-in
Update-MgUser -UserId $UserPrincipalName -AccountEnabled:$false

# Convert mailbox to shared
Set-Mailbox $UserPrincipalName -Type Shared

# Remove licenses
$Licenses = (Get-MgUserLicenseDetail -UserId $UserPrincipalName).SkuId
Set-MgUserLicense -UserId $UserPrincipalName -RemoveLicenses $Licenses -AddLicenses @()

Write-Host "User offboarded successfully" -ForegroundColor Yellow
