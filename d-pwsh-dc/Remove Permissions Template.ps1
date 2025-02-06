# Configure Domain
$domain = "CSXZX"  

# Prompts the user to input the username and shared folder name
$userName = Read-Host "Please enter the target username (username only)"  # Enter only the username
$shareName = Read-Host "Please enter the shared folder name"  # Enter the shared folder name

# Construct the full username
$userName = "$domain\$userName"

# Retrieve the shared folder path
$folderPath = (Get-SmbShare -Name $shareName).Path

# Remove NTFS permissions
$acl = Get-Acl -Path $folderPath
$acl.Access | Where-Object { $_.IdentityReference -eq $userName } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}
Set-Acl -Path $folderPath -AclObject $acl
Write-Host "Successfully removed NTFS permissions for $userName"

# Remove shared permissions
Revoke-SmbShareAccess -Name $shareName -AccountName $userName -Force
Write-Host "Successfully removed shared permissions for $userName"
