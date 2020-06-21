mkdir -Force Work, Output | Out-Null

mkdir 'C:\Program Files\Streambox\Quserwrapper' -Force | Out-Null

Copy-Item ../main.ps1 'C:\Program Files\Streambox\Quserwrapper' -Force
Copy-Item ../run_once.ps1 'C:\Program Files\Streambox\Quserwrapper' -Force
Copy-Item ../run_once.vbs 'C:\Program Files\Streambox\Quserwrapper' -Force
Copy-Item ../quser.psm1 'C:\Program Files\Streambox\Quserwrapper' -Force

$guid1=(new-guid).guid
$guid2=(new-guid).guid

# heat.exe dir Work -cg MyComponentGroup -gg -sfrag -srd -dr INSTALLLOCATION -var var.SourceFilesDir -out fragments.wxs
# heat.exe dir Work -nologo -cg MyComponentGroup -dr INSTALLFOLDER -gg -srd  -var var.SourceFilesDir -out Components.wxs
# heat.exe dir Work -nologo -template product -out test.wxs
# heat.exe dir Work -nologo -ag -sfrag -scom -sreg -template product -var var.SourceFilesDir -out product.wxs
# heat.exe dir Work -nologo -out test.wxs
# (Get-Content product.wxs) `
#  -replace 'Title="PUT-FEATURE-TITLE-HERE"', 'Title="Quserwrapper"' `
#  -replace 'PUT-PRODUCT-NAME-HERE', 'Quserwrapper' `
#  -replace 'PUT-COMPANY-NAME-HERE', 'Streambox' `
#  -replace 'UpgradeCode="PUT-GUID-HERE"', "UpgradeCode=`"$guid1`"" `
#  -replace 'Id="PUT-GUID-HERE"', "Id=`"$guid2`"" | Set-Content -Path product.wxs
 
heat.exe dir 'C:\Program Files\Streambox\Quserwrapper' -nologo -srd -sreg -gg -cg projectdir -dr projectlocation -var "var.projectsourcedir" -out project-files.wxs
candle.exe -nologo -arch x86 -dprojectsourcedir="c:\program files\Streambox\Quserwrapper" project-files.wxs