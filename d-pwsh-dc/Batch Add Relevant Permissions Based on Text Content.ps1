# Define the main directory path
$baseFolderPath = "C:\SharedFolders"  # Base path
$userFile = "C:\Users\Administrator\Desktop\PermissionAssignmentList.txt"  # Replace with the actual path of the TXT file

# Read each line of the user file
Get-Content $userFile | ForEach-Object {
    # Split the content of each line
    # $parts = $_ -split '\s+'
    $parts = $_ -split '[\s,\t、]+'  # Regular expression includes spaces, tabs, commas, and middots
    if ($parts.Length -ge 8) {
        $username = $parts[0]
        $folder2 = $parts[5]  # Group folder
        $folder3 = $parts[6]  # Public directory folder
        $permissionType = $parts[7]

        # Set NTFS permission type
        $ntfsPermission = if ($permissionType -like "*Access*") { 
            "(OI)(CI)(R)"  # Read-only permission
        } elseif ($permissionType -like "*Edit*" -or $permissionType -like "*ReadWrite*" -or $permissionType -like "*Save*") { 
            "(OI)(CI)(M)"  # Modify permission
        } else { 
            "(OI)(CI)(R)"  # Default to read-only permission
        }

        # Set share permission type
        $sharePermission = if ($permissionType -like "*Access*") { 
            "Read"  # Shared read-only permission
        } elseif ($permissionType -like "*Edit*" -or $permissionType -like "*ReadWrite*" -or $permissionType -like "*Save*") { 
            "Change"  # Shared change permission
        } else { 
            "Read"  # Default to shared read-only permission
        }

        # Process folder2 (group folder) path by removing the word "Group"
        $folder2WithoutGroup = if ($folder2 -like "*Group") {
            $folder2 -replace "Group$", ""  # Remove "Group" (at the end)
        } else {
            $folder2  # Keep it as is if "Group" is not present
        }

        # Construct the full folder paths
        $fullPath1 = Join-Path -Path $baseFolderPath -ChildPath $folder2  # Original group folder path
        $fullPath2 = Join-Path -Path $baseFolderPath -ChildPath $folder3  # Public directory folder path
        $fullPath3 = Join-Path -Path $baseFolderPath -ChildPath $folder2WithoutGroup  # Path without "Group"

        # Assign permissions to each folder path
        $folders = @($fullPath1, $fullPath2, $fullPath3)

        foreach ($folderPath in $folders) {
            # Check if the folder path exists
            if (-Not (Test-Path $folderPath)) {
                Write-Output "Path $folderPath does not exist, skipping this path."
                continue
            }

            # Use icacls to set NTFS permissions
            icacls "$folderPath" /grant ${username}:$ntfsPermission /t
            Write-Host "Assigned NTFS $ntfsPermission permission to user $username for folder $folderPath." -ForegroundColor Yellow

            # Check if the share exists
            $netShareName = (Get-Item $folderPath).Name  # Use the folder name as the share name

            if (Get-SmbShare -Name $netShareName -ErrorAction SilentlyContinue) {
                # If the share exists, add share permissions
                Grant-SmbShareAccess -Name $netShareName -AccountName "$username" -AccessRight $sharePermission -Force
                Write-Host "Assigned shared $sharePermission permission to user $username for share $netShareName." -ForegroundColor Yellow
            } else {
                Write-Output "Share $netShareName does not exist, skipping share permission assignment."
            }
        }
    }
    else {
        Write-Output "Line format does not match, skipping: $_"
    }
}

Write-Output "All user permissions have been successfully added."

