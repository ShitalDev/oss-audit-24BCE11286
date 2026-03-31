#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: [Shital Das] | Reg No: [24BCE11286]
# Course: Open Source Software
# Description: Loops through system directories and shows size and permissions

# ─────────────────────────────────────────
# ARRAY — list of important system directories to audit
# ─────────────────────────────────────────
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

echo "=================================================="
echo "       DISK AND PERMISSION AUDITOR               "
echo "=================================================="
echo ""
printf "  %-20s %-25s %-10s\n" "Directory" "Permissions (type/owner/group)" "Size"
echo "  ---------------------------------------------------------------"

# ─────────────────────────────────────────
# FOR LOOP — goes through each directory one by one
# ─────────────────────────────────────────
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to read it
    if [ -d "$DIR" ]; then

        # ls -ld shows directory info (not its contents)
        # awk extracts specific fields: $1=permissions, $3=owner, $4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gets the size in human-readable format (KB, MB, GB)
        # cut -f1 takes only the first column (the size, not the path)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # printf formats output into neat columns
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"

    else
        # If directory doesn't exist, print a message
        echo "  $DIR — does not exist on this system"
    fi

done

# ─────────────────────────────────────────
# BONUS — specifically check Git's config directory
# This is the software we chose for the audit
# ─────────────────────────────────────────
echo ""
echo "--------------------------------------------------"
echo "  GIT CONFIGURATION DIRECTORY CHECK"
echo "--------------------------------------------------"

# Git's system-wide config directory
GIT_CONFIG_DIR="/etc/git"

# Git's user-level config file (in home directory)
GIT_USER_CONFIG="$HOME/.gitconfig"

# Check system git config directory
if [ -d "$GIT_CONFIG_DIR" ]; then
    GIT_PERMS=$(ls -ld "$GIT_CONFIG_DIR" | awk '{print $1, $3, $4}')
    GIT_SIZE=$(du -sh "$GIT_CONFIG_DIR" 2>/dev/null | cut -f1)
    echo "  System Git Dir  : $GIT_CONFIG_DIR"
    echo "  Permissions     : $GIT_PERMS"
    echo "  Size            : $GIT_SIZE"
else
    echo "  System Git config directory (/etc/git) not found."
    echo "  This is normal — Git uses per-user config instead."
fi

echo ""

# Check user git config file
if [ -f "$GIT_USER_CONFIG" ]; then
    echo "  User Git Config : $GIT_USER_CONFIG — EXISTS ✔"
    ls -l "$GIT_USER_CONFIG"
else
    echo "  User Git config (~/.gitconfig) not found."
    echo "  To create it, run: git config --global user.name 'Your Name'"
fi

# Show where Git binary is installed
echo ""
echo "  Git Binary Location:"
which git && ls -l $(which git)

echo ""
echo "=================================================="
echo "  End of Disk and Permission Auditor"
echo "=================================================="
