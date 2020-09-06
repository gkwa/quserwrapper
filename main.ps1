using module .\quser.psm1

# TODO: installer: add scheduled task
# TODO: installer: automate Install-Module Logging

Import-Module Logging

Set-LoggingDefaultLevel -Level 'DEBUG'
Add-LoggingTarget -Name Console
Add-LoggingTarget -Name File -Configuration @{Path = 'quserwrapper_%{+%Y%m%d}.log'}

$MaxIdle = New-TimeSpan -Hours 1
$qs = New-Object Quserwrapper
$ShutdownManger = New-Object ShutdownManager

$qs.RunQuser()
$idle = $qs.GetIdle($qs.stdout)
Write-Log -Level 'DEBUG' -Message "You've been idle $idle minutes"
if ($idle -gt $MaxIdle) {
    Write-Log -Level 'DEBUG' -Message "Shutdown initiated because $MaxIdle has been reached"
    $ShutdownManger.shutdown()
}
else {
    $ShutdownManger.cancel()
}
