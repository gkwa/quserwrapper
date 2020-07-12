using module .\quser.psm1

$MaxIdleTS = New-TimeSpan -Hours 1
$Quser = New-Object Quserwrapper
$ShutdownManger = New-Object ShutdownManager

$Quser.Check()
$Quser.GetIdle()
Write-Output "You've been idle $($Quser.idle) minutes"
$IdleTime = New-TimeSpan -Minutes $Quser.idle
if ($IdleTime -gt $MaxIdleTS) {
    $ShutdownManger.shutdown()
}
else {
    $ShutdownManger.cancel()
}
