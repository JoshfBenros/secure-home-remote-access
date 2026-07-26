# SSH Key Authentication

## Purpose

SSH key authentication provides secure command-line access without requiring account passwords to be transmitted or entered during each connection.

The current implementation allows the MacBook Pro to connect securely to `LAB-GATEWAY` and `DEV-PC`.

## Architecture

```text
MacBook Pro
    |
    | ED25519 private key
    | Tailscale / SSH
    v
LAB-GATEWAY
    |
    | Authorized public key
    v
Key-only authentication
```

## Key Model

The SSH key pair consists of:

- A private key stored on the MacBook Pro
- A public key installed on authorized remote systems

The private key remains on the administrative client.

The remote server verifies that the client possesses the corresponding private key without receiving the private key itself.

## OpenSSH Server

OpenSSH Server is installed on Windows as an optional capability.

The server runs through the Windows service:

```text
sshd
```

The name stands for Secure Shell daemon.

The service:

- Listens for incoming SSH connections
- Starts automatically
- Runs before user login
- Accepts connections through the Windows Firewall

## Windows Administrator Keys

Because the SSH account is a member of the local Administrators group, the public key is stored in:

```text
C:\ProgramData\ssh\administrators_authorized_keys
```

The file permissions were restricted so that only the required administrative identities can modify or read the file.

Correct permissions are required because OpenSSH may reject authorized-key files that are accessible by unexpected users or groups.

## Authentication Hardening

After key authentication was verified, password authentication was disabled in the OpenSSH server configuration.

The final design requires an authorized private key.

Validation confirmed:

- SSH key authentication succeeds
- Password authentication is rejected
- SSH continues to work after reboot

## Default Shell

PowerShell was configured as the default shell for Windows SSH sessions.

This provides a native Windows administrative environment immediately after login.

## SSH Client Configuration

The MacBook Pro uses:

```text
~/.ssh/config
```

to define SSH aliases and connection settings.

Example structure:

```sshconfig
Host labGateway
    HostName <management-hostname>
    User <administrative-user>
    IdentityFile ~/.ssh/id_ed25519

Host devPC
    HostName <development-hostname>
    User <development-user>
    IdentityFile ~/.ssh/id_ed25519
```

Sensitive values are not included in this public repository.

## Scripts vs. Configuration

The SSH configuration file defines:

- Host aliases
- Hostnames
- Usernames
- Identity files

The automation script only calls the alias.

For example:

```text
ssh labGateway
```

This separates workflow logic from environment-specific configuration.

## Security Properties

- Private key remains on the MacBook Pro
- Public keys are installed only on authorized systems
- Password authentication is disabled
- SSH traffic uses the Tailscale network path
- Administrative ports are not intentionally exposed to the public internet
- Sensitive addresses and identities are excluded from documentation

## Validation

The following tests completed successfully:

- Key authentication to `LAB-GATEWAY`
- Key authentication to `DEV-PC`
- Password authentication rejection
- PowerShell default shell
- OpenSSH automatic startup
- SSH access after management-server reboot