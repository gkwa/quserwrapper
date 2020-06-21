mkdir -Force Work, Output | Out-Null

Copy-Item ../main.ps1 Work -Force
Copy-Item ../run_once.ps1 Work -Force
Copy-Item ../run_once.vbs Work -Force
Copy-Item ../quser.psm1 Work -Force

$guid1=(new-guid).guid
$guid2=(new-guid).guid

candle.exe -nologo quserwrapper.wxs 
light.exe -nologo -ext WixUIExtension quserwrapper.wixobj -out Output/quserwrapper.msi
