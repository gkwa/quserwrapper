using module .\SampleModule1.psm1
class SampleClass2 {
    $Property1 = [SampleModule1.SampleClass1]::new().Property1
}
