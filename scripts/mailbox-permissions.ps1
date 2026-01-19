<#
.SYNOPSIS
Assign mailbox permissions
#>

Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

$Mailbox = "shared@company.com"
$User    = "john.doe@company.com"

Add-MailboxPermission `
    -Identity $Mailbox `
    -User $User `
    -AccessRights FullAccess `
    -InheritanceType All

Write-Host "Mailbox permission granted" -ForegroundColor Green
