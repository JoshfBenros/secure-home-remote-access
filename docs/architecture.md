# Remote Access Architecture

This document explains the design and evolution of the secure home remote-access environment.

The current design uses a dedicated Windows 11 Pro management server to provide a controlled administrative path between a MacBook Pro and a development workstation.

## Revision History

### 2026-07-22

- Reorganized the repository into a structured Markdown documentation layout
- Replaced the shared home-theater gateway with a dedicated management server
- Added Tailscale unattended connectivity to the management server
- Added RustDesk unattended remote access
- Documented the NordVPN and Tailscale conflict
- Began migration planning for SSH key authentication and Wake-on-LAN

### 2026-03-11

- Implemented SSH key authentication
- Disabled password authentication
- Added SSH configuration automation
- Implemented Wake-on-LAN automation
- Added macOS SSH keychain integration

### 2026-03-10

- Created the initial architecture
- Used password-based SSH access
- Connected manually to the development workstation

## Why This Exists

This project began as an effort to organize a personal development environment across multiple systems.

The MacBook Pro is convenient for mobile administration, documentation, and development. The desktop PC provides more resources for virtual machines, security labs, and heavier workloads.

The environment was designed to support the following goals:

- Access the development workstation remotely
- Avoid exposing administrative ports to the public internet
- Keep the development workstation powered off when it is not needed
- Use key-based authentication instead of passwords
- Separate management services from other household systems
- Build a platform that can later support automation, monitoring, and security tooling

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
4. Wait for the development workstation to reconnect
5. Connect to the development workstation through SSH or remote desktop

## Problem Identified

NordVPN was later enabled on the shared home-theater laptop.

The resulting symptoms were:

- Tailscale ping succeeded
- SSH connections failed
- The SSH service appeared to be running normally
- Windows Firewall allowed inbound SSH
- The Tailscale network profile was set correctly
- Restarting the system did not resolve the issue

Pausing NordVPN restored SSH connectivity.

This indicated that the VPN clients or their routing behavior were interfering with the Tailscale and SSH connection path.

## Architectural Decision

Rather than changing the networking configuration of a shared production device, the management role was moved to a dedicated Windows 11 Pro management server that is fully controlled by the me.

This decision prevents unrelated software or configuration changes on the home-theater system from affecting remote administration.

It also reduces the risk of management changes disrupting Plex or other shared media functions.

## Current Architecture

```text
MacBook Pro
    |
    | Tailscale / RustDesk
    v
Dedicated Windows Management Server
    |
    | Wake-on-LAN
    | Migration pending
    v
Development Workstation
```

The management server currently provides:

- Tailscale connectivity
- Unattended Tailscale operation
- RustDesk unattended remote access
- Continuous availability while connected to power

SSH key authentication and Wake-on-LAN have not yet been migrated to the new management server.

## Device Roles

| Device | Role |
|---|---|
| MacBook Pro | Remote administration, documentation, and development workstation |
| Dedicated Windows management server | Management plane and future SSH jump host |
| Development workstation | Main development system and security-lab host |
| Shared home-theater laptop | Plex and media system; no longer used for management |

## Current Remote-Access Flow

### Graphical Administration

```text
MacBook Pro
    |
    | Tailscale
    v
Management Server
    |
    | RustDesk
    v
Windows Desktop Session
```

### Planned SSH and Wake-on-LAN Flow

```text
MacBook Pro
    |
    | Tailscale / SSH key authentication
    v
Management Server
    |
    | Wake-on-LAN
    v
Development Workstation
```

The planned automation process is:

1. Connect to the management server through Tailscale
2. Authenticate with an SSH key
3. Send a Wake-on-LAN packet to the development workstation
4. Wait for the development workstation to become reachable
5. Connect to the development workstation

## Authentication Design

The original design used SSH key authentication from the MacBook Pro to the gateway and development workstation.

The private SSH key remained on the MacBook Pro. Authorized public keys were stored on the remote systems.

The Home Lab 2.0 migration will preserve this model:

- Private keys remain on the administrative client
- Public keys are installed only on authorized systems
- Password authentication will be disabled after key authentication is verified
- SSH access will be limited to trusted Tailscale paths

RustDesk uses a permanent password for unattended access. One-time-password access is disabled.

Credentials and remote-access identifiers are not stored in this repository.

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
- RustDesk runs as a Windows service for unattended access
- SSH key authentication is planned for the new management server
- Private SSH keys remain on the MacBook Pro
- The built-in Administrator and Guest accounts remain disabled
- Sensitive addresses, credentials, and identifiers are excluded from public documentation
- Wake-on-LAN traffic remains limited to the local network

## Current Limitations

- SSH key authentication has not yet been migrated
- Wake-on-LAN automation has not yet been migrated
- RustDesk does not render correctly when the management-server lid is closed
- The lid currently remains open while the display turns off
- Battery charge-limit configuration still needs to be verified
- The management-server hostname still needs to be changed to a role-based name

## Future Improvements

- Complete SSH key-authentication migration
- Complete Wake-on-LAN migration
- Add a reusable wake script
- Add a visual architecture diagram
- Add sanitized screenshots
- Review Tailscale access-control policies
- Evaluate device segmentation
- Implement centralized logging
- Add monitoring and health checks
- Expand the environment with additional lab systems