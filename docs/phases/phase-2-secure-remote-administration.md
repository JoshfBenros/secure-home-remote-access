# Phase 2 — Secure Remote Migration

**Status:** In Progress

## Objective

Restore the secure remote administration workflow by migrating SSH key authentication, Wake-on-LAN, and automation from the previous shared gateway to the dedicated `LAB-GATEWAY` management server while preserving secure design principles.

## Planned Work

- [x] Install OpenSSH Server
- [x] Configure and verify the OpenSSH service
- [x] Configure Windows Firewall for SSH
- [x] Install the MacBook Pro public SSH key
- [x] Verify SSH key authentication
- [x] Disable password authentication after validation
- [x] Migrate Wake-on-LAN functionality
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