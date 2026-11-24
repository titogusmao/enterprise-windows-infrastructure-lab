# Active Directory Health Monitoring with PowerShell

## 1. Project Overview

This lab demonstrates the development and validation of a PowerShell script designed to perform basic Active Directory health checks on Windows Server 2025.

The goal is to automate routine infrastructure checks, identify potential issues, and generate structured reports for troubleshooting.

## 2. Lab Environment

| Component | Configuration |
|---|---|
| Operating System | Windows Server 2025 |
| Server | DC01 |
| Active Directory Domain | corp.contoso.test |
| Scripting Language | Windows PowerShell 5.1 |
| Virtualization | Microsoft Hyper-V |
| Client | Windows 11 Pro |

## 3. Monitoring Capabilities

The script `Get-ADHealthReport.ps1` performs the following checks:

- **Windows Services:** Verifies NTDS, DNS, Netlogon, KDC, W32Time, and DFSR service status.
- **DNS:** Resolves the Active Directory LDAP SRV record.
- **SYSVOL and NETLOGON:** Checks the availability of essential domain controller shares.
- **DCDIAG:** Runs selected Active Directory diagnostic tests.
- **Reporting:** Generates timestamped CSV and text reports.

## 4. How to Run

Open Windows PowerShell 5.1 as an administrator on the Domain Controller.

Run the script:

```powershell
.\Get-ADHealthReport.ps1
```

The script creates its reports in:

```text
C:\LabScripts\Reports\
```

The current script uses a fixed report directory and is intended to run locally on a Domain Controller.

## 5. Validation Results

The initial execution on DC01 returned:

| Test Category | Result |
|---|---|
| Essential Windows services | 6 PASS |
| Active Directory DNS SRV resolution | PASS |
| SYSVOL share availability | PASS |
| NETLOGON share availability | PASS |
| Selected DCDIAG tests | PASS |

**Overall result: 10/10 checks passed.**

The script generated CSV and text diagnostic reports.

These results confirm that the selected checks completed successfully at the time of testing. They do not constitute a comprehensive Active Directory health assessment.

## 6. Troubleshooting Approach

When a check reports a problem, the following steps should be considered:

1. Identify the affected service or component.
2. Review the detailed diagnostic output.
3. Examine relevant Windows Event Logs.
4. Verify DNS, network connectivity, and domain controller configuration.
5. Correct the underlying issue.
6. Rerun the script to validate the result.

## 7. Future Improvements

- Windows Time synchronization validation
- DFS Replication event analysis
- Active Directory replication checks
- Configurable target servers
- Improved error handling
- HTML reporting
- Scheduled execution
- Optional notifications for detected failures

## 8. Skills Demonstrated

- Windows Server administration
- Active Directory troubleshooting
- PowerShell scripting
- Infrastructure monitoring
- DNS diagnostics
- Automated reporting
- Technical documentation

## Disclaimer

This project was developed and tested in an isolated educational laboratory. It does not represent a production implementation.
