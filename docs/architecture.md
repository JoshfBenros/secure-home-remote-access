# Remote Access Architecture

This document describes the structure and evolution of the secure home-lab environment.

The architecture combines a dedicated Windows management server, secure remote administration, and a VMware-based cybersecurity lab hosted on `DEV-PC`.

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
    |
    | VMware Workstation
    |
    ├── KALI-01
    |   Offensive security workstation
    |
    └── NIDS-01
        Network intrusion-detection workstation
```

## Device Roles

| Device | Role |
|---|---|
| MacBook Pro | Remote administration, documentation, and mobile development workstation |
| `LAB-GATEWAY` | Dedicated Windows management server and SSH jump host |
| `DEV-PC` | Main development workstation and VMware lab host |
| `KALI-01` | Offensive security and packet-analysis workstation |
| `NIDS-01` | Snort-based network intrusion-detection workstation |
| Home-theater laptop | Shared media and Plex system; no longer used for management |

## Project Goals

The environment was designed to:

- Securely access `DEV-PC` remotely
- Avoid exposing administrative services directly to the public internet
- Keep `DEV-PC` powered off when it is not needed
- Separate management services from shared household systems
- Support offensive and defensive cybersecurity labs
- Provide a foundation for monitoring, automation, and future expansion

## Architecture Evolution

### Original Design

The original architecture used a shared home-theater laptop as the remote-access gateway.

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

The shared system also hosted Plex and was managed by more than one person.

NordVPN was later enabled on the device. Tailscale connectivity remained available, but SSH connections failed. Pausing NordVPN restored access, indicating that the VPN configuration was interfering with the management path.

### Dedicated Management Server

Rather than modifying a shared production system, the management role was moved to a dedicated Windows 11 Pro server.

This created:

- Separation of concerns
- Full administrative control
- More predictable networking
- Reduced risk to the Plex environment
- A cleaner management plane
- A stronger foundation for future security tooling

## Naming Standardization

The environment uses role-based names rather than personal or automatically generated names.

| Component | Previous Name | Current Name |
|---|---|---|
| Management server | `DESKTOP-S1TUKS9` | `LAB-GATEWAY` |
| Development workstation | `joshua-main` | `DEV-PC` |
| Kali VM | `kali-vm` | `KALI-01` |
| Ubuntu Snort VM | `ubuntu-snort` | `NIDS-01` |
| Management SSH alias | `homeGateway` | `labGateway` |
| Development SSH alias | `devPC` | `devPC` |

Role-based naming makes the infrastructure easier to understand and scale.

## Management Architecture

Remote administration uses several complementary access methods.

| Technology | Architectural Purpose |
|---|---|
| Tailscale | Private management network between approved devices |
| SSH | Command-line administration and automation |
| RustDesk | Graphical administration |
| Wake-on-LAN | Allows `DEV-PC` to remain powered off until needed |

These services provide remote management without intentionally exposing administrative ports to the public internet.

The current management path is:

```text
MacBook Pro
    |
    v
LAB-GATEWAY
    |
    v
DEV-PC
```

`LAB-GATEWAY` acts as the controlled entry point for administration and Wake-on-LAN operations.

## Virtual Lab Architecture

`DEV-PC` hosts the cybersecurity lab through VMware Workstation.

```text
DEV-PC
    |
    | VMware Workstation
    |
    ├── KALI-01
    |   Offensive security workstation
    |
    └── NIDS-01
        Network intrusion-detection workstation
```

| System | Role | Purpose |
|---|---|---|
| `KALI-01` | Offensive workstation | Reconnaissance, vulnerability assessment, packet capture, and controlled security testing |
| `NIDS-01` | Defensive monitoring workstation | Snort IDS, traffic monitoring, alerting, and detection analysis |

The two virtual machines provide separate offensive and defensive roles while sharing the same VMware host.

## Security Boundaries

The architecture separates the environment into distinct functional areas.

### Management Plane

Includes:

- MacBook Pro
- `LAB-GATEWAY`
- Remote-access services
- Wake-on-LAN workflow

Purpose:

- Administration
- Remote access
- Automation
- System recovery

### Lab Plane

Includes:

- `DEV-PC`
- VMware Workstation
- `KALI-01`
- `NIDS-01`
- Future lab systems

Purpose:

- Security testing
- Packet analysis
- Detection development
- Monitoring
- Controlled attack simulations

### Shared Production Systems

The home-theater laptop remains outside the management plane.

Its purpose is limited to shared media and Plex services, reducing the chance that unrelated software or household changes affect the lab environment.

## Design Benefits

The current design provides:

- Clear separation between management and lab workloads
- Reduced dependence on shared household systems
- Role-based naming
- Centralized remote administration
- Dedicated offensive and defensive lab systems
- Easier troubleshooting
- Support for future network segmentation
- Space for additional monitoring and automation
- A scalable foundation for future virtual machines

## Planned Expansion

Future architecture may include:

```text
DEV-PC
    |
    | VMware Workstation
    |
    ├── KALI-01
    ├── NIDS-01
    ├── Vulnerable Target
    ├── Windows Domain Controller
    ├── Windows Client
    └── Future SIEM Platform
```

Planned areas of expansion include:

- Isolated VMware networks
- Vulnerable target deployment
- Active Directory
- Windows endpoint logging
- Centralized event collection
- Wazuh or another SIEM platform
- Detection engineering
- Incident-response exercises
- Additional automation