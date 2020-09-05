BeforeAll {
    # DON'T use $MyInvocation.MyCommand.Path
    . $PSCommandPath.Replace("Quserwrapper.Tests.ps1","setup.ps1")
}

Describe "Get-Cactus" {
    It "Returns 🌵" {
        $Quser = New-Object Quserwrapper
        $Quser.Check()
    }
}
