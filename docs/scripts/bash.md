# Bash Scripts

Shell automation scripts for Linux and macOS systems.

## Available Scripts

### Setup and Configuration

#### `setup-dev-environment.sh`
Configures a new development machine with essential tools.

**Usage**:
```bash
./setup-dev-environment.sh [options]
```

**Options**:
- `--install-tools`: Install development tools
- `--configure-git`: Set up Git configuration
- `--update-system`: Update package manager

**Features**:
- Detects OS (Ubuntu, Debian, macOS, etc.)
- Installs package managers (apt, brew)
- Configures shell environment
- Sets up dotfiles

#### `configure-git.sh`
Configures Git with standard settings.

**Usage**:
```bash
./configure-git.sh --name "Your Name" --email "your.email@example.com"
```

### Utilities

#### `system-info.sh`
Displays comprehensive system information.

**Usage**:
```bash
./system-info.sh [--output json|text]
```

**Information Displayed**:
- OS and kernel version
- CPU and memory usage
- Disk space
- Network interfaces

#### `cleanup-logs.sh`
Removes old log files and frees up disk space.

**Usage**:
```bash
./cleanup-logs.sh --path /var/log --days 30
```

**Options**:
- `--path`: Directory to clean
- `--days`: Keep files newer than N days
- `--dry-run`: Preview without deleting

### Git Automation

#### `git-branch-cleanup.sh`
Removes merged and stale branches.

**Usage**:
```bash
./git-branch-cleanup.sh [--remote] [--force]
```

#### `git-sync-repos.sh`
Syncs multiple Git repositories.

**Usage**:
```bash
./git-sync-repos.sh --root-dir ~/projects
```

### Build and Deploy

#### `build-project.sh`
Generic build script for various project types.

**Usage**:
```bash
./build-project.sh --type [nodejs|python|go|docker]
```

#### `deploy.sh`
Deployment automation script.

**Usage**:
```bash
./deploy.sh --environment [dev|staging|prod]
```

## Installation

### Requirements
- Bash 4.0 or later
- Common Unix utilities (grep, sed, awk, etc.)

### Setup
```bash
# Clone the repository
git clone https://github.com/shruggietech/dev-handbook.git
cd dev-handbook/scripts/bash

# Make scripts executable
chmod +x *.sh

# Optionally, add to PATH
echo 'export PATH="$PATH:~/dev-handbook/scripts/bash"' >> ~/.bashrc
source ~/.bashrc
```

## Script Structure

All scripts follow this general structure:

```bash
#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${LOG_FILE:-/tmp/script.log}"

# Functions
function main() {
    # Main script logic
}

# Entry point
main "$@"
```

## Common Patterns

### Error Handling
```bash
# Exit on error
set -e

# Custom error handler
trap 'echo "Error on line $LINENO"' ERR

# Check command success
if ! command -v git &> /dev/null; then
    echo "Git is not installed"
    exit 1
fi
```

### Logging
```bash
# Log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "Starting process..."
```

### Argument Parsing
```bash
while [[ $# -gt 0 ]]; do
    case $1 in
        --name)
            NAME="$2"
            shift 2
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done
```

### Checking Dependencies
```bash
check_dependencies() {
    local deps=("git" "curl" "jq")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Error: $dep is not installed"
            exit 1
        fi
    done
}
```

## Environment Variables

Configure scripts using environment variables:

```bash
# Set in shell
export SHRUGGIE_API_KEY="your-key"
export SHRUGGIE_ENV="production"

# Or in .env file
echo 'SHRUGGIE_API_KEY=your-key' >> .env

# Load .env in script
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi
```

## Best Practices

### Always Use
- `set -euo pipefail` for safety
- Quotes around variables: `"$VAR"`
- `shellcheck` for linting
- Functions for reusable code
- Comments for complex logic

### Avoid
- Parsing `ls` output
- Using `eval` unnecessarily
- Hardcoding paths
- Ignoring errors silently

### Example Best Practices Script
```bash
#!/bin/bash
set -euo pipefail

# Configuration
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Functions
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS]

Options:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    --name NAME         Specify a name
EOF
}

main() {
    local name=""
    local verbose=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            --name)
                name="$2"
                shift 2
                ;;
            *)
                echo "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done

    # Validate inputs
    if [[ -z "$name" ]]; then
        echo "Error: --name is required"
        usage
        exit 1
    fi

    # Main logic
    echo "Hello, $name!"
}

# Entry point
main "$@"
```

## Debugging

### Enable Debug Mode
```bash
# Show commands being executed
bash -x script.sh

# Or within script
set -x
```

### Common Issues

**Permission Denied**:
```bash
chmod +x script.sh
```

**Line Ending Issues** (Windows):
```bash
dos2unix script.sh
# or
sed -i 's/\r$//' script.sh
```

**Variable Not Found**:
```bash
# Use default value
VAR="${VAR:-default}"

# Check if set
if [[ -z "${VAR:-}" ]]; then
    echo "VAR is not set"
fi
```

## Testing

Use [bats](https://github.com/bats-core/bats-core) for testing:

```bash
# Install bats
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local

# Create test file
cat > test_script.bats << 'EOF'
#!/usr/bin/env bats

@test "script runs without error" {
    run ./script.sh --name test
    [ "$status" -eq 0 ]
}
EOF

# Run tests
bats test_script.bats
```

## Resources

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/) - Shell script linter
- [Bash Pitfalls](https://mywiki.wooledge.org/BashPitfalls)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
