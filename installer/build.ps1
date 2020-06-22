mkdir -Force Work, Output | Out-Null

Copy-Item -Force product.wxs.tmpl product.wxs

Copy-Item ../main.ps1 Work -Force
Copy-Item ../run_once.ps1 Work -Force
Copy-Item ../run_once.vbs Work -Force
Copy-Item ../quser.psm1 Work -Force

$guid1=(new-guid).guid
$guid2=(new-guid).guid

(Get-Content product.wxs) `
 -replace 'Title="PUT-FEATURE-TITLE-HERE"', 'Title="MyFeatureTitleName"' `
 -replace 'PUT-PRODUCT-NAME-HERE', 'MyProductName' `
 -replace 'PUT-COMPANY-NAME-HERE', 'MyCompanyName' `
 -replace 'UpgradeCode="PUT-GUID-HERE"', "UpgradeCode=`"$guid1`"" `
 -replace 'Id="PUT-GUID-HERE"', "Id=`"$guid2`"" | Set-Content -Path product.wxs

heat.exe dir Work -var var.SourceFilesDir -out components.wxs `
 -cg MyComponentGroup -dr APPLICATIONROOTDIRECTORY -g1 -gg -srd -nologo

candle.exe -nologo -dSourceFilesDir=Work components.wxs
candle.exe -nologo product.wxs

light.exe -nologo -ext WixUIExtension components.wixobj product.wixobj -out Output/product.msi
