# Troubleshooting

This document records major troubleshooting cases and the lessons learned from them.

## NordVPN Interference with Tailscale and SSH

### Symptoms

- The shared gateway responded to Tailscale ping
- SSH connections failed
- The OpenSSH service was running
- Windows Firewall allowed inbound SSH
- The Tailscale network profile appeared correct
- Restarting the system did not resolve the issue

### Investigation

The issue initially appeared to be related to OpenSSH or Windows Firewall because Tailscale connectivity was partially functional.

However, the host also had NordVPN running.

### Root Cause

NordVPN interfered with the Tailscale and SSH connection path.

The exact interaction may have involved routing, network-interface priority, or VPN traffic handling.

### Resolution

NordVPN was paused.

SSH connectivity immediately returned.

### Architectural Improvement

Rather than modifying the networking configuration of a shared media system, the management role was moved to the dedicated `LAB-GATEWAY` server.

### Lesson Learned

When an overlay-network ping succeeds but application traffic fails, investigate:

- Competing VPN clients
- Routing tables
- Interface metrics
- Firewall profiles
- Service listeners
- Network-category changes

Successful ping does not prove that every application path is working.

## SSH Authorized-Key Permissions

### Risk

Windows OpenSSH may reject an authorized-key file if its permissions are too broad.

### Resolution

The administrators authorized-key file was restricted to the required administrative identities.

### Lesson Learned

Authentication failures are not always caused by an incorrect key.

File ownership and permissions are part of the SSH security model.

## Password Authentication Validation

### Goal

Confirm that key-only authentication was actually enforced.

### Validation

- Key authentication succeeded
- Password authentication was disabled
- A password-based connection attempt was rejected

### Lesson Learned

A hardening change should be tested from both directions:

- Confirm the approved method works
- Confirm the disallowed method fails

## Reboot Recovery

### Goal

Confirm that remote administration remains available without local interaction.

### Validation

After reboot:

- Tailscale started automatically
- OpenSSH started automatically
- RustDesk started automatically
- The management server rejoined the tailnet
- Remote SSH access worked
- Remote RustDesk access worked
- Wake-on-LAN remained functional

### Lesson Learned

A configuration is not complete until it survives reboot and works before interactive user login.