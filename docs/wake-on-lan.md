# Wake-on-LAN

## Purpose

Wake-on-LAN allows `DEV-PC` to remain powered off until it is needed.

A management system on the local network sends a specially constructed network packet called a magic packet.

## Architecture

```text
MacBook Pro
    |
    | SSH
    v
LAB-GATEWAY
    |
    | Wake-on-LAN magic packet
    v
DEV-PC
```

## Why a Management Server Is Used

Wake-on-LAN packets normally need to originate from the local network where the target system is connected.

`LAB-GATEWAY` remains continuously available and acts as the internal Wake-on-LAN sender.

## PowerShell Implementation

The Wake-on-LAN workflow uses:

```text
wakeonlan.ps1
```

The script:

1. Normalizes the target MAC address
2. Builds a magic packet
3. Sends the packet through UDP
4. Uses the local network broadcast path
5. Triggers the development workstation to power on

Sensitive values such as the real MAC address and internal network details are excluded from this repository.

## Automation Flow

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
Send magic packet
    |
    v
DEV-PC powers on
```

After sending the packet, the automation waits for `DEV-PC` to become available and then starts the SSH connection.

## Migration

The original Wake-on-LAN implementation ran on the shared home-theater gateway.

During Home Lab 2.0 Phase 2, the script was migrated to `LAB-GATEWAY`.

The migration included:

- Moving the PowerShell script
- Updating the SSH alias
- Confirming the script path
- Verifying network broadcast behavior
- Successfully waking `DEV-PC`
- Restoring the complete automated workflow

## Validation

The following tests completed successfully:

- Magic-packet generation
- UDP broadcast transmission
- Development workstation wake-up
- Wake-on-LAN after management-server reboot
- End-to-end automation from the MacBook Pro

## Future Improvement

A sanitized and reusable version of the Wake-on-LAN script will be added to the `scripts/` directory.