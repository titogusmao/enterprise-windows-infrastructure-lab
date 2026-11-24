
# Enterprise Windows Infrastructure Lab

**Windows Server 2025 | Active Directory | Hyper-V | PowerShell | Networking | Azure**

## Overview

This repository documents a hands-on enterprise infrastructure lab built to develop and demonstrate practical Windows Systems Administration and Infrastructure Engineering skills.

The project focuses on deploying, managing, securing, automating, and troubleshooting Windows infrastructure in a virtualized environment.

## Lab Environment

| Component | Technology | Purpose |
|---|---|---|
| Hypervisor | Microsoft Hyper-V | Virtual infrastructure |
| Domain Controller | Windows Server 2025 | AD DS, DNS and Group Policy |
| Workstation | Windows 11 Pro | Domain-joined client |
| Networking | Hyper-V Virtual Switches | Lab network segmentation |
| Routing | Windows Server RRAS/NAT | Internet connectivity |
| Automation | Windows PowerShell 5.1 | Infrastructure health checks |

**Active Directory domain:** `corp.contoso.test`

## Implemented Features

### Active Directory Administration
- Deployed and configured Active Directory Domain Services.
- Created organizational units for IT, Finance, HR, Computers, Servers, and Groups.
- Created test user accounts and security groups.
- Joined a Windows 11 workstation to the domain.

### Networking and Virtualization
- Deployed Windows Server and Windows 11 virtual machines using Hyper-V.
- Configured isolated virtual networking.
- Implemented RRAS/NAT for lab internet access.
- Validated DNS resolution and domain connectivity.

### Group Policy Management
- Created a workstation security baseline GPO.
- Configured automatic workstation locking after 600 seconds of inactivity.
- Validated policy processing through PowerShell, Group Policy Results, and Windows Event Logs.

### PowerShell Automation
- Developed an Active Directory health-check script.
- Automated verification of essential Windows services.
- Validated Active Directory DNS SRV records.
- Verified SYSVOL and NETLOGON shares.
- Automated selected DCDIAG tests.
- Generated CSV and diagnostic reports.

**Initial validation:** 10 of 10 health checks passed.

## Repository Structure

```text
architecture/   Infrastructure diagrams
docs/           Technical documentation
scripts/        PowerShell automation
screenshots/    Sanitized lab evidence
```

Documentation and scripts will be added incrementally as the lab develops.

## Roadmap

- [x] Hyper-V virtual infrastructure
- [x] Active Directory Domain Services
- [x] DNS and RRAS/NAT
- [x] Organizational Units and security groups
- [x] Group Policy security baseline
- [x] Initial Active Directory health-check automation
- [ ] Advanced PowerShell automation
- [ ] File Services and NTFS permissions
- [ ] Active Directory monitoring and troubleshooting
- [ ] Windows Server backup and recovery
- [ ] Microsoft Azure and hybrid infrastructure

## Project Scope

This is a personal educational lab. All implementations and validation results refer to a simulated environment, not a production deployment.

The repository is intended to demonstrate practical technical skills, troubleshooting methodology, automation, and infrastructure documentation.
