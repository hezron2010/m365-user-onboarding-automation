<#
.SYNOPSIS
Disable a Microsoft 365 user account
#>

Import-Module Microsoft.Graph.Users
Connect-MgGraph -Scopes "User.ReadWrite.All"

$UserPrincipalName = "john.doe@company.com"

Update-MgUser -UserId $UserPrincipalName -AccountEnabled:$false

Write-Host "User account disabled" -ForegroundColor Red
