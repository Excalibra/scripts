@REM  "Win10 is fine for normal use, but for Win11 you need to first use the Xiaoyuer IE Repair Tool (a third-party tool) to restore the IE11 icon before using this tool to prevent hijacking."

@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

:: The new "End of Life" upgrade notification for Internet Explorer
:: https://support.microsoft.com/en-us/topic/the-new-end-of-life-upgrade-notification-for-internet-explorer-ca9a8d93-3f92-ee13-f608-a585f4fa08d4
::Note If the value of the iexplore.exe registry entry is 0, or if the registry entry doesn't exist, the notification feature is enabled by default.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION" /v "iexplore.exe" /t REG_DWORD /d 1 /f


@REM  -----------------------------------------------------------------------------
@REM "Prevent Edge from hijacking the IE browser, processing completed!"

pause
del %0
