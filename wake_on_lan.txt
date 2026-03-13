# Wake-on-LAN System

## Purpose

Wake-on-LAN allows a computer to be powered on remotely
by sending a special network packet called a **magic packet**.

This allows the workstation to remain powered off until
remote access is required.

---

## Architecture Role

Mac
↓
SSH
↓
homeGateway
↓
Wake-on-LAN packet
↓
devPC

---

## Why Use Gateway

The Wake-on-LAN packet must be sent from inside the
local network.

The homeGateway acts as the internal trigger point.

---

## Automation Script

The Mac sends the packet through SSH.

Example:

ssh homeGateway "wakeonlan <MAC_ADDRESS>"

---

## Benefits

- Saves power when workstation is idle
- Allows remote startup
- Integrates with SSH automation

---

## Future Improvements

- Health checks before connection
- Wake multiple lab machines