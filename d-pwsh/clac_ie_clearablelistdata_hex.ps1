# Usage Instructions
# Download to local machine
Function Get-WebsiteHex(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$website
    )

    # Remove the https:// and http:// prefixes from the URL
    $website = $website -replace "https?://", ""

    # Remove all content after the forward slash
    $website = $website -replace "/.*"

    # Calculate the hexadecimal length of the website name
    $hex_length = [BitConverter]::ToString([BitConverter]::GetBytes([int16]$website.length)).replace('-','')
    # Convert the website name to hexadecimal data
    $hex_data = ([System.Text.Encoding]::Unicode.GetBytes($website) | ForEach-Object { "{0:X2}" -f $_ }) -join ""
    return "0C000000000000000000000101000000$hex_length$hex_data"
}

Function Get-IECompatibilityViewHexHeader(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$websites
    )

    # Construct the header for the IE Compatibility View
    return ("411F00005308ADBA{0}FFFFFFFF01000000{0}" -f ([BitConverter]::ToString([BitConverter]::GetBytes([int32]$websites.count)).replace('-','')))
}

Function Get-IECVHex(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$websites,
        [switch]$ReturnBytes
    )

    # Get the hexadecimal representation of each website and join them together
    $siteArray = $websites -split "[, ]" | Where-Object { $_.Trim() -ne '' }
    $hex_website = $siteArray | ForEach-Object { Get-WebsiteHex $_ }
    $hex_result = ("411F00005308ADBA{0}FFFFFFFF01000000{0}$hex_website" -f [BitConverter]::ToString([BitConverter]::GetBytes([int32]$siteArray.count)).replace('-','')) -replace " "

    if( $ReturnBytes ){
        # If the "-ReturnBytes" switch is provided, return a byte array
        [byte[]]$bytes = @()
        for( $n=0; $n -lt $hex_result.length; $n += 2 ){
            $bytes += ([Convert]::ToInt64($hex_result.substring($n,2),16))
        }
        return $bytes
    }else{
        # Otherwise, return the hexadecimal string
        return $hex_result
    }
}

Write-Host ""
$websites = Read-Host "Please enter the websites for IE Compatibility View"
# Get the websites from user input and call the Get-IECVHex function
Write-Host "`n The hex values for all related websites have been generated, copy the following command: `n"
Write-Host 'reg add "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /v "UserFilter" /t REG_BINARY /d ' -NoNewline
Get-IECVHex -websites $websites

# Reference Links:
# * [Jeff's Blog - MODIFYING IE COMPATIBILITY VIEW SETTINGS WITH POWERSHELL](http://jeffgraves.me/2014/02/19/modifying-ie-compatibility-view-settings-with-powershell/)
# * [ Parsing Data for IE Browser Compatibility View Settings](https://dev.to/excalibra/ie-browser-compatibility-view-settings-data-analysis-228m)
