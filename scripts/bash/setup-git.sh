#!/usr/bin/env bash

# .SYNOPSIS
#     Configures Git identity and default settings for ShruggieTech projects.
#
# .DESCRIPTION
#     Sets the user's Git name, email, and preferred default branch.
#     Run this once on a new workstation to initialize your Git environment.
#
# .PARAMETER -n, --name
#     Your full name for Git commits.
#
# .PARAMETER -e, --email
#     Your email address for Git commits.
#
# .PARAMETER -h, --help
#     Display this help message.
#
# .EXAMPLE
#     bash setup-git.sh -n "Jane Developer" -e "jane@shruggietech.com"
#
# .EXAMPLE
#     bash setup-git.sh --name "Jane Developer" --email "jane@shruggietech.com"

# Function to display help text
show_help() {
    cat << EOF
Configures Git identity and default settings for ShruggieTech projects.

USAGE:
    bash setup-git.sh -n "Your Name" -e "your.email@example.com"
    bash setup-git.sh --name "Your Name" --email "your.email@example.com"

OPTIONS:
    -n, --name      Your full name for Git commits (required)
    -e, --email     Your email address for Git commits (required)
    -h, --help      Display this help message

EXAMPLES:
    bash setup-git.sh -n "Jane Developer" -e "jane@shruggietech.com"
    bash setup-git.sh --name "John Doe" --email "john@example.com"

DESCRIPTION:
    Sets the user's Git name, email, and preferred default branch.
    Run this once on a new workstation to initialize your Git environment.

    This script configures:
    - user.name (your full name)
    - user.email (your email address)
    - init.defaultBranch (set to 'main')
    - core.autocrlf (set to 'input' for cross-platform compatibility)
    - pull.rebase (set to 'false' for explicit merge strategy)

EOF
    exit 0
}

# Parse command line arguments
NAME=""
EMAIL=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            NAME="$2"
            shift 2
            ;;
        -e|--email)
            EMAIL="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            echo "Use -h or --help for usage information." >&2
            exit 1
            ;;
    esac
done

# Validate required parameters
if [[ -z "$NAME" ]] || [[ -z "$EMAIL" ]]; then
    echo "Error: Both name and email are required." >&2
    echo "" >&2
    echo "Usage: bash setup-git.sh -n \"Your Name\" -e \"your.email@example.com\"" >&2
    echo "Use -h or --help for more information." >&2
    exit 1
fi

# Main configuration logic
echo "Configuring Git identity for $NAME <$EMAIL>..."

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global pull.rebase false

echo ""
echo "Git configuration complete!"
echo ""
echo "Verification:"
git config --list --global | grep -E "user.name|user.email|init.defaultBranch"

exit 0
