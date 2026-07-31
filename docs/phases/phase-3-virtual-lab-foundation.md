# Phase 3 — Virtual Lab Foundation

**Status:** Complete

## Objective

Prepare the existing Linux virtual machines as stable, organized, and recoverable lab systems before introducing more advanced cybersecurity workloads.

Phase 3 focused on:

- Standardizing virtual-machine roles and hostnames
- Expanding storage
- Simplifying disk layouts
- Updating both systems
- Verifying critical services
- Creating reusable maintenance scripts
- Establishing clean VMware rollback points

## Systems Prepared

### KALI-01

**Role:** Offensive security workstation

`KALI-01` will be used for:

- Reconnaissance
- Enumeration
- Vulnerability assessment
- Packet capture
- Offensive security tooling
- Controlled attack simulations

Phase 3 improvements included:

- Expanded the virtual disk from 30 GB to 80 GB
- Extended the Linux root filesystem
- Replaced the legacy swap partition with a 4 GB swap file
- Simplified the partition layout
- Standardized the hostname as `kali-01`
- Repaired a corrupted Zsh history file
- Installed current system updates
- Verified storage, memory, networking, VMware Tools, and services
- Created a clean baseline snapshot

### NIDS-01

**Role:** Network intrusion-detection workstation

`NIDS-01` will be used for:

- Snort IDS
- Traffic monitoring
- Alert generation
- Detection development
- Defensive analysis

Phase 3 improvements included:

- Expanded the virtual disk from 20 GB to 40 GB
- Extended the Linux root filesystem
- Standardized the hostname as `nids-01`
- Installed current system updates
- Verified Snort remained active after configuration changes and reboot
- Verified storage, memory, networking, VMware Tools, and services
- Created a clean baseline snapshot

## Centralized Linux Scripts

Reusable Linux maintenance scripts are now stored in the Git repository rather than existing only inside the virtual machines.

```text
scripts/
└── linux/
    ├── common/
    │   ├── vm-health-check.sh
    │   └── storage-audit.sh
    ├── kali/
    └── ubuntu/
```

The current scripts provide:

- General VM health checks
- Storage and filesystem auditing
- Consistent maintenance across Linux systems
- Version-controlled master copies

A `.gitattributes` rule preserves Linux line endings:

```text
*.sh text eol=lf
```

File sizes and SHA-256 hashes were compared to confirm that the repository and VM copies matched.

## Baseline Snapshots

New VMware snapshots were created only after each virtual machine was:

- Updated
- Reconfigured
- Rebooted
- Health-checked
- Confirmed to be operating normally

These snapshots provide clean rollback points before future security tooling and network changes are introduced.

## Final Phase 3 Architecture

```text
DEV-PC
    |
    | VMware Workstation
    |
    ├── KALI-01
    |   Offensive security workstation
    |
    └── NIDS-01
        Network intrusion-detection workstation
```

## Design Outcomes

Phase 3 established:

- Clear offensive and defensive VM roles
- Standardized system names
- Sufficient storage for future tools and logs
- Simpler Linux storage management
- Centralized maintenance scripts
- Reliable health-check procedures
- Clean VMware recovery points
- A stable platform for future cybersecurity exercises

## Key Lessons

### Virtual-Disk Expansion Has Multiple Layers

Increasing a disk size in VMware does not automatically expand the usable Linux filesystem.

The full process may require:

1. Expanding the virtual disk
2. Extending or reorganizing partitions
3. Growing the filesystem
4. Verifying the final result inside the guest operating system

### Scripts Should Have a Single Source of Truth

Reusable scripts should be maintained in Git and copied to systems as needed.

This provides:

- Version history
- Easier recovery
- Consistent behavior across systems
- Safer editing
- Integrity verification

### Snapshots Should Represent Known-Good States

Snapshots were created only after updates, configuration changes, service validation, and reboot testing were completed.

## Completion Criteria

Phase 3 was considered complete when:

- Both VMs had clearly defined roles
- Storage expansions were verified
- Hostnames were standardized
- System updates were completed
- VMware Tools were operational
- Snort remained active on `NIDS-01`
- Reusable scripts were centralized in Git
- Clean baseline snapshots were created
- Both systems passed final health checks

## Next Phase

Phase 4 will build on this foundation by introducing network segmentation, security monitoring, vulnerable targets, and controlled attack-and-detection exercises.

See the [project roadmap](../roadmap.md) for the full plan.