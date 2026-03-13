# Remote Access Architecture

This repository documents the architecture and configuration used to securely access my home development workstation remotely using Tailscale, SSH key authentication, and Wake-on-LAN automation.

---

## Revision History

### 2026-03-11
- Implemented SSH key authentication
- Disabled password authentication
- Added SSH config automation
- Implemented Wake-on-LAN automation
- Added Mac SSH keychain integration

### 2026-03-10
- Initial architecture
- Password based SSH access
- Manual login to devPC


---

## Why This Exists

This project started as an effort to organize my personal development environment across multiple machines.

I primarily work on both a Mac laptop and a more powerful desktop PC. While the Mac is convenient for mobility and coding, the PC is better suited for running heavier workloads such as virtual machines and security labs.

As my workflow evolved, I wanted a way to:

- Keep projects and infrastructure organized
- Seamlessly move between devices
- Run heavier workloads on my desktop
- Access my home workstation remotely when away from home

This led me to design a small home infrastructure that allows secure remote access to my workstation without exposing ports to the public internet.

The result is the architecture documented in this repository, which combines Tailscale, SSH, and Wake-on-LAN to allow secure remote access and automated system wake-up from anywhere.

---

## Goal

Securely access my home workstation from anywhere using
Tailscale, SSH, and Wake-on-LAN without exposing ports
to the internet.


---

## Architecture

Mac (client)
   |
   | Tailscale VPN
   v
homeGateway
   |
   | Wake-on-LAN packet
   v
devPC (main workstation)


---

## Automation

Command used from Mac:

lab

Process:

1. SSH to homeGateway
2. Send Wake-on-LAN packet
3. Wait for devPC to reconnect
4. SSH into devPC


---

## Authentication

Mac → homeGateway
SSH key authentication

Mac → devPC
SSH key authentication

Password authentication disabled.


---

## Security Properties

• No public ports exposed  
• Encrypted VPN overlay network (Tailscale)  
• SSH key authentication required  
• Private keys stored only on Mac  
• Wake-on-LAN restricted to internal network  


---

## Future Improvements

• Add ProxyJump architecture
• Expand internal lab machines
• Implement centralized logging
• Upgrade SSH to post-quantum algorithms