# Roll a dice (1-6) to randomly select an EmEditor key.
# $emeditor_v21_str;$getkey; Redefining variables leads to redundant output
$i =  (1..6|Get-Random)
$emeditor_v21_str = switch ($i)
{
1 {"RABNAEEAWgBNAC0AVwBIAFkANQAyAC0AQQBYADIAMgAyAC0AWgBRAEoAWABOAC0ANwA5AEoAWABIAA=="}
2 {"RABTAEIAWgBHAC0AQgBGADIAWABIAC0ATQA5ADIAMgAyAC0ARAA1AE0AOABMAC0AUQBDAEMAWABIAA=="}
3 {"RABNAEEAWgBFAC0AVgBLAFoASgBWAC0AMgA4AFoAWgBaAC0ANABUADcAQQBKAC0ANwBIAEgANQA1AA=="}
4 {"RABQAEEAWgA2AC0AUwBIADIAVQBQAC0AUwA3AFoAWgBaAC0AWAA0ADcAVABVAC0ARgBVAEwAMgBYAA=="}
5 {"RABTAEgAWgBBAC0AUQBKADMARwBXAC0AWQBVAFoAWgBaAC0AUwBWAEYAWgAyAC0ANgBEAEIAVQBFAA=="}
6 {"RABNAEEAWgBNAC0AWgBNADUANQA2AC0ASwA2AFoAWgBaAC0AOQA5AEwAVwA4AC0AVwBWADUAQgBUAA=="}
}

# Encoding test [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("asdasdxzczc"));
$getkey = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($emeditor_v21_str))
Set-Clipboard -Value $getkey # Get-Clipboard

Write-Output ""
Write-Output "Fill in any name for registration, and paste the serial number. The serial number has been copied to the clipboard: $getkey"
Write-Output ""
Write-Output "For XP/Win7/Server2008, download here: http://files.emeditor.com/emed32_14.8.1.exe"
Write-Output ""
Write-Output "For Win10/Win11 and future higher versions: https://support.emeditor.com/en/downloads/latest/installer/64"

<# Experiment:

## iwr https | iex doesn’t need to self-delete anymore (remove-item $MyInvocation.MyCommand.Path -force)

## iwr https | iex might work with UTF8 (solution)
## irm https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-pwsh/emeditor_random_keygen.ps1 |iex (new)

## curl -O https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-pwsh/emeditor_random_keygen.ps1 &&
### powershell -c emeditor_random_keygen.ps1 (old)

References:

https://www.educba.com/powershell-base64/ 
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard 
https://learn.microsoft.com/en-gb/powershell/scripting/learn/deep-dives/everything-about-switch?view=powershell-7.4 


| Cracked KEY |
|:---------------------------------------------------------:|
|DMAZM-WHY52-AX222-ZQJXN-79JXH|DSBZG-BF2XH-M9222-D5M8L-QCCXH|
|DKAZQ-R9TYP-5SM2A-9Z8KD-3E2RK||DQHZ2-ZWTCU-S5222-6GT6T-QZ4HZ|
#>
