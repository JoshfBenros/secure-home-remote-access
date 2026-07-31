#!/usr/bin/env bash

set -u

section() {
    printf '\n========================================\n'
    printf '%s\n' "$1"
    printf '========================================\n'
}

section "ROOT FILESYSTEM"
df -h /

section "LARGEST TOP-LEVEL DIRECTORIES"
sudo du -xhd1 / 2>/dev/null | sort -h

section "LARGEST /VAR DIRECTORIES"
sudo du -xhd1 /var 2>/dev/null | sort -h

section "LARGEST /USR DIRECTORIES"
sudo du -xhd1 /usr 2>/dev/null | sort -h

section "LARGEST HOME DIRECTORIES"
sudo du -xhd2 /home 2>/dev/null | sort -h | tail -n 20

section "APT PACKAGE CACHE"
sudo du -sh /var/cache/apt 2>/dev/null

section "SYSTEM JOURNAL"
sudo journalctl --disk-usage 2>/dev/null

section "OLD DOWNLOADED PACKAGES"
find /var/cache/apt/archives -maxdepth 1 -type f -name '*.deb' 2>/dev/null |
    wc -l |
    awk '{print "Cached .deb files:", $1}'

section "LARGEST FILES OVER 250 MB"
sudo find / -xdev -type f -size +250M \
    -printf '%s %p\n' 2>/dev/null |
    sort -nr |
    head -n 20 |
    awk '{
        size=$1/1024/1024;
        $1="";
        printf "%.1f MB%s\n", size, $0
    }'

section "AUDIT COMPLETE"
date
