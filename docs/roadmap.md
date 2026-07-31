# Project Roadmap

This roadmap tracks completed milestones and the next likely direction of the project.

Future phases will be defined as the environment develops rather than being locked in too far ahead of time.

## Completed Phases

### Phase 1 — Management Server Foundation

**Status:** Complete

Established the dedicated Windows management server, Tailscale connectivity, RustDesk unattended access, power configuration, role-based hostname, and battery-health management.

[View Phase 1 documentation](phases/phase-1-management-server-foundation.md)

### Phase 2 — Secure Remote Administration

**Status:** Complete

Migrated OpenSSH, SSH key authentication, Wake-on-LAN, and the complete remote-administration workflow to `LAB-GATEWAY`.

[View Phase 2 documentation](phases/phase-2-secure-remote-administration.md)

### Phase 3 — Virtual Lab Foundation

**Status:** Complete

Standardized the existing Linux virtual machines, expanded storage, verified system health, centralized reusable maintenance scripts, and created clean VMware rollback points.

Current lab systems:

- `KALI-01` — offensive security workstation
- `NIDS-01` — Snort-based network intrusion-detection workstation

[View Phase 3 documentation](phases/phase-3-virtual-lab-foundation.md)

## Current Direction

With the virtual machines now stable and organized, the next step is to begin using them as a connected cybersecurity lab.

The next phase will likely focus on:

- Reviewing and organizing the VMware network configuration
- Safely introducing a vulnerable target
- Using `KALI-01` to generate controlled test traffic
- Tuning Snort on `NIDS-01`
- Capturing and analyzing packets with Wireshark
- Confirming that defensive alerts match the activity being generated
- Documenting basic attack-and-detection exercises

The final scope will be decided after the current VMware networking and available target systems are reviewed.

## Future Direction

As the lab grows, possible areas of expansion include:

- Active Directory and Windows administration
- Windows server and client virtual machines
- Centralized Windows and Linux logging
- Sysmon and endpoint monitoring
- Wazuh or another SIEM platform
- Detection engineering
- Incident-response exercises
- PowerShell, Bash, and Python automation
- Identity and access management
- Security hardening
- Additional network segmentation
- Cloud integration
- Additional offensive and defensive systems