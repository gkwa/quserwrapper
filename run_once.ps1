using module .\quser.psm1

$MaxIdle = New-TimeSpan -Hours 1
$quser = New-Object Quserwrapper
$shutdownManger = New-Object ShutdownManager

$quser.Check()
$quser.GetIdle()
Write-Output "You've been idle $($quser.idle) minutes"
$IdleTime = New-TimeSpan -Minutes $quser.idle
if ($IdleTime -gt $MaxIdle) {
    $shutdownManger.shutdown()
}
else {
    $shutdownManger.cancel()
}
