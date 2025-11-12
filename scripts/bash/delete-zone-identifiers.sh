#!/usr/bin/env bash

set -euo pipefail

# Defaults
TARGET_DIR="."

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--Directory)
            TARGET_DIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

# Confirm target exists
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a directory." >&2
    exit 1
fi

# Remove the Zone.Identifier junk
find "$TARGET_DIR" -type f -name '*:Zone.Identifier' -delete
