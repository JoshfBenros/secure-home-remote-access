# SSH Key Authentication

## Purpose

SSH keys replace password authentication with a
public/private cryptographic key pair.

This improves security and enables automation.

---

## Key Structure

Private Key  
Stored on the Mac client

Public Key  
Stored on the remote servers

Example:

Private key:

~/.ssh/id_ed25519

Public key:

~/.ssh/id_ed25519.pub

---

## Authentication Flow

1. Client attempts SSH connection
2. Server checks authorized public keys
3. Client proves possession of the private key
4. Access is granted

---

## Why Use SSH Keys

Benefits:

- Strong cryptographic authentication
- No password transmission
- Resistant to brute force attacks
- Enables automated workflows

---

## Security Configuration

Password authentication disabled.

SSH access only possible with authorized keys.

---

## Files Used

Mac:

~/.ssh/id_ed25519

Remote systems:

authorized_keys