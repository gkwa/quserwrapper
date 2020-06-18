class ShutdownManager {
    [int]$idle = 0
    [string[]]$stdout
    [string[]]$stderr
    [int]$minutes = 30
    [string]$message = "shutting down in 30 minutes triggered off taskschd"
    [System.Diagnostics.Eventlog]$evt 
    [System.Diagnostics.ProcessStartInfo]$pinfo
    [System.Diagnostics.Process]$process

    ShutdownManager() {
        $this.evt = new-object System.Diagnostics.Eventlog("Application")
        $this.evt.Source = "ShutdownManger"
        $this.pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $this.pinfo.FileName = "shutdown"
        $this.pinfo.RedirectStandardError = $true
        $this.pinfo.RedirectStandardOutput = $true
        $this.pinfo.UseShellExecute = $false
        $this.process = New-Object System.Diagnostics.Process
        $this.pinfo.Arguments = "-t $($this.minutes) -s -c '$($this.message)'"
        $this.pinfo.Arguments = "-t $($this.minutes) -s"
        $this.pinfo.Arguments = "-t 30 -s -c mytest"
        $this.pinfo.Arguments = "-t 30 -s -c '$($this.message)'"
        # $this.pinfo.Arguments = "-t 30 -s -c $this.message"
        # $this.pinfo.Arguments = "-t 30 -s -c test"
        $this.process.StartInfo = $this.pinfo
    }
    run() {
        $this.process.Start() | Out-Null
        # $this.process.WaitForExit()
        $this.stdout = $this.process.StandardOutput.ReadToEnd()
        $this.stderr = $this.process.StandardError.ReadToEnd()
        $this.evt.WriteEntry($this.stdout, [System.Diagnostics.EventLogEntryType]::Information, 100)
        $this.evt.WriteEntry($this.stderr, [System.Diagnostics.EventLogEntryType]::Information, 100)
    }
}


Class Quserwrapper {
    [int]$idle = 0
    [string[]]$stdout
    [string[]]$stderr
    [System.Diagnostics.Eventlog]$evt 
    [System.Diagnostics.ProcessStartInfo]$pinfo
    [System.Diagnostics.Process]$process

    Quserwrapper() {
        $this.evt = new-object System.Diagnostics.Eventlog("Application")
        $this.evt.Source = "Quserwrapper"
        $this.pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $this.pinfo.FileName = "quser"
        $this.pinfo.RedirectStandardError = $true
        $this.pinfo.RedirectStandardOutput = $true
        $this.pinfo.UseShellExecute = $false
        $this.process = New-Object System.Diagnostics.Process
        $this.process.StartInfo = $this.pinfo
    }

    GetIdle() {
        $quserRegex = $this.stdout | ForEach-Object -Process { $_ -replace '\s{2,}', ',' }
        $quserObject = $quserRegex | ConvertFrom-Csv
        $y = $quserObject."IDLE TIME"
        if ('.' -eq $y) {
            $this.evt.WriteEntry("Active", [System.Diagnostics.EventLogEntryType]::Information, 100)
            $this.idle = 0
        }
        else { 
            [Int32]$number = 0
            if ([Int32]::TryParse($quserObject.'IDLE TIME', [ref]$number)) {
                $this.idle = $number
                $this.evt.WriteEntry("Idle $($number) minutes", [System.Diagnostics.EventLogEntryType]::Information, 200)
            }
            else { 
                $this.evt.WriteEntry("Unexpected idle time $($quserObject.'IDLE TIME')", [System.Diagnostics.EventLogEntryType]::Information, 300)
            }
        }
    }
    Check() {
        try {
            $this.process.Start() | Out-Null
            $this.process.WaitForExit()
            $this.stdout = $this.process.StandardOutput.ReadToEnd().split([Environment]::NewLine)
            $this.stderr = $this.process.StandardError.ReadToEnd().split([Environment]::NewLine)
        }
        catch [System.Management.Automation.MethodInvocationException] {
            Write-Host "Can't find $($this.pinfo.FileName) command"
        }
    }
}

# $MaxIdle = New-TimeSpan -Hours 1
# $MaxIdle = New-TimeSpan -Minutes 2
# $quser = New-Object Quserwrapper
# $shutdownManger = New-Object ShutdownManager

# While ($true) {
#     $quser.Check()
#     $quser.GetIdle()
#     Write-Output "You've been idle $($quser.idle) minutes"
#     $IdleTime = New-TimeSpan -Minutes $quser.idle
#     if ($IdleTime -gt $MaxIdle) {
#         $shutdownManger.run()
#     }
#     Sleep -s 60
# }
