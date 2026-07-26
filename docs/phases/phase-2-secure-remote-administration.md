# Phase 2 — Secure Remote Administration

**Status:** Complete

## Objective

Migrate secure command-line administration and Wake-on-LAN functionality from the previous shared gateway to the dedicated `LAB-GATEWAY` management server.

## Outcome

The complete remote-administration workflow now operates through `LAB-GATEWAY`.

```text
MacBook Pro
    |
    | Tailscale / SSH key authentication
    v
LAB-GATEWAY
    |
    | Wake-on-LAN
    v
DEV-PC
```

## Naming Standardization

The infrastructure was updated to use role-based naming.

| Component | Previous | Current |
|---|---|---|
| Management server | `DESKTOP-S1TUKS9` | `LAB-GATEWAY` |
| Development workstation | `joshua-main` | `DEV-PC` |
| Management SSH alias | `homeGateway` | `labGateway` |
| Development SSH alias | `devPC` | `devPC` |

Role-based naming makes the environment easier to understand and scales better as new systems are introduced.

## OpenSSH Server

OpenSSH Server was installed as a Windows optional capability.

Once installed, it registered the `sshd` Windows service.

The service was configured to:

- Run automatically
- Start after reboot
- Accept SSH connections through the Windows Firewall
- Use PowerShell as the default SSH shell

## SSH Key Authentication

The existing ED25519 key pair from the MacBook Pro was reused.

The private key remained on the MacBook Pro.

The public key was installed on `LAB-GATEWAY` in the Windows administrators authorized-key file.

The implementation included:

- Installing the public key
- Restricting authorized-key file permissions
- Verifying key authentication
- Disabling password authentication
- Confirming password authentication is rejected
- Confirming SSH continues to work after reboot

## Wake-on-LAN Migration

The existing Wake-on-LAN PowerShell implementation was migrated to `LAB-GATEWAY`.

The migration included:

- Moving `wakeonlan.ps1`
- Verifying the script path
- Validating magic-packet generation
- Confirming the correct network broadcast behavior
- Successfully waking `DEV-PC`
- Restoring the complete automated workflow

## Automation Workflow

The MacBook Pro uses the `lab()` function to orchestrate the process.

```text
lab()
    |
    v
SSH to labGateway
    |
    v
Run wakeonlan.ps1
    |
    v
Wait for DEV-PC
    |
    v
SSH to devPC
```

The automation logic remained largely unchanged during the migration because environment-specific connection settings were stored in SSH configuration.

## Validation

The following tests completed successfully:

- SSH key authentication
- Password authentication rejection
- PowerShell default shell
- Wake-on-LAN functionality
- Development workstation wake-up
- End-to-end automation
- Management-server reboot recovery
- Tailscale automatic startup
- OpenSSH automatic startup
- RustDesk automatic startup
- Remote administration after reboot
- Full unattended workflow

## Lessons Learned

### Scripts vs. Configuration Files

A script contains executable logic and performs actions.

Examples from this project include:

- `lab()` in `.zshrc`
- `wakeonlan.ps1`
- PowerShell automation scripts

A configuration file defines settings used by another program.

Examples include:

- `~/.ssh/config`
- `sshd_config`

The core design principle is:

> Keep logic separate from configuration whenever possible.

Instead of hardcoding usernames, hostnames, IP addresses, or key locations inside scripts, environment-specific values should be stored in configuration files.

This provides:

- Easier maintenance
- Easier migrations
- A single source of truth
- Cleaner automation
- Fewer script changes when infrastructure changes

For example, the automation calls:

```text
ssh labGateway
```

The actual hostname, username, and identity file are defined in:

```text
~/.ssh/config
```

When the gateway changed, the SSH configuration was updated while the higher-level automation workflow remained mostly unchanged.

### Layered Architecture

The remote administration workflow is composed of independent layers.

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

Each layer has one primary responsibility.

This makes failures easier to isolate and reduces the impact of infrastructure changes.

### Enterprise Naming

Infrastructure should be named by role rather than by owner.

Examples:

```text
LAB-GATEWAY
DEV-PC
```

are clearer and more scalable than:

```text
Joshua-PC
Desktop-123ABC
```

Role-based naming becomes increasingly important as the environment grows.

## Final Outcome

Phase 2 established a fully functional secure remote-administration platform featuring:

- Dedicated management server
- Key-only SSH authentication
- Password authentication disabled
- Wake-on-LAN automation
- PowerShell remote shell
- Automatic recovery after reboot
- Full unattended workflow
- Version-controlled documentation
- Scalable architecture ready for future expansion