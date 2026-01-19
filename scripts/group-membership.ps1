<#
.SYNOPSIS
Add user to Azure AD groups
#>

Import-Module Microsoft.Graph.Groups
Connect-MgGraph -Scopes "Group.ReadWrite.All"

$UserUPN = "john.doe@company.com"
$GroupName = "IT-Staff"

$User  = Get-MgUser -UserId $UserUPN
$Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

New-MgGroupMember -GroupId $Group.Id -DirectoryObjectId $User.Id

Write-Host "User added to group" -ForegroundColor Green
