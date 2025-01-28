:: Advance Comment Reserved Items

:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::AutoUpdateCfg
@REM https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update#update-enableautomaticupgrades
@REM https://www.howtogeek.com/799392/what-is-waasmedic-agent-exe-how-to-fix-high-disk-usage/
@REM https://www.majorgeeks.com/content/page/what_is_the_update_orchestrator_service.html
@REM https://answers.microsoft.com/en-us/windows/forum/all/windows-7-8-81-registry-edits-to-prevent-windows/4cbd4842-d11f-4579-a8de-18576aad2597
@REM https://greatis.com/stopupdates10/

@REM Pause updates for 3000 days
@REM reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /f

@REM Target group name for this computer
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroup" /f

@REM This service uses this information to determine which updates should be deployed to this computer. Enabled Value 0 = Disabled, 1 = Enabled
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroupEnabled" /f

:: ------- Specify the Intranet Microsoft Update Service Location --------
@REM This setting allows you to specify a server on your network to perform internal update services. The Automatic Update client will search this service to find updates applicable to computers on the network.
@REM Value 0 = Disabled, 1 = Enabled
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer"  /f
@REM Specify the Intranet Microsoft URL
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer"  /f
@REM Set the Intranet statistics server
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer"  /f
:: -------------------------------------------------

@REM This service primarily checks the health of Windows Updates to ensure the system receives the latest security and feature updates promptly. Set its value to 4 (disable the service).
@REM REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaasMedic" /v "Start" /f

:: Advance Comment Reserved Items

:: Completely Disable Windows Updates

@REM Temporarily stop the Windows Update service
net stop wuauserv

@REM ------ Windows Update Medic Service and Update Orchestrator Service -------------

@REM "Start" values include 0 (failed to start), 1 (automatic start at system boot), 2 (manual start), and 3 (disabled). Value 4 means the service will not start, and if already running, it will stop.
@REM The service primarily checks the health of Windows Updates to ensure the system receives updates. Set its value to 4 (disable the service).
@REM Update Orchestrator Service, disable
REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start"  /f
REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start"  /f
@REM https://superuser.com/questions/1584410/windows-10-update-something-went-wrong-try-to-reopen-settings-later
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f

@REM ------ Windows Update Medic Service and Update Orchestrator Service -------------

@REM ---- Comprehensive Windows 7 Upgrade Prompt Kill --------

@REM Disable "Get Windows 10" upgrade notifications https://dev.to/excalibra/three-illustrated-methods-to-block-windows-10-upgrade-prompts-on-windows-781-1fef
REG delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /f
@REM https://serverfault.com/questions/695916/registry-key-gpo-to-disable-and-block-windows-10-upgrade
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx"  /f
@REM Disable "PC Not Supported" popup for Windows 7 https://dev.to/excalibra/disable-unsupported-pc-popup-on-windows-7-122j
REG delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /f

@REM ---- Comprehensive Windows 7 Upgrade Prompt Kill ---------

@REM ------ Other Details -------------

@REM Pause updates enabled Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /f

@REM Allow non-administrators to receive update notifications Enabled Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /f

@REM This setting allows you to specify a server on your network to perform internal update services. Automatic Update clients will search this service for updates applicable to computers on the network.
@REM Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /f

@REM Specify the Intranet Microsoft URL
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /f
@REM Set the Intranet statistics server
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f

@REM If this policy setting is enabled, users will be blocked from connecting to the Windows Update website. Value 1 = Enabled, 0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /f

@REM Configure automatic updates Value 1 = Disabled, 0 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f

@REM Allow automatic updates to install immediately Value 1 = Enabled, 0 = Disabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /f

@REM Automatic update frequency Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /f

@REM Remove access to all Windows Update features Value 1 = Enabled, 0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f

@REM Disable access to all Windows Update features Value 1 = Enabled, 0 = Disabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /f

@REM Prevent Windows Anytime Upgrade (Windows version upgrades) Value 1 = Enabled, 0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /f

@REM Allow or block Microsoft Store from providing updates to the latest version of Windows Value 1 = Enabled, 0 = Disabled
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade"  /f

@REM ------ Other Details -------------

@REM Start the Windows Update service
net start wuauserv
pause
