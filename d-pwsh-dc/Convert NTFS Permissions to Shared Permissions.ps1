# Accept user input for the folder path
$folderPath = Read-Host -Prompt "Please enter the folder path (e.g., C:\SharedFolder\QualityCheck)"

# Accept user input for the share name
$shareName = Read-Host -Prompt "Please enter the share name (e.g., QualityCheck)"

try {
    # Retrieve the folder's NTFS security permissions
    $acl = Get-Acl -Path $folderPath

    # Disable inheritance of permissions for the folder and convert existing inherited permissions to explicit ones
    $acl.SetAccessRuleProtection($true, $false)
    Set-Acl -Path $folderPath -AclObject $acl
    Write-Output "Permission inheritance has been disabled and explicit permissions have been set."
} catch {
    Write-Output "An error occurred while retrieving folder permissions or disabling inheritance: $_"
    exit
}

# Build a valid list of NTFS user permissions
$ntfsUsers = @{ }

foreach ($access in $acl.Access) {
    $user = $access.IdentityReference.Value
    $permissions = $access.FileSystemRights.ToString()

    if ($permissions.Contains("FullControl")) {
        $ntfsUsers[$user] = "Full"
    }
    elseif ($permissions.Contains("Modify")) {
        $ntfsUsers[$user] = "Change"
    }
    elseif ($permissions.Contains("ReadAndExecute") -or $permissions.Contains("Read")) {
        $ntfsUsers[$user] = "Read"
    }
    else {
        Write-Output "Unmatched permission type: $permissions. Skipping shared permission settings for user $user."
    }
}

# Define an exception list, applicable only for NTFS permissions (not added to shared permissions)
$exceptionList = @(
    "CREATOR OWNER", 
    "SYSTEM", 
    "Users", 
    "Administrators", 
    "BUILTIN\Administrators", 
    "NT AUTHORITY\SYSTEM", 
    "NT AUTHORITY\Authenticated Users"
)

try {
    # Clear existing shared permissions to ensure only non-exception NTFS users are added
    Get-SmbShareAccess -Name $shareName | ForEach-Object {
        Revoke-SmbShareAccess -Name $shareName -AccountName $_.AccountName -Force
    }
    Write-Output "Existing shared permissions have been cleared."

    # Set shared permissions for NTFS users who are not in the exception list
    foreach ($user in $ntfsUsers.Keys) {
        if (-not $exceptionList.Contains($user)) {
            try {
                # Check if the user is in SID format (avoid errors due to lack of account names)
                if ($user -match "^S-\d-\d+-(\d+-){1,14}\d+$") {
                    Write-Output "Skipping SID-format user $user for shared permission settings."
                } else {
                    Grant-SmbShareAccess -Name $shareName -AccountName $user -AccessRight $ntfsUsers[$user] -Force
                    Write-Output "Shared permission set for user $user: $ntfsUsers[$user]"
                }
            } catch {
                Write-Output "Error setting shared permissions for user $user (no mapping between account name and SID): $_"
            }
        }
    }
} catch {
    Write-Output "An error occurred while clearing shared permissions: $_"
}

try {
    # Remove users not in the NTFS list and add custom permissions for exception users
    foreach ($access in $acl.Access) {
        $user = $access.IdentityReference.Value
        if (-not $ntfsUsers.ContainsKey($user) -and -not $exceptionList.Contains($user)) {
            $acl.RemoveAccessRule($access)
            Write-Output "NTFS permission removed for user $user."
        }
    }

    # Remove 'Everyone' from shared and NTFS permissions
    Revoke-SmbShareAccess -Name $shareName -AccountName "Everyone" -Force
    $acl.Access | Where-Object { $_.IdentityReference -eq "Everyone" } | ForEach-Object { $acl.RemoveAccessRule($_) }
    Write-Output "'Everyone' has been removed from shared and NTFS permissions."

    # Add system account permissions from the exception list
    $usersRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "ReadAndExecute, ListDirectory, Read", "ContainerInherit, ObjectInherit", "None", "Allow")
    $adminsRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    $systemRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    $creatorOwnerRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CREATOR OWNER", "FullControl", "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")

    # Add the new rules to the ACL
    $acl.AddAccessRule($usersRule)
    $acl.AddAccessRule($adminsRule)
    $acl.AddAccessRule($systemRule)
    $acl.AddAccessRule($creatorOwnerRule)

    # Apply the modified ACL to the folder
    Set-Acl -Path $folderPath -AclObject $acl
    Write-Output "Shared and NTFS permissions have been set. System accounts are retained, and unnecessary members have been removed."
} catch {
    Write-Output "An error occurred while setting or updating NTFS permissions: $_"
}

