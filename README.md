# Secure Home Remote Access

A home-lab project for securely administering a development workstation through a dedicated Windows management server without exposing management services directly to the public internet.

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

## Project Phases

- [Phase 1 — Management Server Foundation](docs/phases/phase-1-management-server-foundation.md) ✅ Complete
- [Phase 2 — Secure Remote Administration](docs/phases/phase-2-secure-remote-administration.md) ✅ Complete
- [Phase 3 — Virtual Lab Foundation](docs/phases/phase-3-virtual-lab-foundation.md) ✅ Complete


See the [Project Roadmap](docs/roadmap.md) for planned phases and future improvements.

## Key Technologies

- Windows 11 Pro
- macOS
- Tailscale
- RustDesk
- OpenSSH
- SSH key authentication
- Wake-on-LAN
- PowerShell
- Git
- GitHub

## Documentation

- [Architecture](docs/architecture.md)
- [Tailscale](docs/tailscale.md)
- [SSH Key Authentication](docs/ssh-key-authentication.md)
- [Wake-on-LAN](docs/wake-on-lan.md)
- [RustDesk](docs/rustdesk.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Security Considerations](docs/security-considerations.md)

## Security Notice

Sensitive credentials, keys, internal addresses, and remote-access identifiers are intentionally excluded from this public repository.