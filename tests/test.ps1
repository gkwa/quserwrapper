Import-Module Pester -MinimumVersion 5.0.2

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\config.ps1"
$PesterPreference = $pesterConfig

Try {
    $result = Invoke-Pester
}
Catch {
    Write-Host "last exit code: $LASTEXITCODE"
}
Finally {
    if ($env:APPVEYOR_JOB_ID) {
        (New-Object "System.Net.WebClient").UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path ".\testResults.xml"))
    }
    exit 0
}
