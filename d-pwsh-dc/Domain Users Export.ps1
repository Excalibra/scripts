# Export file path
$outputFile = "C:\Users\Administrator\Desktop\DomainUsersList.txt"

# Clear or create the export file
Out-File -FilePath $outputFile # -Encoding UTF8 -Force

# Import Active Directory module
Import-Module ActiveDirectory

# Set DistinguishedName for organizational units
$ous = @(
    "OU=Production Team,DC=CSXZX,DC=com",
    "OU=Training,DC=CSXZX,DC=com",
    "OU=Temporary Permissions,DC=CSXZX,DC=com"
)

foreach ($ou in $ous) {
    # Get all users in the organizational unit
    $users = Get-ADUser -Filter * -SearchBase $ou -Properties Name

    # Write user names to the file
    if ($users) {
        $ouName = (Get-ADOrganizationalUnit -Identity $ou).Name  # Get OU name
        Add-Content -Path $outputFile -Value "Organizational Unit: $ouName"
        foreach ($user in $users) {
            Add-Content -Path $outputFile -Value $user.Name  # Keep only user names
        }
        Add-Content -Path $outputFile -Value "`r`n"  # Add line separator
    } else {
        Write-Host "No users found in the organizational unit $ouName."
    }
}

Write-Host "All user names from specified organizational units have been exported to $outputFile"

# Pause for 5 seconds
Start-Sleep -Seconds 5
