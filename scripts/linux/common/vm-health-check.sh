#!/usr/bin/env bash

set -u

section() {
    printf '\n========================================\n'
    printf '%s\n' "$1"
    printf '========================================\n'
}

section "IDENTITY"
printf 'Current user: '
whoami
printf 'Hostname: '
hostname
printf 'User and groups:\n'
id

section "OPERATING SYSTEM"
if [[ -f /etc/os-release ]]; then
    grep -E '^(PRETTY_NAME|VERSION_ID)=' /etc/os-release
fi
printf 'Kernel: '
uname -r

section "CPU"
lscpu | grep -E '^(CPU\(s\)|Model name|Thread\(s\) per core|Core\(s\) per socket):'

section "MEMORY"
free -h

section "STORAGE"
lsblk
printf '\nRoot filesystem usage:\n'
df -h /

section "NETWORK"
ip -brief address
printf '\nRouting table:\n'
ip route

section "VMWARE TOOLS"
if systemctl is-active --quiet open-vm-tools 2>/dev/null; then
    echo 'open-vm-tools service: active'
else
    echo 'open-vm-tools service: inactive or unavailable'
fi

dpkg -l 2>/dev/null | grep -E '^ii\s+open-vm-tools' || \
    echo 'open-vm-tools packages not detected'

section "FAILED SERVICES"
if command -v systemctl >/dev/null 2>&1; then
    systemctl --failed --no-pager
else
    echo 'systemctl is unavailable'
fi

section "UPDATES AVAILABLE"
if command -v apt >/dev/null 2>&1; then
    update_count=$(apt list --upgradable 2>/dev/null | tail -n +2 | wc -l)
    echo "Pending package updates: $update_count"
else
    echo 'apt is unavailable'
fi

section "DISK PRESSURE"
root_usage=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')
echo "Root filesystem usage: ${root_usage}%"

if [[ "$root_usage" -ge 90 ]]; then
    echo 'WARNING: Root filesystem usage is critically high.'
elif [[ "$root_usage" -ge 80 ]]; then
    echo 'WARNING: Root filesystem usage is high.'
else
    echo 'Root filesystem usage is within a comfortable range.'
fi

section "HEALTH CHECK COMPLETE"
date
