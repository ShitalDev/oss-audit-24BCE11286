#!/bin/bash
# Script 4: Log File Analyzer
# Author: [Shital Das] | Reg No: [24BCE11286]
# Course: Open Source Software
# Description: Reads a log file, counts keyword matches, shows summary
# Usage: ./script4.sh /path/to/logfile [keyword]

# ─────────────────────────────────────────
# COMMAND LINE ARGUMENTS
# $1 = first argument (log file path)
# $2 = second argument (keyword to search), default is "error"
# ─────────────────────────────────────────
LOGFILE=$1
KEYWORD=${2:-"error"}    # If no keyword given, use "error" as default
COUNT=0                  # Counter starts at zero

echo "=================================================="
echo "       LOG FILE ANALYZER                         "
echo "=================================================="
echo ""

# ─────────────────────────────────────────
# VALIDATION — check if a log file was provided
# ─────────────────────────────────────────
if [ -z "$LOGFILE" ]; then
    echo "  No log file specified. Trying default system log..."

    # Try common log file locations in WSL/Ubuntu
    if [ -f "/var/log/dpkg.log" ]; then
        LOGFILE="/var/log/dpkg.log"
        echo "  Using: $LOGFILE"
    elif [ -f "/var/log/apt/history.log" ]; then
        LOGFILE="/var/log/apt/history.log"
        echo "  Using: $LOGFILE"
    else
        echo "  No log file found. Creating a sample log for demo..."

        # Create a sample log file so the script still works
        LOGFILE="/tmp/sample_git.log"
        cat > "$LOGFILE" << 'EOF'
2025-01-01 10:00:01 INFO Git initialized repository successfully
2025-01-01 10:01:05 ERROR Failed to connect to remote repository
2025-01-01 10:02:10 INFO Commit created: added README.md
2025-01-01 10:03:15 WARNING Large file detected, consider using Git LFS
2025-01-01 10:04:20 ERROR Authentication failed for remote push
2025-01-01 10:05:25 INFO Branch 'main' created successfully
2025-01-01 10:06:30 ERROR Merge conflict in file: index.html
2025-01-01 10:07:35 INFO Pull request merged successfully
2025-01-01 10:08:40 WARNING Detached HEAD state detected
2025-01-01 10:09:45 ERROR Repository corruption detected in pack file
2025-01-01 10:10:50 INFO Garbage collection completed successfully
EOF
        echo "  Sample log created at $LOGFILE"
    fi
fi

# ─────────────────────────────────────────
# CHECK — make sure the file actually exists
# ─────────────────────────────────────────
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found. Exiting."
    exit 1
fi

# Check if file is empty — if so, print warning
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: Log file is empty. Nothing to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo ""
echo "--------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "--------------------------------------------------"

# ─────────────────────────────────────────
# WHILE READ LOOP — reads the file line by line
# IFS= preserves whitespace exactly
# -r prevents backslash interpretation
# ─────────────────────────────────────────
while IFS= read -r LINE; do

    # IF-THEN — check if this line contains the keyword
    # grep -iq means: case-insensitive (-i) and quiet (-q, no output)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment counter by 1
    fi

done < "$LOGFILE"    # Feed the file into the while loop

# ─────────────────────────────────────────
# SUMMARY — print the results
# ─────────────────────────────────────────
echo ""
echo "  RESULTS:"
echo "  --------"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in the log file."
echo ""

# Show the last 5 lines that match the keyword
echo "  Last 5 matching lines:"
echo "  ----------------------"
grep -i "$KEYWORD" "$LOGFILE" | tail -5

echo ""
echo "  Total lines in file : $(wc -l < "$LOGFILE")"
echo "  Matching lines      : $COUNT"

echo ""
echo "=================================================="
echo "  End of Log File Analyzer"
echo "=================================================="
