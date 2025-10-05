Set WshShell = CreateObject("WScript.Shell")
For i = 1 To 10000000
    WshShell.Popup "Don't try to close this.", 1, "Alert:", 64
Next
