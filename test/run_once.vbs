Dim shell,command
command = "pwsh.exe -nologo -File .\run_once.ps1"
Set shell = CreateObject("WScript.Shell")
shell.Run command,0
