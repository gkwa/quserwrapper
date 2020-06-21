Import-Module .\SampleModule1.psm1

Describe "MyTest" {
    It "does something useful" {
        $s = New-Object SampleClass1
    }
}
