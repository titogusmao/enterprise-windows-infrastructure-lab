
#Requires -Version 5.1
# Get-ADHealthReport.ps1
# Enterprise Windows Infrastructure Lab
# Purpose: Perform basic Active Directory health checks.
# Run locally on a Domain Controller with administrative privileges.

$ErrorActionPreference = "Stop"

$ReportDir = "C:\LabScripts\Reports"
New-Item -ItemType Directory -Path $ReportDir -Force | Out-Null

$TimeStamp = Get-Date -Format "yyyyMMdd-HHmmss"
$CsvPath = Join-Path $ReportDir "ADHealth-$TimeStamp.csv"
$DcdiagPath = Join-Path $ReportDir "DCDiag-$TimeStamp.txt"

$Results = [System.Collections.Generic.List[object]]::new()

function Add-CheckResult {
    param(
        [string]$Check,
        [string]$Status,
        [string]$Details
    )

    $Results.Add([PSCustomObject]@{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Computer  = $env:COMPUTERNAME
        Check     = $Check
        Status    = $Status
        Details   = $Details
    })
}

Write-Host "`n=== Active Directory Health Check ===" -ForegroundColor Cyan
Write-Host "Server: $env:COMPUTERNAME"

# 1. Check essential services
$Services = @("NTDS", "DNS", "Netlogon", "KDC", "W32Time", "DFSR")

foreach ($ServiceName in $Services) {
    try {
        $Service = Get-Service -Name $ServiceName

        if ($Service.Status -eq "Running") {
            Add-CheckResult "Service: $ServiceName" "PASS" "Running"
        }
        else {
            Add-CheckResult "Service: $ServiceName" "FAIL" "$($Service.Status)"
        }
    }
    catch {
        Add-CheckResult "Service: $ServiceName" "FAIL" $_.Exception.Message
    }
}

# 2. Check Active Directory DNS SRV record
try {
    Import-Module ActiveDirectory
    $Domain = (Get-ADDomain).DNSRoot
    $SrvName = "_ldap._tcp.dc._msdcs.$Domain"

    $Records = @(Resolve-DnsName -Name $SrvName -Type SRV -ErrorAction Stop)

    if ($Records.Count -gt 0) {
        Add-CheckResult "AD DNS SRV" "PASS" "Resolved $SrvName"
    }
    else {
        Add-CheckResult "AD DNS SRV" "FAIL" "No SRV records returned"
    }
}
catch {
    Add-CheckResult "AD DNS SRV" "FAIL" $_.Exception.Message
}

# 3. Check SYSVOL and NETLOGON shares
foreach ($ShareName in @("SYSVOL", "NETLOGON")) {
    try {
        $Share = Get-SmbShare -Name $ShareName -ErrorAction Stop

        Add-CheckResult "Share: $ShareName" "PASS" "Available"
    }
    catch {
        Add-CheckResult "Share: $ShareName" "FAIL" $_.Exception.Message
    }
}

# 4. Run DCDIAG diagnostic tests
try {
    $DcdiagOutput = & dcdiag.exe /test:Advertising /test:SysVolCheck /test:Services 2>&1
    $DcdiagExitCode = $LASTEXITCODE

    $DcdiagOutput | Out-File -FilePath $DcdiagPath -Encoding UTF8

    if ($DcdiagExitCode -eq 0) {
        Add-CheckResult "DCDIAG" "PASS" "Selected tests passed; review diagnostic output"
    }
    else {
        Add-CheckResult "DCDIAG" "WARN" "Exit code $DcdiagExitCode; review diagnostic output"
    }
}
catch {
    Add-CheckResult "DCDIAG" "FAIL" $_.Exception.Message
}

# 5. Display and export results
$Results | Format-Table Check, Status, Details -AutoSize -Wrap

$Results | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "`nCSV report: $CsvPath" -ForegroundColor Green
Write-Host "DCDIAG output: $DcdiagPath" -ForegroundColor Green
Write-Host "Health check completed." -ForegroundColor Cyan
