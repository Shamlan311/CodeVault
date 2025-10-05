@echo off
setlocal EnableExtensions EnableDelayedExpansion

echo.
echo ===== Saved Wi-Fi Profiles & Passwords =====
echo.

set "found="

REM Grab all profile names
for /f "tokens=2 delims=:" %%A in ('
  netsh wlan show profiles ^| findstr /R /C:"All User Profile" /C:"User Profile"
') do (
  set "ssid=%%A"
  set "ssid=!ssid:~1!"
  set "found=1"
  call :ShowPass "!ssid!"
)

if not defined found (
  echo No Wi-Fi profiles found on this machine.
)

goto :eof

:ShowPass
setlocal EnableDelayedExpansion
set "ssid=%~1"
set "pwd="

for /f "tokens=2,* delims=:" %%B in ('
  netsh wlan show profile name^="%ssid%" key^=clear ^| findstr /C:"Key Content"
') do (
  set "pwd=%%C"
  set "pwd=!pwd:~1!"
)

echo SSID     : %ssid%
if defined pwd (
  echo Password : %pwd%
) else (
  echo Password : (open network or not stored)
)
echo.

endlocal
pause>nul
