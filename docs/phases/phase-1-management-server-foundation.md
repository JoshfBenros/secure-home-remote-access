# Phase 1 — Management Server Foundation

**Status:** Complete

## Objective

Prepare a dedicated Windows 11 Pro management server that can remain available for remote administration without relying on the shared home-theater system.

## Completed Work

- Prepared a dedicated Windows 11 Pro management server
- Created a primary administrative Windows profile
- Kept the built-in Administrator and Guest accounts disabled
- Renamed the management server to `LAB-GATEWAY`
- Installed Tailscale and connected the server to the existing tailnet
- Enabled Tailscale unattended mode
- Verified MagicDNS resolution from the MacBook Pro
- Installed RustDesk as a Windows service
- Configured RustDesk for unattended access
- Disabled one-time-password access
- Confirmed Tailscale and RustDesk start automatically
- Verified remote access after reboot
- Configured the management server to remain awake while connected to power
- Changed the lid action to **Do Nothing**
- Allowed the display to turn off normally
- Disabled sleep and hibernation
- Enabled BIOS battery-health management for continuous AC use
- Separated the management role from the shared home-theater laptop

## Validation

The following behaviors were tested successfully:

- Management server reboot recovery
- Automatic Tailscale reconnection
- Automatic RustDesk availability
- Remote RustDesk access from the MacBook Pro
- MagicDNS resolution using `lab-gateway`
- Continuous operation with the lid closed or display turned off

## Design Outcome

Phase 1 established a dedicated and independently managed foundation for the remote-access environment.

The management server is now separated from the shared Plex and home-theater system, reducing the chance that unrelated software or networking changes will disrupt administrative access.

## Next Phase

[Phase 2 — Secure Remote Administration](phase-2-secure-remote-administration.md)