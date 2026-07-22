# Project Roadmap

## Phase 1 — Management Server Foundation

**Status:** Complete

Established the dedicated Windows management server, Tailscale connectivity, RustDesk unattended access, power configuration, and battery-health management.

[View Phase 1 documentation](phases/phase-1-management-server-foundation.md)

## Phase 2 — Secure Remote Administration

**Status:** In Progress

Migrate OpenSSH, SSH key authentication, Wake-on-LAN, and the full remote-administration workflow to `LAB-GATEWAY`.

[View Phase 2 documentation](phases/phase-2-secure-remote-administration.md)

## Phase 3 — Monitoring and Logging

**Status:** Planned

Potential work:

- Centralized Windows event collection
- Service health monitoring
- Connection and availability checks
- Alerting for failed services or unreachable systems

## Phase 4 — Security Hardening

**Status:** Planned

Potential work:

- Tailscale access-control policies
- Device tagging and segmentation
- SSH restrictions
- Least-privilege service accounts
- Configuration review and audit documentation

## Phase 5 — Automation and Expansion

**Status:** Planned

Potential work:

- Reusable PowerShell and shell scripts
- Automated health checks
- Additional lab systems
- Improved architecture diagrams
- Recovery procedures