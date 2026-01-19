<#
.SYNOPSIS
Automates Microsoft 365 user onboarding.

.DESCRIPTION
- Creates Azure AD user
- Assigns M365 license
- Adds user to security & M365 groups
- Enables Exchange Online mailbox

.REQUIREMENTS
- Microsoft.Graph
- ExchangeOnlineManagement
#>

Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups
Import-Module ExchangeOnlineManagement

# Connect to services
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"
Connect-ExchangeOnline

# User details
$UserPrincipalName = "john.doe@company.com"
$DisplayName       = "John Doe"
$FirstName         = "John"
$LastName          = "Doe"
$JobTitle          = "IT Support Officer"
$Department        = "IT"
$UsageLocation     = "KE"
$PasswordProfile   = @{
    Password = "TempP@ssw0rd123"
    ForceChangePasswordNextSignIn = $true
}

# Create user
$user = New-MgUser `
    -AccountEnabled `
    -DisplayName $DisplayName `
    -MailNickname "johndoe" `
    -UserPrincipalName $UserPrincipalName `
    -GivenName $FirstName `
    -Surname $LastName `
    -JobTitle $JobTitle `
    -Department $Department `
    -UsageLocation $UsageLocation `
    -PasswordProfile $PasswordProfile

Write-Host "User created successfully: $UserPrincipalName" -ForegroundColor Green

# Assign license
$LicenseSku = Get-MgSubscribedSku | Where-Object {$_.SkuPartNumber -eq "BUSINESS_STANDARD"}

Set-MgUserLicense `
    -UserId $user.Id `
    -AddLicenses @{SkuId = $LicenseSku.SkuId} `
    -RemoveLicenses @()

Write-Host "License assigned" -ForegroundColor Green

# Add to groups
$Groups = @(
    "IT-Staff",
    "All-Employees"
)

foreach ($GroupName in $Groups) {
    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'"
    New-MgGroupMember -GroupId $Group.Id -DirectoryObjectId $user.Id
    Write-Host "Added to group: $GroupName"
}

# Enable mailbox
Enable-Mailbox -Identity $UserPrincipalName

Write-Host "Mailbox enabled" -ForegroundColor Green
