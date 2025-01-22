# User Guide
function sel_man {

    # Enable PowerShell: Set-ExecutionPolicy RemoteSigned
    # Disable PowerShell: Set-ExecutionPolicy Restricted
    # Alias Query: Get-Alias | Where-Object { $_.Definition -eq 'ForEach-Object' }
    
    Clear-Host
    Write-Host "`n*************************************************************" -ForegroundColor Green
    Write-Host "`nWarm Reminder:`n" -ForegroundColor Green
    Write-Host "1. The script is applicable for Windows 10 and above. Ensure PowerShell is enabled on the host." -ForegroundColor Green
    Write-Host "2. Enable/Disable PowerShell on the host: " -ForegroundColor Green -nonewline
    Write-Host "Set-ExecutionPolicy RemoteSigned / Set-ExecutionPolicy Restricted" -ForegroundColor DarkYellow
    Write-Host "3. Due to the large amount of information in the script, full-screen use is recommended. For more details, visit: " -ForegroundColor Green -NoNewLine
    Write-Host "https://github.com/Excalibra/scripts `n" -ForegroundColor Blue

    Write-Host " [1] Check the status of IP and network device connections" -ForegroundColor Green
    Write-Host " [2] Check the status of printers, printer pools, and scanners" -ForegroundColor Green
    Write-Host " [3] Check basic driver information such as hard drives, CPUs, memory, and graphics cards" -ForegroundColor Green
    Write-Host " [4] Check device security, recent update patches, scheduled tasks, certificate policies, and access status of core system files" -ForegroundColor Green
    Write-Host " [5] Check information related to active sharing protocols on the host" -ForegroundColor Green
    Write-Host " [6] Check information on computer sleep, restart frequency, abnormal shutdowns, and program crashes" -ForegroundColor Green
    Write-Host " [7] Execute all functions from options 1–6" -ForegroundColor Green -BackgroundColor DarkGray
    Write-Host " [8] Generate analysis reports for \"Driver Check,\" \"Warnings from the Last Five Days,\" \"Logon/Logoff Activity Records,\" and \"Monthly Threat Summary\"" -ForegroundColor Green
    Write-Host " [9] View guidance suggestions and development notes `n" -ForegroundColor Green
    Write-Host "`**************************************************************`n" -ForegroundColor Green

    Write-Host "Press Ctrl + C to exit. Type /? to view this menu. Enter numbers (multiple selections allowed) to choose corresponding functions:" -ForegroundColor Green -NoNewLine

}

# Review guidance suggestions and development instructions
function dev_man {

    # cls
    Write-Host "`n"
    Write-Host "### Review Development Documentation ###`n" -ForegroundColor Cyan

    Write-Host "@Author https://github.com/Excalibra`n"

    Write-Host "#Driver · Device Driver Information Table Overview`n" -ForegroundColor Yellow
    Write-Host "* Problem refers to a description of one or more issues related to the device or driver. Possible values include failure to start, errors, conflicts, etc."
    Write-Host "* ConfigManagerUserConfig indicates whether the device or driver has been reconfigured by the user or system."
    Write-Host "* ClassGuid is the GUID (Globally Unique Identifier) for the type of device the driver belongs to."
    Write-Host "* Manufacturer is the name of the company or organization that produces the device or driver."
    Write-Host "* Present indicates whether the device exists on the system."
    Write-Host "* Service refers to the name of the Windows service responsible for managing the device or driver."
    Write-Host "* Problem: CM_PROB_PHANTOM indicates that the device is marked by the operating system as a "phantom" device, meaning it is damaged, missing, or improperly installed."
    Write-Host "* Problem: CM_PROB_NONE  means it should function normally without any faults or errors.`n"
    Write-Host "For details, see:" -ForegroundColor Yellow -NoNewline; Write-Host "https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/device-manager-problem-codes" -ForegroundColor Blue
    
    Write-Host "`n#Registry · Registry Overview Explanation `n" -ForegroundColor Yellow
    Write-Host "* HKLM: This root key includes system information for the local computer, including hardware and operating system information, security data, and various software settings specific to the computer."
    Write-Host "* HKU: This information tells the system about the icons used by the current user, the activated program groups, the content of the start menu, as well as colors and fonts."
    Write-Host "* HKCU: This root key includes configuration information for the currently logged-in user, such as environment variables, personal programs, and desktop settings."
    Write-Host "* HKCC: Hardware configuration information. In fact, HKEY_LOCAL_MACHINE and HKEY_USERS are the actual registry keys; others are mapped from branches of these keys, effectively acting as shortcuts or aliases.`n"

    Write-Host "`n* Registry Reference Websites:" -ForegroundColor Yellow
    Write-Host "    https://admx.help" -ForegroundColor Blue
    Write-Host "    https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list" -ForegroundColor Blue

    Write-Host "`n* Registry Analysis and Editing Tools:" -ForegroundColor Yellow
    Write-Host "   Registry Analysis Tool:" -ForegroundColor Yellow -nonewline; Write-Host "https://www.nirsoft.net/utils/regscanner.html" -ForegroundColor Blue
    Write-Host "   Registry Editing Tool:" -ForegroundColor Yellow -nonewline; Write-Host "https://registry-finder.com" -ForegroundColor Blue
    
    Write-Host "`n#Logs · Event Levels:`n" -ForegroundColor Yellow
    Write-Host " 1. Information: Represents normal operational behavior or slight changes in system state, but does not indicate any issues or errors."
    Write-Host " 2. Warning: Indicates an existing problem or a potential error, serving as an early warning."
    Write-Host " 3. Error: Signifies that an operation or task failed to complete or was completed incorrectly, requiring attention.`n"
    Write-Host "In Windows events, \"Success Audit\" and \"Failure Audit\" are not reported as event levels but are categorized as event classifications or sources."
    Write-Host "Event IDs correspond to multiple different categories of logs, and each category has its own level-specific details for locating issues.`n"

    Write-Host "#Logs · Program Identifiers `n" -ForegroundColor Yellow
    Write-Host "Each event provider has a unique ProviderName. Below are some common examples from system logs:`n"
    Write-Host "* Microsoft-Windows-Kernel-Power: Provides events related to system power management, such as system suspend, resume, shutdown, and restart."
    Write-Host "* Microsoft-Windows-Kernel-General: Provides events related to the OS kernel, such as OS startup or shutdown, kernel initialization, and driver loading."
    Write-Host "* Microsoft-Windows-Wininit: Provides events related to system boot and initialization, such as starting initialization processes, checking file systems, and loading system drivers."
    Write-Host "* Microsoft-Windows-Security-Auditing: Provides events related to security auditing, such as user logins, permission changes, and file/object access."
    Write-Host "* Microsoft-Windows-DistributedCOM: Provides events related to distributed applications, such as failed distributed COM calls, permission issues, and unavailable RPC servers."
    Write-Host "* Microsoft-Windows-DNS-Client: The service responsible for resolving domain names to corresponding IP addresses and caching them to improve performance."
    Write-Host "* Service Control Manager: Events typically log system startups, service start/stop, service crashes, and other service-related events."
    Write-Host "* LsaSrv: Refers to the Local Security Authority Subsystem Service in Windows, including user logins, logouts, password resets, and NTLM/Kerberos operations."
    Write-Host "* User32: Widely used to handle GUI (Graphical User Interface) elements and system APIs for user interaction."
    Write-Host "`nThe above are just examples of common ProviderNames. In reality, there are many other ProviderNames with various roles and functionalities that can be queried as needed."

    Write-Host "`n* Event ID Lookup:" -ForegroundColor Yellow
    Write-Host "   https://www.ultimatewindowssecurity.com/securitylog/encyclopedia" -ForegroundColor Blue
    Write-Host "   https://www.myeventlog.com/search/find" -ForegroundColor Blue
    Write-Host "   https://www.chicagotech.net/wineventid.htm" -ForegroundColor Blue
    Write-Host "`n* Security Identifier Lookup:" -ForegroundColor Yellow -NoNewline
    Write-Host "https://rootclay.gitbook.io/windows-access-control/qi-an-quan-biao-shi-fu `n" -ForegroundColor Blue
    Write-Host "`n* PowerShell Module Component Clues Lookup:" -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps" -ForegroundColor Blue

    Write-Host "`nCurrent State of Logging System Startup/Shutdown:`n"
    Write-Host "1. Event IDs 6005, 6006, and 557 cannot precisely determine the startup and shutdown times. 6005 and 6006 only record the EventLog service start and stop events, respectively."
    Write-Host "2. These events log the operational state of the system but do not capture the actual startup and shutdown times."
    Write-Host "3. Event 557, while it signifies that the OS has successfully started, is noteworthy for the following:"
    Write-Host "   \"Active\" indicates the system is in an active state, which might include running applications, processing tasks, or waiting for user input."
    Write-Host "   Therefore, \"Active\" during startup could be triggered by certain services or applications automatically invoked by the OS, such as unlocking the lock screen."
    Write-Host "4. Events 12 and 13 in the System log are explicitly defined by Windows as system startup and shutdown events."
    Write-Host " "
    Write-Host "**Note: The accuracy of this method depends on the logging level of the OS and the size limitations of the log files.**" -ForegroundColor Yellow
    Write-Host "**If the logs are full and truncated, these events may not contain the complete history.**" -ForegroundColor Yellow

    Write-Host "`n#Desktop Technology · Common Troubleshooting and Repair`n" -ForegroundColor Cyan
    Write-Host "* Application cannot access the Internet, causing startup issues:" -ForegroundColor Yellow -nonewline; Write-Host "netsh winsock reset" -ForegroundColor Green
    Write-Host "* Resolve residual accounts on SMB shared drives:" -ForegroundColor Yellow -nonewline; Write-Host "net stop workstation & net start workstation" -ForegroundColor Green
    Write-Host "* USB drive repair:" -ForegroundColor Yellow -nonewline; Write-Host "chkdsk [Drive Letter]: /f" -ForegroundColor Green
    Write-Host "* System file integrity scan:" -ForegroundColor Yellow -nonewline; Write-Host "sfc /scannow" -ForegroundColor Green
    Write-Host "* Register system DCOM components:" -ForegroundColor Yellow -nonewline; Write-Host "regsvr32 C:\Windows\System32\ole32.dll" -ForegroundColor Green
    Write-Host "* Check system image integrity:" -ForegroundColor Yellow -nonewline; Write-Host "DISM /Online /Cleanup-Image /RestoreHealth" -ForegroundColor Green
    Write-Host "* For other DLL issues, install the VC++ runtime library to resolve initial problems:" -ForegroundColor Yellow
    Write-Host "  * " -ForegroundColor Yellow -NoNewline; Write-Host "https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 `n" -ForegroundColor Blue

    Write-Host "#Desktop Technology · Network Configuration`n"  -ForegroundColor  Cyan

    Write-Host "Backup IP settings to Desktop as ip_config_bak.txt" -ForegroundColor Yellow
    Write-Host " "
    Write-Host "netsh interface ip show config > C:%homepath%\Desktop\ip_config_bak.txt" -ForegroundColor Green
    Write-Host " "
    Write-Host "Static IP, Subnet Mask, Gateway" -ForegroundColor Yellow
    Write-Host " "
    Write-Host 'netsh interface ip set address "Ethernet" static 192.168.1.1 255.255.255.0  192.168.1.11'  -ForegroundColor Green
    Write-Host " "
    Write-Host "Static DNS Settings" -ForegroundColor Yellow
    Write-host `
        '
    netsh interface ip set dns "Ethernet" static 208.67.222.222 primary && netsh interface ip add dns "Ethernet" 114.114.114.114
    ' -ForegroundColor Green

    Write-host "`nAutomatic Network Configuration`n"  -ForegroundColor Yellow
    Write-Host 'netsh interface ip set address "Ethernet" source=dhcp'  -ForegroundColor Green
    Write-Host 'netsh interface ip set dns "Ethernet" dhcp' -ForegroundColor Green

    Write-host "`n#Desktop Technology · System Setup`n"  -ForegroundColor Cyan

    Write-Host "1. System/Office Activation：" -ForegroundColor Yellow -NoNewline; Write-Host 'powershell -c "irm https://massgrave.dev/get|iex"' -ForegroundColor Green
    Write-host "2. Disable Firewall：" -ForegroundColor Yellow -NoNewline; Write-Host 'netsh advfirewall set allprofiles state off'  -ForegroundColor Green
    Write-host "3. Disable UAC：" -ForegroundColor Yellow -NoNewline;
    Write-host 'reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f' -ForegroundColor Green
    Write-host "4. Enable SMB1：" -ForegroundColor Yellow -NoNewline;
    Write-Host 'reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 1 /f'  -ForegroundColor Green
    Write-host "5. SMB Drive Mapping：" -ForegroundColor Yellow -NoNewline;
    Write-Host 'net use * \\192.168.0.33\VulnerabilityPatch /user:test 123456 /persistent:yes'  -ForegroundColor Green
    Write-host "6. Silent Software Installation：" -ForegroundColor Yellow -NoNewline; Write-Host 'C:\path\your software\Setup.exe /s /qn' -ForegroundColor Green
    Write-Host "7. Show 'This PC', Control Panel Icons, and File Extensions (Copy the code below)"  -ForegroundColor Yellow
    Write-Host `
        '
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{21EC2020-3AEA-1069-A2DD-08002B30309D}" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
        ' -ForegroundColor DarkYellow

    Write-Host "8. Check IP Address in PE Environment:`n"  -ForegroundColor Yellow
    Write-Host `
        '
        REG LOAD HKLM\TempLookIp C:\Windows\System32\config\SYSTEM & REG QUERY HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces /s
        '  -ForegroundColor DarkYellow

    Write-Host " "
    Write-Host "9. IE Hijacking Prevention（For Windows 10，it works fine as is. For Windows 11，you need to first use the Little Fish IE Repair Tool to restore the IE11 shortcut, then use this code.）:`n" -ForegroundColor Yellow
    Write-Host `
        '
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f
        ' -ForegroundColor DarkYellow

    Write-Host "10. Disable Real-Time Protection `n" -ForegroundColor Yellow
    Write-Host `
        '
        REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f 2>nul 1>nul
        ' -ForegroundColor DarkYellow

    Write-Host "`n11. Enable Real-Time Protection `n" -ForegroundColor Yellow
    Write-Host `
        '
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f 1>nul
        ' -ForegroundColor DarkYellow

    Write-Host "`n12. Disable Search Hot Trends in Windows 10/11 `n" -ForegroundColor Yellow
    Write-Host "    reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f" -ForegroundColor DarkYellow

    Write-Host " "
    Write-Host "`n#Desktop Technology · Hibernation and Sleep Topic`n"  -ForegroundColor  Cyan

    Write-Host "Difference between Hibernation and Sleep:`n" -ForegroundColor Yellow
    Write-Host "* Hibernation: Saves the system state to the hard drive, turns off all devices, and when hibernating, it doesn't consume power like shutting down. Upon waking up, the system restores data from the hard drive." -ForegroundColor Yellow
    Write-Host "* Sleep: Saves the system state to memory, turns off all devices, and the system enters a low-power state. It wakes up quickly, but if the power supply is interrupted (like a power strip unplugged), sleep cannot save data.`n" -ForegroundColor Yellow
    Write-Host 'For detailed concepts, "The Difference Between Computer Sleep (sleep) and Hibernate (Hibernate), and Hibernate Function Settings":' -ForegroundColor Yellow
    Write-Host "    https://excalibra.github.io/2025/01-19/01" -ForegroundColor Blue

    Write-Host "`nSet AC and DC to zero for hibernation, sleep, and disable hibernation.（AC: connected to power; DC: using battery）`n" -ForegroundColor Yellow;
    Write-Host `
        '
        # Set AC and DC to zero for hibernation
        ' -NoNewline
    Write-Host `
        '
        powercfg -change -standby-timeout-ac 0
        powercfg -change -hibernate-timeout-ac 0

        ' -ForegroundColor DarkYellow
    Write-Host `
        '
        # Set AC and DC to zero for sleep
        ' -NoNewline
    Write-Host `
        '
        powercfg -change -standby-timeout-dc 0
        powercfg -change -hibernate-timeout-dc 0

        ' -ForegroundColor DarkYellow
    Write-Host `
        '
        # Disable hibernation
        ' -NoNewline
    Write-Host `
        '
        powercfg -h off
        ' -ForegroundColor DarkYellow

    Write-Host "`nSet screen display timeout for AC and DC (default unit is seconds)：`n" -ForegroundColor Yellow;
    Write-Host `
        '
        # AC: connected to power
        ' -NoNewline
    Write-Host `
        '
        powercfg -setacvalueindex SCHEME_BALANCED SUB_VIDEO VIDEOIDLE 180
        ' -ForegroundColor DarkYellow

    Write-Host `
        '
        # DC: using battery
        ' -NoNewline
    Write-Host `
        '
        powercfg -setdcvalueindex SCHEME_BALANCED SUB_VIDEO VIDEOIDLE 120
        ' -ForegroundColor DarkYellow

    Write-Host 'Regarding the "Allow the computer to turn off this device to save power" disable setting, refer to:' -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/en-gb/troubleshoot/windows-client/networking/power-management-on-network-adapter" -ForegroundColor Blue
    Write-Host "    https://learn.microsoft.com/en-gb/windows-hardware/design/device-experiences/modern-standby-sleepstudy" -ForegroundColor Blue
    Write-Host " "
    Write-Host 'To cancel the "Allow the computer to turn off this device to save power" setting （check the default value 0 for enable；uncheck 24 for disable）"' -ForegroundColor Yellow
    Write-Host " "
    Write-Host `
        '
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\0001" /v PnPCapabilities /t REG_DWORD /d 24 /f
        ' -ForegroundColor DarkYellow

    Write-Host "`n#Supplement · Shared Services Explanation `n" -ForegroundColor Cyan

    Write-Host "`n Unlike port traffic monitoring and analysis, this shared service detection is primarily targeted at detecting hosts from colleagues in departments like non-information quality or application development within a local area network. Thus, it is easier to detect suspicious hosts.`n" -ForegroundColor Yellow
    Write-Host 'Additionally, HTTP is more complex and professional compared to SMB and FTP, so it is not included in the detection scope.' -ForegroundColor Yellow; Write-Host "`nSummary of SMB shares:"
    Write-Host '1. ADMIN$ represents the shared directory of the Windows operating system installation directory (usually C:\Windows). This share is accessible only by administrator accounts for remote management operations.'
    Write-Host '2. C$ represents the shared directory of the entire system drive (usually C:\). This share allows users with administrator privileges to access the root directory of the system over the network.'
    Write-Host '3. IPC$ is a special share that allows users to connect without authentication. This share may be abused for unauthorized access.'
    Write-Host ' 3.1 This means attackers can use tools and techniques (such as port scanning, remote desktop connections, etc.) to access the IPC$ share and attempt to exploit system vulnerabilities.'
    Write-Host ' 3.2 Disabling IPC$ might negatively affect other services such as file sharing, Active Directory (AD), remote management tools, system backups, and restores.'

    Write-Host "`n#Supplement · Windows Defender Documentation`n" -ForegroundColor Cyan

    Write-Host `
        '
        * https://learn.microsoft.com/en-us/previous-versions/windows/desktop/defender/msft-mpthreat
        * https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-antivirus/microsoft-defender-antivirus-in-windows-10
        ' -ForegroundColor Yellow

    Write-Host `
        '
        Detailed property information for Get-MpThreatDetection can be found at: https://powershell.one/wmi/root/microsoft/windows/defender/msft_mpthreatdetection
        ' -ForegroundColor Green

    Write-Host "`n#Other · New Discoveries`n" -ForegroundColor Cyan

    Write-Host `
        '
        For information on image hijacking, refer to: https://attack.mitre.org/techniques/T1546/012/
        ' -ForegroundColor Green

        Write-Host `
        '
        * And the test certificates in the certificate store: https://github.com/the1812/Malware-Patch/tree/master/src/MalwarePatch/Certificates
        ' -ForegroundColor Green
        Write-Host `
        '
        For authorization checks on system32 files, under normal circumstances, these four should be in a Deny state. If other items are found, there may be suspicious entries.
        Microsoft.PowerShell.Core\FileSystem::C:\Windows\System32\FxsTmp
        Microsoft.PowerShell.Core\FileSystem::C:\Windows\System32\Recovery
        Microsoft.PowerShell.Core\FileSystem::C:\Windows\System32\SleepStudy
        Microsoft.PowerShell.Core\FileSystem::C:\Windows\System32\WDI
        Virtual machines do not have the FxsTmp entry. Be sure to review related information and examine the role of suspicious DLL files marked as Deny.
        ' -ForegroundColor Green

    Write-Host "`n#Conclusion`n" -ForegroundColor  Cyan

    Write-Host "PowerShell is a powerful scripting language that enables a variety of system-level operations and is highly beneficial for automating the management of Windows systems."
    Write-Host "The baseline check script implemented with PowerShell can check system basics such as system information, network connections, printer status, firewall status, disk, CPU, and memory information.`n"
    Write-Host "`nThe baseline check script involves various techniques as follows:"
    Write-Host "1. Common Desktop Problem Solutions: Desktop operations involve software, hardware, network, system, and security across various aspects."
    Write-Host "2. Code implementation details: How to get system information, how to retrieve registry information, how to gather event log information, and how to access WMI data."
    Write-Host "2.1 Code implementation involves design thinking: query structure, basic operation logic, exception handling, etc."
    Write-Host "3. Documentation and verification: keywords, case studies, debugging, experiments, and repeated references.`n"
    Write-Host "For questions or concerns, feel free to contact the author at excalibra@proton.me and visit the GitHub project at:" -NoNewline -ForegroundColor Yellow
    Write-Host "https://github.com/Excalibra/scripts " -NoNewline -ForegroundColor Blue
    Write-Host "，and feel free to reach out for consultation or corrections." -ForegroundColor Yellow

    Write-Host "`n#Appendix · IT Operations Technical Analysis Tools`n"  -ForegroundColor  Cyan

    Write-Host "`n* Local Network Analysis Tools:" -ForegroundColor Yellow
    Write-Host "    advanced-ip-scanner：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.advanced-ip-scanner.com" -ForegroundColor Blue
    Write-Host "    wireshark：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.wireshark.org" -ForegroundColor Blue

    Write-Host "`n* System Performance Analysis Tools:" -ForegroundColor Yellow
    Write-Host "   HWiNFO：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.hwinfo.com" -ForegroundColor Blue
    Write-Host "   windirstat：" -ForegroundColor Yellow -nonewline; Write-Host "https://windirstat.net" -ForegroundColor Blue
    Write-Host "   sysinternals：" -ForegroundColor Yellow -nonewline; Write-Host "https://docs.microsoft.com/zh-cn/sysinternals/downloads/process-explorer" -ForegroundColor Blue

    Write-Host "`n* PowerShell Module Components:" -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps" -ForegroundColor Blue
    Write-Host "    https://www.powershellgallery.com" -ForegroundColor Blue

    Write-Host "`n* Registry Analysis Tools:" -ForegroundColor Yellow
    Write-Host "   admx.help：" -ForegroundColor Yellow -nonewline; Write-Host "https://admx.help" -ForegroundColor Blue
    Write-Host "   regscanner：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.nirsoft.net/utils/regscanner.html" -ForegroundColor Blue
    Write-Host "   registry-finder：" -ForegroundColor Yellow -nonewline; Write-Host "https://registry-finder.com" -ForegroundColor Blue

    Write-Host "`n* Event ID Analysis Tools:" -ForegroundColor Yellow
    Write-Host "    Win10_Events_ID_useful：" -ForegroundColor Yellow -nonewline; Write-Host "https://github.com/Excalibra/scripts/blob/main/AQUICK/BITRH/Win10_Events_ID_useful.xlsx" -ForegroundColor Blue
    Write-Host "   myeventlog：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.myeventlog.com/search/find" -ForegroundColor Blue
    Write-Host "   ultimatewindowssecurity：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.ultimatewindowssecurity.com/securitylog/encyclopedia" -ForegroundColor Blue

    Write-Host "`n#Appendix · Software Analysis Topics:`n" -ForegroundColor  Cyan
    Write-Host "1. Code Analysis: Software analysis typically involves detailed analysis of the application source code." -ForegroundColor Yellow
    Write-Host "2. Vulnerability Scanning: Vulnerability scanning tools are used to automatically discover security vulnerabilities in software." -ForegroundColor Yellow
    Write-Host "3. Static Analysis: Static analysis refers to analyzing source code to identify potential issues without executing the code." -ForegroundColor Yellow
    Write-Host "4. Dynamic Analysis: Dynamic analysis involves analyzing applications at runtime to observe their behavior." -ForegroundColor Yellow
    Write-Host "5. Reverse Engineering: Reverse engineering refers to using disassemblers and other techniques to analyze compiled code to understand its internal mechanisms." -ForegroundColor Yellow
    Write-Host "6. Anti-Cheat Analysis: Anti-cheat analysis involves analyzing games and applications to detect and counteract cheating behaviors." -ForegroundColor Yellow
    Write-Host "7. Security Auditing: Security auditing involves detailed review of software to determine whether it meets specific security standards or regulations." -ForegroundColor Yellow

    Write-Host "`n#Appendix · Information Security Aggregated Resources" -ForegroundColor  Cyan
    Write-Host " "
    Write-Host "----------------------------------------" -ForegroundColor Yellow
    Write-Host "Search tips: 1. Be clear about your goal; 2. Refine keywords; 3. Look for both positive and negative examples, analyze and compare. For example (and so on):" -ForegroundColor Yellow
    Write-Host "[CSDN - PowerShell Attacks and Detection](https://blog.csdn.net/Ping_Pig/article/details/108976627)" -ForegroundColor Magenta
    Write-Host "----------------------------------------" -ForegroundColor Yellow
    Write-Host " "

    Write-Host "`n* IT Tech Articles, Forums, and Websites:" -ForegroundColor Yellow
    Write-Host "   superuser：" -ForegroundColor Yellow -nonewline; Write-Host "https://superuser.com" -ForegroundColor Blue
    Write-Host "   minitool news：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.minitool.com/news/automatic-sample-submission-off.html" -ForegroundColor Blue
    Write-Host "   stack overflow：" -ForegroundColor Yellow -nonewline; Write-Host "https://stackoverflow.com" -ForegroundColor Blue
    Write-Host "   freebuf：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.freebuf.com" -ForegroundColor Blue

    Write-Host "`n#Appendix · ASCII ART`n" -ForegroundColor  Cyan
    Write-Host " "
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "Generate ASCII Art" -ForegroundColor Yellow
    Write-Host " [ASCII ART](https://ascii.co.uk/art)" -ForegroundColor Magenta
    Write-Host " [ASCII Art Generator](https://wiki.archlinux.org/title/ASCII_art)" -ForegroundColor Magenta
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host " "
    Write-Host @"
                                                             <|/\
                                                              | |,

                                                             |-|-o
                                                             |<|.

                                              _,..._,m,      |,
                                           ,/'      '"";     | |,
                                          /             ".
                                        ,'mmmMMMMmm.      \  -|-_"
                                      _/-"^^^^^"""%#%mm,   ;  | _ o
                                ,m,_,'              "###)  ;,
                               (###%                 \#/  ;##mm.
                                ^#/  __        ___    ;  (######)
                                 ;  //.\\     //.\\   ;   \####/
                                _; (#\"//     \\"/#)  ;  ,/
                               @##\ \##/   =   `"=" ,;mm/
                               `\##>.____,...,____,<####@
                                                     ""'     m1a

"@ -ForegroundColor DarkGreen

    <# ------- Countdown

    # Let's use a two-digit format as a compromise, applied when there are less than 100 seconds remaining, or when it reaches 1 minute.
    # $t = 11
    # while ($t -ge 0) {
    #     Write-Host ($t.ToString("D2")) -NoNewline
    #     Start-Sleep -Seconds 1
    #     Write-Host -NoNewline "`b`b`b`r"
    #     $t--
    # }

    #>

}

# Check Hostname, System Installation Date, Boot Time, Uptime, and System Architecture
function check_sys {

    Clear-Host
    Write-Host "`n"
    Write-Host "### Basic Host Information ###" -ForegroundColor Cyan

    Get-ComputerInfo | Select-Object -Property `
        OsRegisteredUser, CsDomain, CsDNSHostName, OsName,
    OsInstallDate, OsLastBootUpTime, OsUptime, OsArchitecture `
    | Out-Host
}

# Check IP and Network Device Connection Status
function check_ip {

    Write-Host " "
    Write-Host "### Checking Basic Network Connectivity ###`n" -ForegroundColor Cyan

    Write-Host "--- Checking IP address and whether the proxy is enabled (1 for enabled, 0 for disabled) ---"  -ForegroundColor Yellow
    netsh interface ipv4 show addresses "Ethernet"
    netsh interface ipv4 show dnsservers "Ethernet"
    Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable

    Write-Host "--- Checking Local Area Network (LAN) connection  ---`n"  -ForegroundColor Yellow
    $result = Get-NetConnectionProfile | Select-Object -Property Name, InterfaceAlias, NetworkCategory
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "There is an issue with this network.`n" -ForegroundColor DarkRed
    }

    Write-Host "--- Checking if there have been any recent IP conflicts ---`n"  -ForegroundColor Yellow

    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        StartTime = (Get-Date).Date.AddDays(-14)
    } | Where-Object {
        ($_.Id -in 4199)
    } | Select-Object Id, Level, ProviderName, LogName, `
        TimeCreated, LevelDisplayName, TaskDisplayName

    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "No IP conflict events have occurred recently.`n" -ForegroundColor Green
    }

    Write-Host "### Basic Network Connectivity Check Completed`n" -ForegroundColor Green
}

# Check Printer Status Details
function check_printer {

    Write-Host " "
    Write-Host "### Checking Printer Status ###`n" -ForegroundColor Cyan

    Write-Host "--- Checking Printer Service and Number of Connected Printers ---"  -ForegroundColor Yellow
    Get-Service | findstr "Spooler" | Out-Host

    Write-Host "--- Checking if there are files in the print queue ---"  -ForegroundColor Yellow
    Get-ChildItem C:\Windows\System32\spool\PRINTERS

    $result = Get-Printer | Select-Object Name, PrinterStatus
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "No virtual or physical printers are configured" -ForegroundColor DarkRed
    }

    Write-Host "--- Checking if a default printer is set ---"  -ForegroundColor Yellow

    $result = Get-CimInstance -Class Win32_Printer | Where-Object { $_.Default -eq $true } | Select-Object Name
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "No default printer is configured" -ForegroundColor Magenta
    }

    Write-Host "--- Checking if Scanner Service is present ---"  -ForegroundColor Yellow

    $result = Get-Service stisvc
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "Scanner service is missing" -ForegroundColor Magenta
    }

    Write-Host "`n### Printer Status Check Completed`n" -ForegroundColor Green
}

# Check hard disk, CPU, and memory information
function check_disk_cpu_mem {

    # [math]::Round is used to call static methods or properties from the .NET Framework.
    # For more details: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3
    Write-Host " "
    Write-Host "### Starting to check disk, CPU, memory, and system drivers ###`n"  -ForegroundColor Cyan

    Write-Host "--- Checking disk type and capacity ---"  -ForegroundColor Yellow
    $result = Get-PhysicalDisk
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "Unable to retrieve disk type and capacity`n"  -ForegroundColor Red
    }

    Write-Host "--- Checking disk partitions and available space ---"  -ForegroundColor Yellow
    $result = Get-Volume
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "Unable to retrieve disk partitions and available space`n"  -ForegroundColor Red
    }

    Write-Host "--- Checking CPU parameters ---"  -ForegroundColor Yellow
    $result = Get-CimInstance -Class Win32_Processor | Select-Object Caption, MaxClockSpeed
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "Unable to retrieve CPU parameters`n"  -ForegroundColor Red
    }

    Write-Host "--- Checking memory module parameters and types ---`n"  -ForegroundColor Yellow
    Write-Host "DDR1: Below 400 MHz, DDR2: Below 800 MHz, DDR3: Below 2133 MHz, DDR4: Below 3200 MHz."

    $result = Get-CimInstance -Class Win32_PhysicalMemory |
    Select-Object -Property BankLabel,
    @{Name = "Capacity(GB)"; Expression = { [math]::Round($_.Capacity / 1GB, 2) } },
    DeviceLocator, PartNumber, SerialNumber, Speed
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "Unable to retrieve memory module parameters and types`n"  -ForegroundColor Red
    }


    Write-Host "--- Checking display parameters status ---"  -ForegroundColor Yellow

    $videoController = Get-CimInstance -Class Win32_VideoController -ErrorAction SilentlyContinue

    if ($videoController) {

        $Name = $videoController.Name
        $DriverVersion = $videoController.DriverVersion
        $AdapterCompatibility = $videoController.AdapterCompatibility
        $Status = $videoController.Status
        $AdapterRAM = [System.Math]::Round($videoController.AdapterRAM / (1024 * 1024 * 1024), 2)
        $CurrentHorizontalResolution = $videoController.CurrentHorizontalResolution
        $CurrentVerticalResolution = $videoController.CurrentVerticalResolution
        $VideoModeDescription = $videoController.VideoModeDescription
        $MaxRefreshRate = $videoController.MaxRefreshRate

        if ([string]::IsNullOrEmpty($Name)) { $Name = "N/A" }
        if ([string]::IsNullOrEmpty($AdapterCompatibility)) { $Name = "N/A" }
        if ([string]::IsNullOrEmpty($Status)) { $Status = "N/A" }
        if ([string]::IsNullOrEmpty($DriverVersion)) { $DriverVersion = "N/A" }
        if ([string]::IsNullOrEmpty($AdapterRAM)) { $AdapterRAM = "N/A" }

        if ([string]::IsNullOrEmpty($CurrentHorizontalResolution)) { $CurrentHorizontalResolution = "N/A" }
        if ([string]::IsNullOrEmpty($CurrentVerticalResolution)) { $CurrentVerticalResolution = "N/A" }
        if ([string]::IsNullOrEmpty($VideoModeDescription)) { $VideoModeDescription = "N/A" }
        if ([string]::IsNullOrEmpty($MaxRefreshRate)) { $MaxRefreshRate = "N/A" }

        Write-Host " "
        Write-Host "Graphics Driver：$Name"
        Write-Host "Driver Version：$DriverVersion"
        Write-Host "Status：$Status"
        Write-Host "Video Memory (GB)：$AdapterRAM"
        Write-Host "Platform Compatibility：$AdapterCompatibility"
        Write-Host "Max Refresh Rate：$MaxRefreshRate"
        Write-Host "Current Horizontal Resolution：$CurrentHorizontalResolution"
        Write-Host "Current Vertical Resolution：$CurrentVerticalResolution"
        Write-Host "Video Mode Description：$VideoModeDescription"
        Write-Host " "
    }
    else {
        Write-Host "Failed to detect Video Controller.`n"
    }

    Write-Host "`n--- Checking display device details ---`n"  -ForegroundColor Yellow

    $monitor_id = Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorID | Select-Object -First 1

    if ($null -ne $monitor_id) {
        $Manufacturer = [System.Text.Encoding]::UTF8.GetString($monitor_id.ManufacturerName)
        $ProductCode = [System.Text.Encoding]::UTF8.GetString($monitor_id.ProductCodeID)
        $SerialNumber = [System.Text.Encoding]::UTF8.GetString($monitor_id.SerialNumberID)
        $UserFriendlyNameLength = $monitor_id.UserFriendlyNameLength
        $UserFriendlyNameBytes = $monitor_id.UserFriendlyName[0..($UserFriendlyNameLength - 1)]

        if ($null -ne $UserFriendlyNameBytes) {
            $UserFriendlyName = [System.Text.Encoding]::UTF8.GetString($UserFriendlyNameBytes)
        }
        else {
            $UserFriendlyName = "N/A"
        }

        $WeekOfManufacture = $monitor_id.WeekOfManufacture
        $YearOfManufacture = $monitor_id.YearOfManufacture

        Write-Host "Active: $($monitor_id.Active)"
        Write-Host "Instance Name: $($monitor_id.InstanceName)"
        Write-Host "Manufacturer: $Manufacturer"
        Write-Host "Product Code: $ProductCode"
        Write-Host "Serial Number: $SerialNumber"
        Write-Host "User-friendly name: $UserFriendlyName (Length: $UserFriendlyNameLength)"
        Write-Host "Week of Manufacture: $WeekOfManufacture"
        Write-Host "Year of Manufacture: $YearOfManufacture"
    }
    else {
        Write-Host "`nNo specific display information found.`n" -ForegroundColor Red
    }

    Write-Host "`n--- Checking motherboard details ---"  -ForegroundColor Yellow

    $result = Get-CimInstance -Class Win32_BaseBoard | Select-Object Manufacturer, Product, Model, SerialNumber
    if ($result) {
        $result | Format-List
    }
    else {
        Write-Host "`nNo motherboard details found`n"  -ForegroundColor Green
    }

    Write-Host "`n--- Checking for driver issues ---`n"  -ForegroundColor Yellow
    $result = Get-PnpDevice | Where-Object { $_.Status -ne "Ok" }
    if ($result) {
        $result | Select-Object FriendlyName, Status | Out-Host
    }
    else {
        Write-Host "Device drivers are operating normally`n"  -ForegroundColor Green
    }
    Write-Host "### Disk, CPU, memory, and system driver check completed`n"  -ForegroundColor Green
}

# Check the firewall status and whether specific port rules are open (initial functionality)
# Check device security, recent upgrade patches, and scheduled tasks
function check_fw {

    Write-Host " "
    Write-Host "### Checking device security, recent patch upgrades, scheduled tasks, certificate policies, and system core file access control ###`n" -ForegroundColor Cyan

    Write-Host "--- Checking the status of Windows Defender Real-time ProtectionChecking the status of Windows Defender Real-time Protection ---"  -ForegroundColor Yellow
    Get-MpComputerStatus | Select-Object -Property RealTimeProtectionEnabled, AntivirusEnabled | Out-Host

    Write-Host "--- Checking if the firewall is enabled ---"  -ForegroundColor Yellow
    Get-NetFirewallProfile | Select-Object Name, Enabled | Out-Host

    Write-Host "--- Checking if Remote Desktop and ICMP ping firewall rules are enabled ---"  -ForegroundColor Yellow
    Get-NetFirewallRule -DisplayName "Remote Desktop*", "Core Network Diagnostics*ICMPv4*" | Select-Object DisplayName, Enabled | Out-Host

    Write-Host "--- Checking recent patches installed on the host ---`n"  -ForegroundColor Yellow
    Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 9 | Out-Host

    Write-Host "--- Checking non-system scheduled tasks ---`n"  -ForegroundColor Yellow

    Get-ScheduledTask | Where-Object { $_.TaskPath -notlike "*Microsoft*" -and $_.TaskName -notlike "*Microsoft*" } `
    | Get-ScheduledTaskInfo | Select-Object TaskName, LastRunTime, NextRunTime | Format-table

    Write-Host "--- Checking system-level software auto-start (Run) ---`n" -ForegroundColor Yellow

    Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue `
    | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List

    Write-Host "--- Checking user-level software auto-start (Run) ---`n" -ForegroundColor Yellow

    Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue `
    | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List

    Write-Host "--- Checking system and user-level software that runs only once (RunOnce) ---`n" -ForegroundColor Yellow

    # System-level HKLM
    $run_once_path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
    if ((-not (Test-Path $run_once_path)) -or ($null -eq (Get-ItemProperty -Path $run_once_path))) {
        # Write-Warning "RunOnce property not found."
        Write-Host "No system-level one-time auto-start entries found`n" -ForegroundColor Green
    }
    else {
        Get-ItemProperty -Path $run_once_path `
        | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List
    }
    # User-level HKCU
    if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce")) {
        Write-Host "No user-level one-time auto-start entries found`n"  -ForegroundColor Green
    }
    else {
        Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" `
        | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List
    }

    Write-Host "--- Checking for evaluation version automatic restart registry (Enterprise version) ---`n" -ForegroundColor Yellow
    if (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WLMS") {
        $result = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WLMS"
        Write-Host "Solution for Windows system automatically shutting down periodically：" -ForegroundColor Yellow -NoNewline
        Write-Host "http://www.yvsy.com/501.html" -ForegroundColor Blue
        $result | Select-Object ImagePath, Start | Format-List
    } else {
        Write-Host "No related registry for evaluation version found`n" -ForegroundColor Green
    }

    Write-Host "--- Checking for malicious image hijacking ---`n" -ForegroundColor Yellow

    $result = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\*" | Where-Object { $_.debugger -eq "\" }
    if ($null -eq $result) {
        Write-Host "No malicious image hijacking registry found`n" -ForegroundColor Green
    }else {
        $result|Select-Object{$_.PSPath}|Format-List
    }

    Write-Host "`n--- Checking for disabled certificate checks ---`n" -ForegroundColor Yellow

    # Get-ChildItem -Path 'Cert:\LocalMachine\Root' | Format-List *
    $result = Get-ChildItem -Path 'Cert:\LocalMachine\Disallowed' | Select-Object Subject, PSPath, NotBefore, NotAfter, Thumbprint
    if ($null -eq $result) {
        Write-Host "No disabled certificate checks found`n" -ForegroundColor Green
    }else {
        $result|Format-List
    }

    Write-Host "`n--- Checking if system core files are denied access ---`n" -ForegroundColor Yellow
    Write-Host "Normally, the host should contain these four: FxsTmp, Recovery, SleepStudy, WDI (Virtual machines do not have FxsTmp)`n"

   $result = Get-Acl -Path C:\Windows\System32\*|Where-Object{$_.AccessToString -like "*Deny*"}|Select-Object Path
   if ($null -eq $result) {
        Write-Host "No related records found, please ensure the script is run as administrator`n" -ForegroundColor DarkMagenta
    }else {
        $result|Format-List
    }

    Write-Host "### Checking device security, recent patch upgrades, scheduled tasks, certificate policies, and system core file access control, completed`n" -ForegroundColor Green
}

# Share Check (including: shared ports, shared files)
function check_share {

    Write-Host " "
    Write-Host "### Checking host's shared resource security (basic checks only: default ports, shared files) ###`n" -ForegroundColor Cyan

    Write-Host "--- Checking if the firewall is enabled (for easier viewing) ---"  -ForegroundColor Yellow
    Get-NetFirewallProfile | Select-Object Name, Enabled | Out-Host

    Write-Host "--- Checking if SMB 1.0 functionality is enabled for accessing local network resources ---"  -ForegroundColor Yellow
    Get-WindowsOptionalFeature -Online | Where-Object FeatureName -eq "SMB1Protocol" | Out-Host

    Write-Host "--- Checking if the host has shared files with other computers using SMB ---`n" -ForegroundColor Yellow

    # https://support.microsoft.com/en-gb/windows/file-sharing-over-a-network-in-windows-b58704b2-f53a-4b82-7bc1-80f9994725bf    Write-Host "SMB服务检测"
    Get-Service | Where-Object { $_.Name -match 'LanmanServer' } | Out-Host

    $result = Get-SmbShare | Select-Object Name, Path, Description
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "No shared files found.`n" -ForegroundColor Green
    }

    Write-Host "--- Checking if the host has an active FTP sharing service ---" -ForegroundColor Yellow

    $result = Get-Service | Where-Object { $_.Name -match 'ftp' }
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "`nNo active FTP service found.`n" -ForegroundColor Green
    }

    Write-Host "--- Checking if Remote Desktop is enabled: 0 is enabled, 1 is disabled ---" -ForegroundColor Yellow
    Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" | Select-Object fDenyTSConnections | Out-Host

    # Remote Desktop Service
    Get-Service | Where-Object { $_.Name -match 'TermService' } | Out-Host

    Write-Host "--- Checking for Suspicious Remote Desktop (SRP) login behavior in the last month ---`n"  -ForegroundColor Yellow
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security';
        ID        = 4624, 4625;
        StartTime = (Get-Date).Date.AddDays(-30);
        Message   = '*Remote Desktop*'
    } -ErrorAction SilentlyContinue
    if ($result) {
        $result | Out-GridView -Title "Suspicious Remote Desktop (SRP) Login Records"
    }
    else {
        Write-Host "No suspicious Remote Desktop login behavior found in the last 30 days.`n" -ForegroundColor Green
    }
    Write-Host "### Share Resource Check (including: shared ports, shared files) is complete`n" -ForegroundColor Green
}

# Event Query
function check_key_events {

    Write-Host " "
    Write-Host "### Checking computer events such as sleep, shutdown/restart, and program crashes ###`n" -ForegroundColor Cyan

    # View local users and user groups
    Write-Host "--- Checking local user status ---`n" -ForegroundColor Yellow
    localuser | Out-Host
    Get-LocalGroupMember -Group Administrators | Out-Host

    Write-Host "--- Checking local users with no password set ---`n" -ForegroundColor Yellow
    Get-LocalUser | Where-Object { $null -eq $_.Password } | Select-Object Name | Out-Host

    # New: Check the system sleep state independently
    # Difference between Hibernate and Sleep: https://excalibra.github.io/2025/01-19/01
    Write-Host "--- Checking if sleep functionality is enabled. (AC Power: plugged in; DC Power: on battery) ---`n" -ForegroundColor Yellow
    Write-Host 'Note: For desktop PCs and virtual machines, you may ignore "lid close or open" information.' -ForegroundColor Green

    powercfg -q SCHEME_BALANCED SUB_SLEEP STANDBYIDLE; powercfg -q SCHEME_BALANCED SUB_BUTTONS | Out-Host

    Write-Host "--- Restart frequency in the last two weeks ---"  -ForegroundColor Yellow

    # Reference: [codeantenna - Windows system log shutdown, restart events](https://codeantenna.com/a/QEcwIkyexa)
    # When multiple IDs describe the same term, check the Message attribute for fine distinctions
    $result = Get-WinEvent -FilterHashtable @{
        LogName      = 'System'
        ProviderName = 'User32'
        Id           = 1074
        StartTime    = (Get-Date).Date.AddDays(-14)
    }

    if ($result) {
        $result | Out-Host
        $sum = ($result | Measure-Object).Count
        Write-Host "Total restarts:"$sum, "times$i; Average restarts per day:"$([math]::Round($sum / 14, 2)),"times" -ForegroundColor Green

        # Calculate daily restart count and find the highest
        $dateCounts = @{}
        foreach ($event in $result) {
            # Convert to string, keep only the date part
            $date = $event.TimeCreated.ToShortDateString()
            # If the date exists, increment the count, otherwise initialize to 1
            if ($dateCounts.Contains($date)) {
                $dateCounts[$date] += 1
            }
            else {
                $dateCounts[$date] = 1
            }
        }
        # Find the maximum value
        $maxDate = ($dateCounts.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1).Name
        $maxCount = $dateCounts[$maxDate]
        Write-Host "Date with most restarts: $maxDate, and the number of restarts on that day: $maxCount" -ForegroundColor Cyan

    }
    else {
        Write-Host "No restart data found for the last 14 days."-ForegroundColor DarkRed
    }

    # Event ID 41 - Unexpected Shutdown, Event ID 6008 - Abnormal Shutdown
    Write-Host "`n--- Checking for abnormal startups and shutdowns in the last 2 weeks ---`n" -ForegroundColor Yellow
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        Id        = 41, 6008
        StartTime = (Get-Date).Date.AddDays(-14)
    } -ErrorAction SilentlyContinue

    if ($result) {
        # $result | Out-GridView -Title "Abnormal startup and shutdown events in the last 2 weeks"
        $result | Out-Host
    }
    else {
        Write-Host "No abnormal shutdowns or startups in the last 2 weeks.`n" -ForegroundColor Green
    }

    Write-Host "--- Checking for blue screens or crashes in the last 7 days ---`n"  -ForegroundColor Yellow
    # https://social.microsoft.com/Forums/zh-CN/068ccdf2-96f4-484d-a5cb-df05f59e1959/win1020107202142659730475221202010720214id1000652921001?forum=window7betacn
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        Id        = 1001 # Event ID 1001 corresponds to multiple LogNames, and each LogName has different levels for ID 1001.
        StartTime = (Get-Date).Date.AddDays(-7)
    } -ErrorAction SilentlyContinue

    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "No blue screens or crashes in the last 7 days.`n" -ForegroundColor Green
    }

    shoudong_check

    Write-Host "`n### Checking computer events such as sleep, shutdown/restart, and program crashes is complete`n" -ForegroundColor Green
}

# Manual Input Check
function shoudong_check{

    Write-Host "--- Enter a time period and check for abnormal warnings and error events relative to the current time ---`n"  -ForegroundColor Yellow

    do {
        # Get the user input for date and time
        $dateTimeString = Read-Host "Please enter the date and time in the format yyyy-MM-dd HH:mm e.g., 2023-06-09 13:01 or enter K to skip"

        if ($dateTimeString -eq 'K' -or $dateTimeString -eq 'k') {
            Write-Host "Skipped." -ForegroundColor Yellow
            return
        }

        try {
            # Use Get-Date to try and convert the string to a date-time object
            $startTime = Get-Date $dateTimeString
            break
        }
        catch {
            # If conversion fails, prompt the user to re-enter
            Write-Host "The entered format is invalid. Please re-enter." -ForegroundColor Yellow
        }
    } while ($true)

    # Build the filter and retrieve abnormal events
    $filter = @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = $startTime
    }

    $events = Get-WinEvent -FilterHashtable $filter -ErrorAction SilentlyContinue `
    | Where-Object { $_.LevelDisplayName -in "Error", "Warning", "Critical" }

    if ($events) {
        $events | Out-GridView -Title "Recent and Current Abnormal Warnings and Error Events"
    }
    else {
        Write-Host "No abnormal events found." -ForegroundColor Green
    }
}

# Generate Baseline Report
function try_csv_xlsx {

    Write-Host " "
    Write-Host '### Generating "Device Information"、"Event Summary"、"Activity Records"、and "Windows Defender Threat Overview" analysis reports ###' -ForegroundColor Cyan; Write-Host " "

    # Check if PowerShell version supports ImportExcel module
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        Write-Host "The current PowerShell version does not support the ImportExcel module. Please upgrade to PowerShell version 5 or higher." -ForegroundColor Red
        return
    }

    # Attempt to install ImportExcel module
    try {
        if (!(Get-Module -Name ImportExcel -ListAvailable)) {
            Install-Module ImportExcel -Force
        }
    }
    catch {
        Write-Host "Failed to install the ImportExcel module$i; please ensure the network is functioning properly:" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        return
    }


    # Get the current user's Desktop directory path, more portable than ${env:username}/desktop
    $desktop_path = [Environment]::GetFolderPath('Desktop')
    $report_path = Join-Path $desktop_path ((Get-Date).ToString('yyyy-MM-dd') + 'Baseline_Check_Report.xlsx')

    Write-Host "`nDevice information and warning event summary are being generated. Please wait a few minutes... `n" -ForegroundColor Yellow

    # Device driver information
    #  -ErrorAction SilentlyContinue
    $result = Get-PnpDevice | Select-Object `
        Class, FriendlyName, Problem, `
        Status, ConfigManagerUserConfig, SystemName, `
        ClassGuid, Manufacturer, Present, Service

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "Device Driver Info"
        Write-Host "Driver information summary completed" -ForegroundColor Green
    }
    else {
        Write-Host 'No matching information found. Please check account permissions, event log settings, etc.'
    }

    # Write-Host "`nGenerating statistics on important events for today up to this point...`n" -ForegroundColor Yellow
    # # Event ID, see：https://github.com/Excalibra/scripts/blob/main/AQUICK/BITRH/Win10_Events_ID_useful.xlsx
    # $result = Get-WinEvent -FilterHashtable @{
    #     LogName   = 'Application', 'System', 'Security'
    #     StartTime = (Get-Date).Date
    # } | Where-Object { $_.LevelDisplayName -in "Error", "Warning", "Critical"
    # } | Select-Object Message, Id, Level, ProviderName, LogName, `
    #     TimeCreated, LevelDisplayName | Where-Object {
    #     $_.LevelDisplayName -in "Error","Warning","Critical" `
    #     -and $_.Id -notin 134, 1014, 8233, 10010, 10016, 6155 `
    #     -or $_.Id -in 4648, 4634, 4199, 6013, 4803, 4802, 4800, 4801
    # }

    Write-Host "`nCurrently compiling important events from the past five days. This may take some time, so please be patient...`n" -ForegroundColor Yellow
    # Event ID, see: https://github.com/Excalibra/scripts/blob/main/AQUICK/BITRH/Win10_Events_ID_useful.xlsx
    # Subsequent reference: https://learn.microsoft.com/en-us/answers/questions/961608/event-id-6155-(the-lsa-package-is-not-signed-as-ex

    $elapsedTime = (Measure-Command {
        $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = (Get-Date).Date.AddDays(-5).AddHours(8.5)
        EndTime   = (Get-Date)
    } | Where-Object {
        $_.LevelDisplayName -in "Error","Critical"
    } | Select-Object Id, Level, ProviderName, LogName, `
        TimeCreated, LevelDisplayName, Message, @{Name="TaskDisplayName"; Expression={If($_.TaskDisplayName){$_.TaskDisplayName}else{'N/A'}}}

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName '预警事件汇总'
    }
    else {
        Write-Host 'No “Warning”、“Error”、or “Critical” events found in the last five days. All is normal, so this report was not generated.' -ForegroundColor Green
    }
}).TotalSeconds

    Write-Host "Filtered and processed important events from the last five days in ${elapsedTime} seconds." -ForegroundColor Yellow

    Write-Host "`nAppending logon/logoff activity records from the past week and system power usage reports from the last three days...`n"

    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = (Get-Date).Date.AddDays(-7)
    } | Where-Object {
        ($_.Id -in 4648, 4634)
    } |Select-Object MachineName, Id, Level, ProviderName, LogName,  `
    TimeCreated, ContainerLog, LevelDisplayName, TaskDisplayName

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "Logon and Logoff Activity"
    }
    else {
        Write-Host 'No matching entries found. Please check system permissions, event logs, etc.' -ForegroundColor Red
    }

    powercfg /spr /duration 3

    # SQLlite with Get-MpThreatDetection and Get-MpThreat for better threat data
    # Using Excel to import security threat detection statistics

    # Threat detection records for the past 30 days
    Write-Host " "
    Write-Host 'Detecting stored threats and generating a monthly overview report (if no threats, this report will not be generated)' -ForegroundColor Yellow

    $result = Get-MpThreatDetection `
    | Select-Object ActionSuccess, CurrentThreatExecutionStatusID, `
        DetectionID, DetectionSourceTypeID,	DomainUser,	InitialDetectionTime, LastThreatStatusChangeTime, `
        ProcessName, ThreatID, ThreatStatusID

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "Threat Detection Records"
    }
    else {
        Write-Host 'No threat events detected. Possible reasons: third-party antivirus software taking control, or Windows Defender is not enabled.' -ForegroundColor Magenta
    }

    # Threat categories in the last 30 days
    $result = Get-MpThreat `
    | Select-Object CategoryID, DidThreatExecute, IsActive, RollupStatus, `
        SeverityID, ThreatID, ThreatName

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "Threat Category Details"
    }
    else {
        Write-Host 'No threat events detected. Possible reasons: third-party antivirus took over, or Windows Defender is not enabled.' -ForegroundColor Magenta
    }

    Write-Host " "
    Write-Host '### Baseline check report has been generated. Please check the desktop location.' -ForegroundColor Green; Write-Host "`n"

}


# switch
function select_option {

    # Instructions
    sel_man

    $valid_option = $true
    $has_checked_sys = $false

    while ($valid_option) {

        # Virtual key codes and corresponding keyboard keys reference
        # https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            { $_ -in 49, 97 } {
                # Number key 1 and numeric keypad 1
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_ip
            }
            { $_ -in 50, 98 } {
                # Number key 2 and numeric keypad 2
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_printer
            }
            { $_ -in 51, 99 } {
                # Number key 3 and numeric keypad 3
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_disk_cpu_mem
            }
            { $_ -in 52, 100 } {
                # Number key 4 and numeric keypad 4
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_fw
            }
            { $_ -in 53, 101 } {
                # Number key 5 and numeric keypad 5
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_share
            }
            { $_ -in 54, 102 } {
                # Number key 6 and numeric keypad 6
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_key_events
            }
            { $_ -in 55, 103 } {
                # Number key 7 and numeric keypad 7
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_ip
                check_printer
                check_fw
                check_disk_cpu_mem
                check_key_events
            }
            { $_ -in 56, 104 } {
                # Number key 8 and numeric keypad 8
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                try_csv_xlsx
            }
            { $_ -in 57, 105 } {
                # Number key 9 and numeric keypad 9
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                dev_man
            }
            191 {
                # Keyboard /?
                # Remote call
                # Invoke-Expression ((New-Object Net.WebClient).DownloadString($url));$function
                sel_man
            }
            Default {
                # $valid_option = $false
                continue
            }
        }
    }
}

select_option
