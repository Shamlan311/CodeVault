@echo off

powershell -Command "Write-Host '[DISCLAIMER]:' -ForegroundColor Red -NoNewline; Write-Host ' The author is not responsible for anything you do with this code or for any misuse.'"

set "__COMPAT_LAYER=RunAsInvoker"

if "%~1"=="" (
    powershell -Command "Write-Host '[ERROR]:' -ForegroundColor Red -NoNewline; Write-Host ' No program specified.'; Write-Host 'Usage: Drag and drop a program onto this batch file or run: %~nx0 \"PathToProgram.exe\"'"
    exit /b
)

echo.
echo Enjoy your app!!

start "" /wait "%~1"
exit
