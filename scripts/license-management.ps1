<#
.SYNOPSIS
Manage Microsoft 365 licenses
#>

Import-Module Microsoft.Graph.Users
Connect-MgGraph -Scopes "User.ReadWrite.All"

$UserPrincipalName = "john.doe@company.com"
$SkuName = "BUSINESS_STANDARD"

$Sku = Get-MgSubscribedSku | Where-Object {$_.SkuPartNumber -eq $SkuName}

Set-MgUserLicense `
    -UserId $UserPrincipalName `
    -AddLicenses @{SkuId = $Sku.SkuId} `
    -RemoveLicenses @()

Write-Host "License updated" -ForegroundColor Green
