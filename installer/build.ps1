mkdir -Force Work, Output | Out-Null
Copy-Item ../main.ps1 Work -Force
Copy-Item ../quser.psm1 Work -Force
candle.exe -nologo -ext WixUtilExtension -out Work\test.wixobj -dVersion=1 test.wxs