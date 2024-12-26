@echo "Note: This one-click WinRAR download, install, registration, and activation script must be run with administrator privileges."
@echo
@echo "Replace the domestic proxy personal version (with ads) and download the official commercial version of WinRAR. (The download location is the download directory in the C drive)."

@echo off
powershell -command Invoke-WebRequest -Uri "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701.exe" -OutFile "C:/Users/${env:UserName}/Downloads/winrar-x64-611sc.exe"&&start /wait C:\Users\%username%\Downloads\winrar-x64-611sc.exe /S

@echo "Performing installation of WinRAR and writing the registration file."

@echo off
(
echo RAR registration data
echo WinRAR
echo Unlimited Company License
echo UID=4b914fb772c8376bf571
echo 6412212250f5711ad072cf351cfa39e2851192daf8a362681bbb1d
echo cd48da1d14d995f0bbf960fce6cb5ffde62890079861be57638717
echo 7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565
echo b41bcf56929486b8bcdac33d50ecf773996052598f1f556defffbd
echo 982fbe71e93df6b6346c37a3890f3c7edc65d7f5455470d13d1190
echo 6e6fb824bcf25f155547b5fc41901ad58c0992f570be1cf5608ba9
echo aef69d48c864bcd72d15163897773d314187f6a9af350808719796
)>C:\"Program Files"\WinRAR\rarreg.key

@echo "Ad-free activation is complete. Press Enter or close this window to exit."
pause

del %0

:: Additional notes
:: The previous WinRAR software must be installed in the default directory.
:: Encoding: GB2312; Line endings: CRLF. Fix issues with comments causing missing command letters and garbled text.
:: explorer.exe is also used for downloads, but writing valid code for it is too complicated.
:: CMD without administrator rights cannot successfully write to the Program Files directory on the C drive.
:: Windows 7 requires additional installation of PowerShell 5.0 and TLS/SSL management tools.

:: Reference links
:: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3
