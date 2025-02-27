@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit & cd /d "%~dp0"

@echo off
setlocal
:menu
echo.
echo ***********************************************
echo MD5, SHA1, SHA256 Hash Calculation, Comparison, and Verification Tool
echo.
echo by https://github.com/Excalibra
echo.
echo Options
echo [1]. Calculate MD5, SHA1, SHA256 hash of a file.
echo [2]. Compare MD5, SHA1, SHA256 hash of two files.
echo [3]. Verify MD5, SHA1, SHA256 hash of a file.
echo [4]. Refresh and return to the menu.
echo.
echo ***********************************************
echo.
goto :select

:select
set /p choice=Please enter the option number:
set "match=false"

if "%choice%"=="1" (
    set /p filePath=Please enter the file path:
    call :calcHash "%filePath%"
    goto select
) else if "%choice%"=="2" (
    set /p filePath1=Please enter the first file path:
    set /p filePath2=Please enter the second file path:
    call :compareHash "%filePath1%" "%filePath2%"
    goto select
) else if "%choice%"=="3" (
    set /p hashcode=Please enter the hash value:
    set /p filePathS=Please enter the file path:
    call :verifyHash "%hashcode%" "%filePathS%"
    goto select
) else if "%choice%"=="4" (
    cls
    goto menu
) else (
    echo Invalid option.
    goto menu
)
exit /b


:calcHash
rem Calculate MD5, SHA1, SHA256 hash of a file
for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% MD5') do (
    set "md5Hash=%%a"
    goto :calcMD5
)
:calcMD5
echo MD5 Hash: %md5Hash%

for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% SHA1') do (
    set "sha1Hash=%%a"
    goto :calcSHA1
)
:calcSHA1
echo SHA1 Hash: %sha1Hash%

for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% SHA256') do (
    set "sha256Hash=%%a"
    goto :calcSHA256
)
:calcSHA256
echo SHA256 Hash: %sha256Hash%
echo.
exit /b

:compareHash
echo.
for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile "%filePath1%" MD5') do (
    set "md5Hash1=%%a"
    for /f "skip=1 tokens=* delims=" %%b in ('certutil -hashfile "%filePath2%" MD5') do (
    set "md5Hash2=%%b"
        for /f "skip=1 tokens=* delims=" %%c in ('certutil -hashfile "%filePath1%" SHA1') do (
            set "sha1Hash1=%%c"
                    for /f "skip=1 tokens=* delims=" %%d in ('certutil -hashfile "%filePath2%" SHA1') do (
            set "sha1Hash2=%%d"
            for /f "skip=1 tokens=* delims=" %%e in ('certutil -hashfile "%filePath1%" SHA256') do (
                set "sha256Hash1=%%e"
                for /f "skip=1 tokens=* delims=" %%f in ('certutil -hashfile "%filePath2%" SHA256') do (
                set "sha256Hash2=%%f"
                goto :compareAllHash
                )
            )
            )
    )
    )
    )
)

:compareAllHash
if "%md5Hash1%"=="%md5Hash2%" (
    echo.
    echo The MD5 hash values of the two files are the same.
    echo %md5Hash1%
    echo %md5Hash2%
    set "match=true"
) else (
    echo.
    echo The MD5 hash values of the two files are different.
    echo %md5Hash1%
    echo %md5Hash2%
)

if "%sha1Hash1%"=="%sha1Hash2%" (
    echo.
    echo The SHA1 hash values of the two files are the same.
    echo %sha1Hash1%
    echo %sha1Hash2%
    set "match=true"
) else (
    echo.
    echo The SHA1 hash values of the two files are different.
    echo %sha1Hash1%
    echo %sha1Hash2%
)


if "%sha256Hash1%"=="%sha256Hash2%" (
    echo.
    echo The SHA256 hash values of the two files are the same.
    echo %sha256Hash1%
    echo %sha256Hash2%
    set "match=true"
    echo.
) else (
    echo.
    echo The SHA256 hash values of the two files are different.
    echo %sha256Hash1%
    echo %sha256Hash2%
    echo.
)


:verifyHash
echo.
for /f "skip=1 tokens=* delims=" %%g in ('certutil -hashfile "%filePathS%" MD5') do (
    set "jy_md5Hash=%%g"
        for /f "skip=1 tokens=* delims=" %%h in ('certutil -hashfile "%filePathS%" SHA1') do (
            set "jy_sha1Hash=%%h"
            for /f "skip=1 tokens=* delims=" %%i in ('certutil -hashfile "%filePathS%" SHA256') do (
                set "jy_sha256Hash=%%i"
                goto :verifyAllHash
                )
            )
         )
    )
)

:verifyAllHash
if "%jy_md5Hash%"=="%hashcode%" (
    echo The MD5 hash values match.
    echo %jy_md5Hash%
    echo %hashcode%
    echo.
    set "match=true"
)
if "%jy_sha1Hash%"=="%hashcode%" (
    echo The SHA1 hash values match.
    echo %jy_sha1Hash%
    echo %hashcode%
    echo.
    set "match=true"
)
if "%jy_sha256Hash%"=="%hashcode%" (
    echo The SHA256 hash values match.
    echo %jy_sha256Hash%
    echo %hashcode%
    echo.
    set "match=true"
)

if "%match%"=="false" (
    echo MD5, SHA1, and SHA256 hash values do not match.
    echo.
)
