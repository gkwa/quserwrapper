BeforeAll {
    # DON'T use $MyInvocation.MyCommand.Path
    . $PSCommandPath.Replace("Quserwrapper.Tests.ps1","setup.ps1")
}

Describe "GetIdle" {
    It "Converts 8 minutes idle time" {
        $Quser = New-Object Quserwrapper

        $line = @"
     USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME 
     administrator         rdp-tcp#2           2  Active          8  9/5/2020 8:21 PM 
"@
        $ts = New-Timespan -Minutes 8
        $Quser.GetIdle($line) | Should -Be $ts
    }

    It "Converts '.' to 0 minutes idle time" {
        $Quser = New-Object Quserwrapper

        $line = @"
     USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME 
     administrator         rdp-tcp#2           2  Active          .  9/5/2020 8:21 PM 
"@
        $ts = New-Timespan -Minutes 0
        $Quser.GetIdle($line) | Should -Be $ts
    }

    It "Converts 10:1 to idle time 10 hours +1 minute" {
        $Quser = New-Object Quserwrapper

        $line = @"
     USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME 
     administrator         rdp-tcp#2           2  Active       10:1  9/5/2020 8:21 PM 
"@
        $ts = New-Timespan -Hours 10 -Minutes 1
        $Quser.GetIdle($line) | Should -Be $ts
    }

    It "Converts 2:10:1 to 58 hours + 1 minute" {
        $Quser = New-Object Quserwrapper

        $line = @"
     USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME 
     administrator         rdp-tcp#2           2  Active    02:10:1  9/5/2020 8:21 PM 
"@
        $ts = New-Timespan -Hours 58 -Minutes 1
        $Quser.GetIdle($line) | Should -Be $ts
    }
}
