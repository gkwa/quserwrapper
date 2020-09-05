$pesterConfig = [PesterConfiguration]@{
    Run          = @{
        Path     = ".\tests"
        Exit     = $true
        PassThru = $false
    }
    CodeCoverage = @{
        Enable       = $true
        OutputFormat = "NUnitXml"
        OutputPath   = ".\coverage.xml"
    }
    TestResult   = @{
        Enabled    = $true
        OutputPath = ".\testResults.xml"
    }
    Output       = @{
        Verbosity = "Detailed"
    }
}
