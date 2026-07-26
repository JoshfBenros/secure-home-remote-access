# Security Considerations

This project is documented publicly, so sensitive infrastructure details are intentionally excluded.

## Excluded Information

The repository does not publish:

- Passwords
- Private SSH keys
- RustDesk passwords
- RustDesk identifiers
- Tailscale IP addresses
- Public IP addresses
- Microsoft account information
- Real MAC addresses
- Exact internal network ranges
- Screenshots containing credentials or account details

## Remote-Access Design

The environment avoids intentionally exposing administrative services directly to the public internet.

Tailscale provides the private network path used for management access.

## SSH

- SSH uses ED25519 key authentication
- Private keys remain on the MacBook Pro
- Public keys are installed only on authorized systems
- Password authentication is disabled
- Authorized-key file permissions are restricted
- PowerShell is used as the Windows SSH shell

## Windows Accounts

- The built-in Administrator account remains disabled
- The Guest account remains disabled
- Administrative access uses the primary Windows profile

## RustDesk

- Permanent password access is configured
- One-time-password access is disabled
- Remote-access identifiers are not published

## Separation of Concerns

Management services run on the dedicated `LAB-GATEWAY` system rather than the shared home-theater and Plex device.

This reduces the chance that unrelated software or networking changes will affect remote administration.

## Public Documentation

Configuration examples use placeholders instead of real infrastructure values.

Any future scripts added to the repository will be sanitized before publication.