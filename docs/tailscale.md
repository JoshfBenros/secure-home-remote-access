# Tailscale

## Purpose

Tailscale provides a private encrypted network path between the systems in the remote-access environment.

It allows remote administration without requiring public port forwarding.

## Devices

The current tailnet includes:

- MacBook Pro
- `LAB-GATEWAY`
- `DEV-PC`

Sensitive Tailscale addresses are excluded from this repository.

## Management Server Configuration

On `LAB-GATEWAY`:

- Tailscale is installed as a Windows service
- The service starts automatically
- Unattended mode is enabled
- The system reconnects before user login
- Connectivity survives reboot

## MagicDNS

MagicDNS allows systems to be reached through hostnames rather than hardcoded Tailscale IP addresses.

The MacBook Pro successfully resolves:

```text
lab-gateway
```

This supports cleaner SSH configuration and reduces dependence on numeric addresses.

## Role in the Architecture

```text
MacBook Pro
    |
    | Tailscale
    v
LAB-GATEWAY
    |
    | Local network
    v
DEV-PC
```

Tailscale acts as the private management network connecting the remote administration client to the management server.

## Security Benefits

- No public port forwarding required
- Encrypted network path
- Device-based access
- Simplified remote connectivity
- Reduced public attack surface
- Stable hostnames through MagicDNS

## Validation

The following tests completed successfully:

- Management server visible on the tailnet
- MagicDNS hostname resolution
- Automatic reconnection after reboot
- SSH through Tailscale
- RustDesk access through the remote environment

## Future Improvements

- Review Tailscale access-control policies
- Introduce device tags
- Evaluate segmentation
- Restrict management access to approved devices
- Document recovery procedures