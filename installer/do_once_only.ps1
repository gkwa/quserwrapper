$guid1=(new-guid).guid
$guid2=(new-guid).guid

(Get-Content product.wxs) `
 -replace 'Title="PUT-FEATURE-TITLE-HERE"', 'Title="MyFeatureTitleName"' `
 -replace 'PUT-PRODUCT-NAME-HERE', 'MyProductName' `
 -replace 'PUT-COMPANY-NAME-HERE', 'MyCompanyName' `
 -replace 'UpgradeCode="PUT-GUID-HERE"', "UpgradeCode=`"$guid1`"" `
 -replace 'Id="PUT-GUID-HERE"', "Id=`"$guid2`"" | Set-Content -Path product.wxs
