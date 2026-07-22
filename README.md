# Secure Home Remote Access

A documented home-lab project for securely administering a development workstation through a dedicated Windows management server without exposing management services directly to the public internet.

## Project Status

Home Lab 2.0 is being developed in documented phases.

- [Phase 1 — Management Server Foundation](docs/phases/phase-1-management-server-foundation.md) ✅ Complete
- [Phase 2 — Secure Remote Administration](docs/phases/phase-2-secure-remote-administration.md) 🚧 In Progress

See the [Project Roadmap](docs/roadmap.md) for planned phases and future improvements.

### Completed

- Prepared a dedicated Windows 11 Pro management server
- Created a primary administrative Windows profile
- Kept the built-in Administrator and Guest accounts disabled
- Installed Tailscale and connected the server to the existing tailnet
- Enabled Tailscale unattended mode
- Confirmed the Tailscale Windows service is running
- Installed RustDesk as a Windows service
- Configured RustDesk for unattended access
- Disabled one-time-password access
- Tested remote desktop access successfully from the MacBook Pro
- Configured the management server to remain awake while connected to power
- Separated the management role from the shared home-theater laptop

### In Progress

- Replace the current hostname with a role-based hostname
- Recheck lid-close and display behavior while physically connected to the management server
- Verify or configure a battery charge limit
- Migrate SSH key authentication to the dedicated management server
- Migrate Wake-on-LAN automation to the dedicated management server

### Planned

- Add an architecture diagram
- Add sanitized configuration screenshots
- Add monitoring and centralized logging
- Review Tailscale access controls
- Evaluate device segmentation
- Expand security-hardening documentation
- Add reusable automation scripts

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

The dedicated management server currently supports Tailscale and RustDesk remote access. SSH key authentication and Wake-on-LAN have not yet been migrated from the previous gateway and remain part of the next implementation phase.

## Device Roles

| Device | Role |
|---|---|
| MacBook Pro | Remote administration and documentation workstation |
| Dedicated Windows laptop | Management server and future SSH jump host |
| Desktop PC | Development workstation and security-lab host |
| Home-theater laptop | Shared media and Plex system; no longer used for management |

## Why the Architecture Changed

The original design used a shared home-theater laptop that also hosted Plex as the remote-access gateway.

NordVPN was later enabled on that system. Although Tailscale ping continued to work, SSH connections failed. The SSH service, firewall rules, and network profile appeared normal. Pausing NordVPN restored the SSH connection, identifying a conflict between the VPN clients or their routing behavior.

Rather than modifying the networking configuration of a shared production device, the management role was moved to a dedicated Windows 11 Pro management server that I fully control.

This redesign introduced:

- Separation of concerns
- Full administrative control over the management environment
- Reduced risk to the Plex environment
- More predictable networking behavior
- A cleaner management plane
- A stronger foundation for automation
- Space for future monitoring and security tooling

## Remote-Access Methods

### Tailscale

Tailscale provides the private network path between the MacBook Pro and the management server without requiring public port forwarding.

### RustDesk

RustDesk provides graphical remote administration. It is installed as a Windows service and configured for permanent-password access.

### SSH

SSH key authentication was used in the original design. Migration to the dedicated management server is planned but not yet complete.

### Wake-on-LAN

Wake-on-LAN allows the development workstation to remain powered off until it is needed. Migration of this workflow to the dedicated management server is also pending.

## Technologies

- Windows 11 Pro
- macOS
- Tailscale
- RustDesk
- OpenSSH
- SSH key authentication
- Wake-on-LAN
- PowerShell
- Shell scripting
- Git
- GitHub
- Visual Studio Code

## Skills Demonstrated

- Remote-access architecture
- Windows service administration
- Secure authentication planning
- VPN and routing troubleshooting
- Separation of concerns
- Infrastructure documentation
- Git-based change tracking
- Power-management configuration
- Remote administration
- Security-conscious system design

## Documentation

- [Architecture](docs/architecture.md)
- [Tailscale](docs/tailscale.md)
- [SSH Key Authentication](docs/ssh-key-authentication.md)
- [Wake-on-LAN](docs/wake-on-lan.md)
- [RustDesk](docs/rustdesk.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Security Considerations](docs/security-considerations.md)

## Repository Structure

```text
secure-home-remote-access/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── tailscale.md
│   ├── ssh-key-authentication.md
│   ├── wake-on-lan.md
│   ├── rustdesk.md
│   ├── troubleshooting.md
│   └── security-considerations.md
├── scripts/
├── diagrams/
└── screenshots/
```

## Security Notice

Sensitive infrastructure details, credentials, private keys, internal addresses, and remote-access identifiers are intentionally excluded from this public repository.

See [Security Considerations](docs/security-considerations.md) for additional details.

## Project History

The repository began with a simpler architecture that used a shared home-theater laptop as the gateway. Home Lab 2.0 moves that responsibility to a dedicated management server.

Git commit history preserves the earlier architecture, documentation, and subsequent redesign decisions.