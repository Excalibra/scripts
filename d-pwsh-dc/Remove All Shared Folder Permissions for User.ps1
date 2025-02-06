# Configure Domain
$domain = "CSXZX"
$userName = Read-Host "Please enter the target username (username)"  # Enter username
$excludeShares = Read-Host "Please enter the shared folders to exclude (separated by commas or Chinese顿号, leave blank to remove all shared folders by default)"

# Default excluded shared folders
$defaultExcludeShares = @("ADMIN$", "C$", "IPC$", "NETLOGON", "SYSVOL")

# Construct the full username
$userName = "$domain\$userName"

# Get all shared folders
$shares = Get-SmbShare

# Filter out the shared folders to exclude
if ($excludeShares) {
    $excludeSharesList = ($excludeShares -replace "、", ",").Split(",")
    $excludeSharesList += $defaultExcludeShares  # Merge default excluded shared folders
    $shares = $shares | Where-Object { $excludeSharesList -notcontains $_.Name }
} else {
    # If no shared folders are specified for exclusion, use the default exclusion list
    $shares = $shares | Where-Object { $defaultExcludeShares -notcontains $_.Name }
}

# Iterate through all shared folders and remove user permissions
foreach ($share in $shares) {
    # Check if the user has shared folder permissions
    $access = Get-SmbShareAccess -Name $share.Name | Where-Object { $_.AccountName -eq $userName }
    if ($access) {
        # Remove shared folder permissions
        Revoke-SmbShareAccess -Name $share.Name -AccountName $userName -Force
        Write-Host -ForegroundColor Green "Removed $userName's shared folder permissions for '$($share.Name)'"
    } else {
        Write-Host "$userName does not have shared folder permissions for '$($share.Name)', no action required"
    }

    # Get the folder path and remove NTFS permissions
    $folderPath = $share.Path
    $acl = Get-Acl -Path $folderPath
    $userAccess = $acl.Access | Where-Object { $_.IdentityReference -eq $userName }
    
    if ($userAccess) {
        # Remove the user's NTFS permissions
        $userAccess | ForEach-Object {
            $acl.RemoveAccessRule($_)
        }
        Set-Acl -Path $folderPath -AclObject $acl
        Write-Host -ForegroundColor Green "Removed $userName's NTFS permissions for '$folderPath'"
    } else {
        Write-Host "$userName does not have NTFS permissions for '$folderPath', no action required"
    }
}

Write-Host "Permission removal completed"
