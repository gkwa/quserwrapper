$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Install" {
    It "verify product was installed into correct directory" {
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.ps1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.ps1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\quser.psm1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.vbs" | Should -Be $true
    }
}

Describe "Uninstall" {
    It "verify files and directory no longer exist" {
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName" | Should -Be $false
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.ps1" | Should -Be $false
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.ps1" | Should -Be $false
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\quser.psm1" | Should -Be $false
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.vbs" | Should -Be $false
    }
}
