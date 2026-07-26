# Remote Access Architecture

This document explains the design and evolution of the secure home remote-access environment.

The current architecture uses a dedicated Windows 11 Pro management server to provide a controlled administrative path between a MacBook Pro and a development workstation.

## Current Architecture

```text
MacBook Pro
    |
    | Tailscale / SSH / RustDesk
    v
LAB-GATEWAY
    |
    | Wake-on-LAN
    v
DEV-PC
```

## Device Roles

| Device | Role |
|---|---|
| MacBook Pro | Remote administration, documentation, and mobile development workstation |
| `LAB-GATEWAY` | Dedicated Windows management server and SSH jump host |
| `DEV-PC` | Main development workstation and security-lab host |
| Home-theater laptop | Shared media and Plex system; no longer used for management |

## Why This Exists

The MacBook Pro is convenient for mobile administration, documentation, and development. The desktop workstation provides more resources for virtual machines, security labs, and heavier workloads.

The environment was designed to support the following goals:

- Access the development workstation remotely
- Avoid exposing administrative services directly to the public internet
- Keep the development workstation powered off when it is not needed
- Use key-based authentication instead of passwords
- Separate management services from shared household systems
- Create a platform that can support future automation, monitoring, and security tooling

## Original Architecture

The original design used a shared home-theater laptop as the remote-access gateway.

```text
MacBook Pro
    |
    | Tailscale / SSH
    v
Shared Home-Theater Laptop
    |
    | Wake-on-LAN
    v
Development Workstation
```

The shared gateway also hosted Plex and was managed by more than one person.

The original workflow was:

1. Connect from the MacBook Pro to the shared gateway through Tailscale
2. Authenticate with an SSH key
3. Send a Wake-on-LAN packet to the development workstation
4. Wait for the development workstation to become reachable
5. Connect to the development workstation

## Problem Identified

NordVPN was later enabled on the shared home-theater laptop.

The resulting symptoms were:

- Tailscale ping succeeded
- SSH connections failed
- The OpenSSH service appeared to be running normally
- Windows Firewall allowed inbound SSH
- The Tailscale network profile was configured correctly
- Restarting the system did not resolve the issue

Pausing NordVPN restored SSH connectivity.

This indicated that the VPN clients or their routing behavior were interfering with the Tailscale and SSH connection path.

## Architectural Decision

Rather than modifying the networking configuration of a shared production device, the management role was moved to a dedicated Windows 11 Pro system that is fully controlled by the project owner.

This decision prevents unrelated software or configuration changes on the home-theater system from affecting remote administration.

It also reduces the risk of management changes disrupting Plex or other shared media functions.

## Naming Standardization

The environment now uses role-based names rather than personal or automatically generated device names.

| Component | Previous Name | Current Name |
|---|---|---|
| Management server | `DESKTOP-S1TUKS9` | `LAB-GATEWAY` |
| Development workstation | `joshua-main` | `DEV-PC` |
| Management SSH alias | `homeGateway` | `labGateway` |
| Development SSH alias | `devPC` | `devPC` |

Role-based naming makes the infrastructure easier to understand and allows the environment to scale more cleanly.

## Remote-Access Layers

The workflow is divided into independent layers.

```text
Automation
    lab()

Configuration
    ~/.ssh/config

Authentication
    SSH keys

Management
    LAB-GATEWAY

Service
    wakeonlan.ps1

Target
    DEV-PC
```

Each layer has a single responsibility, which improves maintainability and troubleshooting.

## Tailscale Layer

Tailscale provides the private network path between the MacBook Pro, `LAB-GATEWAY`, and `DEV-PC`.

The design does not require public port forwarding.

MagicDNS allows the MacBook Pro to resolve the management server by hostname.

## RustDesk Layer

RustDesk provides graphical remote administration of `LAB-GATEWAY`.

It runs as a Windows service under `LocalSystem`, starts automatically, and reconnects after reboot without requiring an interactive Windows login.

## SSH Layer

OpenSSH Server runs on `LAB-GATEWAY` as the `sshd` Windows service.

The SSH implementation uses:

- ED25519 key authentication
- The existing MacBook Pro key pair
- The Windows `administrators_authorized_keys` file
- Restricted file permissions
- Password authentication disabled
- PowerShell as the default SSH shell

The private SSH key remains on the MacBook Pro.

## Wake-on-LAN Layer

`LAB-GATEWAY` runs a PowerShell script that constructs and sends a Wake-on-LAN magic packet to `DEV-PC`.

The MacBook Pro initiates the workflow by connecting to the `labGateway` SSH alias.

## Final Automation Flow

```text
lab()
    |
    v
SSH to labGateway
    |
    v
LAB-GATEWAY
    |
    v
wakeonlan.ps1
    |
    v
DEV-PC powers on
    |
    v
SSH to devPC
```

## Validation

The following behaviors were tested successfully:

- Tailscale connectivity
- MagicDNS hostname resolution
- RustDesk unattended access
- SSH key authentication
- Password authentication rejection
- Wake-on-LAN packet delivery
- Development workstation wake-up
- End-to-end automation
- Management-server reboot recovery
- Automatic startup of Tailscale
- Automatic startup of OpenSSH
- Automatic startup of RustDesk
- Remote administration after reboot

## Design Benefits

The dedicated management-server architecture provides:

- Separation of concerns
- Full administrative control over the management environment
- Reduced risk to the shared Plex environment
- More predictable networking behavior
- A cleaner management plane
- Easier troubleshooting
- A stronger foundation for automation
- Space for monitoring and security tooling
- Reduced dependence on a shared household device

## Security Properties

- No administrative ports are intentionally exposed to the public internet
- Tailscale provides an encrypted private network path
- SSH uses key-only authentication
- Password authentication is disabled
- Private SSH keys remain on the MacBook Pro
- The built-in Administrator and Guest accounts remain disabled
- RustDesk one-time-password access is disabled
- Sensitive addresses, credentials, and identifiers are excluded from public documentation
- Wake-on-LAN traffic remains limited to the local network

## Current State

Phase 1 and Phase 2 are complete.

The environment now provides:

- A dedicated management server
- Secure key-only SSH access
- Graphical remote administration
- Wake-on-LAN automation
- Automatic service recovery after reboot
- A complete unattended remote-access workflow
- Version-controlled documentation

Future phases will focus on monitoring, logging, access control, segmentation, hardening, and additional automation.