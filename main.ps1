using module .\quser.psm1

$MaxIdle = New-TimeSpan -Hours 1
$MaxIdle = New-TimeSpan -Seconds 10
$quser = New-Object Quserwrapper
$shutdownManger = New-Object ShutdownManager

While ($true) {
    $quser.Check()
    $quser.GetIdle()
    Write-Output "You've been idle $($quser.idle) minutes"
    $IdleTime = New-TimeSpan -Minutes $quser.idle
    if ($IdleTime -gt $MaxIdle) {
        $shutdownManger.shutdown()
    }else{
        $shutdownManger.cancel()
    }
    Sleep -s 15
}
