mkdir -Force Work, Output | Out-Null

Copy-Item ../main.ps1 Work -Force
Copy-Item ../quser.psm1 Work -Force
Copy-Item ../run_once.ps1 Work -Force
Copy-Item ../run_once.vbs Work -Force

candle.exe -nologo -ext WixUtilExtension -out test.wixobj -dVersion=1 test.wxs
# light.exe -out test.msi -sval test.wixobj -ext WixUIExtension