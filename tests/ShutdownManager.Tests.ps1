using module 'C:\Users\Administrator\quserwrapper\deploy\quser.psm1'

# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# . "$here\Add-Numbers.ps1"

Describe "ShutdownManager" {
    It "does something useful" {
        $s = New-Object ShutdownManager
    }
}
