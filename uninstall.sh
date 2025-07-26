#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/hypr"
BACKUP_DIR="$CONFIG_DIR.bak"

echo "[*] Uninstalling hypr-config..."

if [ -L "$CONFIG_DIR" ]; then
    echo "[!] Removing symlink at $CONFIG_DIR"
    rm "$CONFIG_DIR"
else
    echo "[!] No symlink found at $CONFIG_DIR — skipping"
fi

if [ -d "$BACKUP_DIR" ]; then
    echo "[!] Restoring backup from $BACKUP_DIR"
    mv "$BACKUP_DIR" "$CONFIG_DIR"
    echo "[✓] Backup restored."
else
    echo "[i] No backup found. Nothing to restore."
fi

echo "[✓] Uninstall complete."

