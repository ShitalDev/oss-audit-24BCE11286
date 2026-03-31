#!/bin/bash
# Script 1: System Identity Report
# Author: SHITAL DAS | Reg No: 24BCE11286
# Course: Open Source Software
# Description: Displays system information like a welcome screen

# ─────────────────────────────────────────
# VARIABLES — store student and software info
# ─────────────────────────────────────────
STUDENT_NAME="SHITAL DAS"        # Your actual name
REG_NO="24BCE11286"              # Your registration number
SOFTWARE_CHOICE="Git"            # The open-source software we chose

# ─────────────────────────────────────────
# SYSTEM INFO — using command substitution $()
# Each command runs and its output is stored in a variable
# ─────────────────────────────────────────
KERNEL=$(uname -r)                   # Gets the Linux kernel version
USER_NAME=$(whoami)                  # Gets the currently logged-in username
HOME_DIR=$(echo $HOME)               # Gets the home directory path
UPTIME=$(uptime -p)                  # Gets how long system has been running
CURRENT_DATE=$(date '+%d %B %Y')     # Gets current date in readable format
CURRENT_TIME=$(date '+%H:%M:%S')     # Gets current time

# Gets the Linux distribution name from the OS release file
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')

# The license that covers the Linux kernel (and Git) is GPL v2
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# ─────────────────────────────────────────
# DISPLAY — print everything neatly
# ─────────────────────────────────────────
echo "=================================================="
echo "       OPEN SOURCE AUDIT — SYSTEM REPORT         "
echo "=================================================="
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Reg No    : $REG_NO"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "--------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "--------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged In As : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "--------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "--------------------------------------------------"
echo "  This system runs on Linux."
echo "  Linux is covered by: $OS_LICENSE"
echo "  Git (chosen software) is also licensed under GPL v2."
echo "  This means you are free to use, study, modify,"
echo "  and share it — forever."
echo ""
echo "=================================================="
echo "  End of System Identity Report"
echo "=================================================="
