# Project Roadmap

## Phase 1 — Management Server Foundation

**Status:** Complete

Established the dedicated Windows management server, Tailscale connectivity, RustDesk unattended access, power configuration, role-based hostname, and battery-health management.

[View Phase 1 documentation](phases/phase-1-management-server-foundation.md)

## Phase 2 — Secure Remote Administration

**Status:** Complete

Migrated OpenSSH, SSH key authentication, Wake-on-LAN, and the complete remote-administration workflow to `LAB-GATEWAY`.

[View Phase 2 documentation](phases/phase-2-secure-remote-administration.md)

## Phase 3 — Monitoring and Logging

**Status:** Planned

Potential work:

- Centralized Windows event collection
- Service health monitoring
- Tailscale availability checks
- SSH service monitoring
- RustDesk service monitoring
- Development-workstation reachability checks
- Alerting for failed services
- Logging of automated workflows
- Basic operational dashboard

## Phase 4 — Security Hardening

**Status:** Planned

Potential work:

- Tailscale access-control policies
- Device tagging
- Network segmentation
- SSH source restrictions
- SSH user restrictions
- Least-privilege administrative model
- Windows Firewall review
- Service-account review
- Configuration audit documentation
- Recovery and break-glass procedures

## Phase 5 — Automation and Expansion

**Status:** Planned

Potential work:

- Version-controlled Wake-on-LAN script
- Version-controlled Mac automation workflow
- Automated health checks
- Automated service recovery checks
- Additional lab systems
- Additional virtual machines
- Improved architecture diagrams
- Sanitized configuration screenshots
- Deployment procedures
- Recovery procedures

## Long-Term Direction

The environment is intended to grow into a broader infrastructure and security lab that supports:

- Windows administration
- Linux administration
- Networking
- Identity and access management
- Security monitoring
- Automation
- Cloud integration
- Infrastructure hardening