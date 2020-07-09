Dim shell,command
command = "pwsh.exe -nologo -File .\main.ps1"
Set shell = CreateObject("WScript.Shell")
shell.Run command,0
