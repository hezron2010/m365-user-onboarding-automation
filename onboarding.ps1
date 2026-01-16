# Sample script to onboard new users in Microsoft 365
# NOTE: Do not run in production without proper credentials and testing

Import-Module AzureAD

# CSV file with new employees
$users = Import-Csv ".\new-employees.csv"

foreach ($user in $users) {
    # Create user
    New-AzureADUser -DisplayName $user.Name -UserPrincipalName $user.Email -AccountEnabled $true -PasswordProfile @{Password=$user.Password; ForceChangePasswordNextSignIn=$true}
    
    # Assign license (example)
    # Set-MsolUserLicense -UserPrincipalName $user.Email -AddLicenses "M365_BUSINESS_BASIC"

    # Add to Teams / SharePoint groups (pseudo-code)
    # Add-TeamUser -GroupId <groupId> -User $user.Email
    # Add-SPOUser -Site <siteURL> -LoginName $user.Email
}
