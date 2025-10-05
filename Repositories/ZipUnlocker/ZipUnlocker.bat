@echo off
title ZipUnlocker - Shamlan
color 0F
setlocal enabledelayedexpansion

:: Check for available extraction tools
set "tool="
if exist "C:\Program Files\7-Zip\7z.exe" (
    set "tool=7z"
) else if exist "C:\Program Files\WinRAR\UnRAR.exe" (
    set "tool=rar"
)

if not defined tool (
    echo Neither 7-Zip nor WinRAR found!
    echo Please install 7-Zip or WinRAR and try again.
    pause
    exit /b 1
)

:: Display available tools
echo Available tools:
if exist "C:\Program Files\7-Zip\7z.exe" echo [1] 7-Zip
if exist "C:\Program Files\WinRAR\UnRAR.exe" echo [2] WinRAR
echo.

:: Tool selection
set /p "select=Select tool (1/2): "
if !select!==1 if exist "C:\Program Files\7-Zip\7z.exe" (
    set "tool=7z"
    set "exe=C:\Program Files\7-Zip\7z.exe"
)
if !select!==2 if exist "C:\Program Files\WinRAR\UnRAR.exe" (
    set "tool=rar"
    set "exe=C:\Program Files\WinRAR\UnRAR.exe"
)

if not defined exe (
    echo Invalid selection or tool not available.
    pause
    exit /b 1
)

:: Input handling
set /p "archive=Enter archive path: "
if not exist "%archive%" (
    echo Archive not found!
    pause
    exit /b 1
)

set /p "wordlist=Enter wordlist path: "
if not exist "%wordlist%" (
    echo Wordlist not found!
    pause
    exit /b 1
)

:: Cracking process
echo Starting cracking attempt...
if not exist cracked md cracked

for /f "usebackq delims=" %%p in ("%wordlist%") do (
    set "pass=%%p"
    if "!tool!"=="7z" (
        "!exe!" x -p"!pass!" -o"cracked" -y -- "%archive%" >nul 2>&1
    ) else (
        "!exe!" x -p"!pass!" -- "%archive%" "cracked\" >nul 2>&1
    )
    
    if !errorlevel! equ 0 (
        echo.
        echo SUCCESS: Password found - "!pass!"
        echo Contents extracted to 'cracked' folder.
        pause
        exit /b 0
    )
    echo Trying: !pass!
)

echo.
echo Password not found in wordlist.
pause
exit /b 1
