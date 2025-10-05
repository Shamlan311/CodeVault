Dim count
count = 0

Do
    If count < 5 Then
        MsgBox "Your PC is hacked...", vbCritical, "Error"
        count = count + 1
    Else
        MsgBox "YOUR PC IS HACKED, DO NOT TRY TO CLOSE IT", vbCritical, "Fatal Error"
    End If
Loop
