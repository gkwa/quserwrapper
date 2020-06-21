Copy-Item ../main.ps1 Work -Force
Copy-Item ../quser.psm1 Work -Force

$guid1=(new-guid).guid
$guid2=(new-guid).guid

heat.exe dir Work -nologo -ag -cg myCG -sreg -template product -out test.wxs
(Get-Content test.wxs) `
 -replace 'Title="PUT-FEATURE-TITLE-HERE"', 'Title="Quserwrapper"' `
 -replace 'PUT-PRODUCT-NAME-HERE', 'Quserwrapper' `
 -replace 'PUT-COMPANY-NAME-HERE', 'Streambox' `
 -replace 'UpgradeCode="PUT-GUID-HERE"', "UpgradeCode=`"{$guid1}`"" `
 -replace 'Id="PUT-GUID-HERE"', "Id=`"{$guid2}`"" | Set-Content -Path test.wxs
