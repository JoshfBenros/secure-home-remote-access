# Tailscale Setup

## Purpose

Tailscale provides secure connectivity between devices
using a private encrypted network without exposing
services to the public internet.

---

## Devices in Network

MacBook Pro (client)

homeGateway

devPC (main workstation)

---

## Why Tailscale

Benefits:

- No port forwarding required
- Encrypted WireGuard connections
- Simple device management
- Works across networks

---

## Architecture Role

Tailscale acts as the **private backbone network**
that connects all machines.

Mac
↓
Tailscale network
↓
homeGateway
↓
internal machines

---

## Security Benefits

- Devices only reachable by authorized nodes
- Traffic encrypted end-to-end
- No public IP exposure

---

## Future Improvements

- Tag-based device access policies
- Network segmentation
- Access control rules