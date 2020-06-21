$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Clean" {
    It "verify product was installed into correct directory" {
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName" | Should -Be $true
    }
}

Describe "Clean" {
    It "verify file exists" {
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\main.ps1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\run_once.ps1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\quser.psm1" | Should -Be $true
        Test-Path "C:\Program Files (x86)\MyCompanyName\MyProductName\run_once.vbs" | Should -Be $true
    }
}
