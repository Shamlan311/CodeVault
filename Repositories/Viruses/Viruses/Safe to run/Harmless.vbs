Option Explicit
Dim message, title
message = "Hi, I am a virus but because of poor technology in my country unfortunatley I am not able to harm your PC. Please be kind to delete one of your important files yourself and then forward me to other users. Thanks for your cooperation! Best regards, Virus"
title = "Virus Alert!"

do
MsgBox message, vbCritical, title
loop
