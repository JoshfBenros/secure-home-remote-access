# Phase 2 — Secure Remote Administration

**Status:** In Progress

## Objective

Migrate secure command-line administration and Wake-on-LAN functionality to the dedicated `LAB-GATEWAY` management server.

## Planned Work

- [ ] Install OpenSSH Server
- [ ] Configure and verify the OpenSSH service
- [ ] Configure Windows Firewall for SSH
- [ ] Install the MacBook Pro public SSH key
- [ ] Verify SSH key authentication
- [ ] Disable password authentication after validation
- [ ] Migrate Wake-on-LAN functionality
- [ ] Update the Mac automation script
- [ ] Validate the full MacBook Pro → `LAB-GATEWAY` → development workstation workflow
- [ ] Document SSH hardening decisions
- [ ] Test reboot recovery and unattended availability

## Intended Access Flow

```text
MacBook Pro
    |
    | Tailscale / SSH key authentication
    v
LAB-GATEWAY
    |
    | Wake-on-LAN
    v
Development Workstation