mkdir -Force Work, Output | Out-Null

Copy-Item ../main.ps1 Work -Force
Copy-Item ../run_once.ps1 Work -Force
Copy-Item ../run_once.vbs Work -Force
Copy-Item ../quser.psm1 Work -Force

candle.exe -nologo product.wxs 
light.exe -nologo -ext WixUIExtension product.wixobj -out Output/product.msi
