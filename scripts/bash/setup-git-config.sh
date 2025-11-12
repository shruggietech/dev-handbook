#!/usr/bin/env bash

# .SYNOPSIS
#     Configure recommended global Git settings for safe and efficient workflows.
#
# .DESCRIPTION
#     This script applies a set of recommended global Git configurations that help
#     prevent common pitfalls (like detached HEAD states during rebasing) and
#     improve overall Git workflow. These settings are applied globally to your
#     Git installation.
#
# .EXAMPLE
#     bash setup-git.sh
#
# .LINK
#     https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration

# Prevent accidental rebase during pull (use explicit merge strategy)
echo "Configuring pull strategy..."
git config --global pull.rebase false

# Automatically stash changes before rebase to prevent conflicts
echo "Enabling automatic stash during rebase..."
git config --global rebase.autoStash true

# Update dependent branches automatically during rebase (Git 2.38+)
echo "Enabling automatic update of dependent branches..."
git config --global rebase.updateRefs true

# Show more helpful output during rebase conflicts
echo "Improving rebase instruction format..."
git config --global rebase.instructionFormat "(%an <%ae>) %s"

# Use a more readable default branch name
echo "Setting default branch name to 'main'..."
git config --global init.defaultBranch main

# Enable color output for better readability
echo "Enabling colored output..."
git config --global color.ui auto

# Display current configuration
echo ""
echo "Git global configuration completed successfully!"
echo ""
echo "Current Git configuration:"
echo "=========================="
git config --global --list | grep -E "(pull.rebase|rebase.|init.defaultBranch|color.ui)"
echo ""
echo "You can verify all global settings with: git config --global --list"
