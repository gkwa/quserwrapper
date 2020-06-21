(Get-Content quserwrapper.wxs) `
 -replace 'Title="PUT-FEATURE-TITLE-HERE"', 'Title="Quserwrapper"' `
 -replace 'PUT-PRODUCT-NAME-HERE', 'Quserwrapper' `
 -replace 'PUT-COMPANY-NAME-HERE', 'Streambox' `
 -replace 'UpgradeCode="PUT-GUID-HERE"', "UpgradeCode=`"$guid1`"" `
 -replace 'Id="PUT-GUID-HERE"', "Id=`"$guid2`"" | Set-Content -Path quserwrapper.wxs
