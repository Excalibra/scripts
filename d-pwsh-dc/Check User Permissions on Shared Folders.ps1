# Configure Domain
$domain = "CSXZX"
$userName = Read-Host "Enter the target username (username)"  # Input username
$userName = "$domain\$userName"  # Create full username

# Get User's Shared Permissions
Write-Host "Checking shared permissions for $userName:"
Get-SmbShare | ForEach-Object {
    $shareName = $_.Name
    $access = Get-SmbShareAccess -Name $shareName | Where-Object { $_.AccountName -eq $userName }
    if ($access) {
        $access | ForEach-Object {
            Write-Host "$userName has the following permissions in shared folder '$shareName': $($_.AccessControlType) $($_.AccessRight)"
        }
    }
}

# Get User's NTFS Permissions
Write-Host "`nChecking NTFS permissions for $userName:"
Get-SmbShare | ForEach-Object {
    $folderPath = $_.Path
    if ($folderPath -and (Test-Path $folderPath)) {  # Check if the path is not empty and exists
        $acl = Get-Acl -Path $folderPath
        $userAccess = $acl.Access | Where-Object { $_.IdentityReference -eq $userName }
        if ($userAccess) {
            $userAccess | ForEach-Object {
                Write-Host "$userName has the following NTFS permissions in '$folderPath': $($_.AccessControlType) $($_.FileSystemRights)"
            }
        }
    }
}

Write-Host "`nCheck completed."
