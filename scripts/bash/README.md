# Bash Scripts

This directory contains Bash shell scripts for Linux and macOS automation.

## Available Scripts

### Setup and Configuration
- `setup-dev-environment.sh` - Configure development environment
- `configure-git.sh` - Set up Git configuration

### Utilities
- `system-info.sh` - Display comprehensive system information
- `cleanup-logs.sh` - Remove old log files

### Git Automation
- `git-branch-cleanup.sh` - Clean up merged branches
- `git-sync-repos.sh` - Sync multiple repositories

## Prerequisites

- Bash 4.0 or later
- Common Unix utilities (grep, sed, awk, etc.)

## Usage

```bash
# Make script executable
chmod +x script-name.sh

# Run a script
./script-name.sh

# View help
./script-name.sh --help

# Run with options
./script-name.sh --option value
```

## Best Practices

- Always use `set -euo pipefail` for safety
- Quote variables: `"$VAR"`
- Use `shellcheck` for linting
- Test in safe environment first

## Contributing

When adding new scripts:
1. Follow Bash best practices
2. Include usage documentation
3. Add error handling
4. Make scripts portable
5. Update this README

## Resources

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
