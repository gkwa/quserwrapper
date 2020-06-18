Class Quser {
    [int]$idle = 0
    [string[]]$stdout
    [string[]]$stderr
    [System.Diagnostics.Eventlog]$evt 
    
    Quser() {
        $this.evt = new-object System.Diagnostics.Eventlog("Application")
        $this.evt.Source = "Quserwrapper"
    }

    GetIdle() {
        $quserRegex = $this.stdout | ForEach-Object -Process { $_ -replace '\s{2,}', ',' }
        $quserObject = $quserRegex | ConvertFrom-Csv
        $y = $quserObject."IDLE TIME"
        if ('.' -eq $y) {
            # Write-Host "you are active"
        }
        else { 
            [Int32]$number = 0
            if ([Int32]::TryParse($quserObject.'IDLE TIME', [ref]$number)) {
                $this.idle = $number
                $this.evt.WriteEntry("Idle $($this.idle) minutes", [System.Diagnostics.EventLogEntryType]::Information, 100)
            }
            else { 
                Write-Host "Not a Number"
                 
            }
        }
    }
    Check() {
        $pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $pinfo.FileName = "quser"
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        #$pinfo.Arguments = "localhost"
        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        


        # Write-EventLog -LogName "Application" -Source "Quserwrapper" -EventID 100 -EntryType Information -Message "Quserwrapper." -Category 1 -RawData 10, 20
        try {
            $p.Start() | Out-Null
            $p.WaitForExit()
            $this.stdout = $p.StandardOutput.ReadToEnd().split([Environment]::NewLine)
            $this.stderr = $p.StandardError.ReadToEnd().split([Environment]::NewLine)
        }
        catch [System.Management.Automation.MethodInvocationException] {
            Write-Host "Can't find $($pinfo.FileName) command"
        }
    }
}

$MaxIdle = New-TimeSpan -Hours 1

While ($true) {
    $quser = New-Object Quser
    $quser.Check()
    $quser.GetIdle()
    Write-Output "You've been idle $($quser.idle) minutes"
    $IdleTime = New-TimeSpan -Minutes $quser.idle
    if ($IdleTime -gt $MaxIdle) {
        shutdown -t 30 -s -c "shutting down in 30 minutes triggered off taskschd"
    }
    Sleep -s 60
}
