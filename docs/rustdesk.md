# RustDesk

## Purpose

RustDesk provides graphical remote administration of `LAB-GATEWAY`.

It complements SSH by providing access to the full Windows desktop when graphical configuration or troubleshooting is required.

## Installation

RustDesk is installed under:

```text
C:\Program Files\RustDesk
```

It runs as a Windows service.

## Service Configuration

The RustDesk service:

- Runs under `LocalSystem`
- Uses automatic startup
- Starts before interactive user login
- Remains available after reboot
- Supports unattended access

## Authentication Configuration

- Permanent password configured
- One-time-password access disabled
- Remote-access identifiers excluded from public documentation

## Power and Display Behavior

The management server is configured to remain awake while connected to power.

The lid action is set to **Do Nothing**.

The display is allowed to turn off normally.

This allows the system to remain available for remote access without keeping the display active.

## Validation

The following tests completed successfully:

- Remote connection from the MacBook Pro
- Reconnection after management-server reboot
- Availability before user login
- Continuous operation with the display turned off
- Continuous operation with the lid closed

## Role in the Architecture

RustDesk is used for graphical administration.

SSH is used for command-line administration and automation.

```text
Graphical administration
    RustDesk

Command-line administration
    OpenSSH
```

Keeping both options available improves flexibility during troubleshooting and configuration.