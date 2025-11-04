# PowerShell Scripts

This directory contains PowerShell automation scripts for Windows and cross-platform use with PowerShell Core.

## Available Scripts

### Setup and Configuration
- `setup-dev-environment.ps1` - Configure development machine
- `configure-git.ps1` - Set up Git configuration

### Utilities
- `get-system-info.ps1` - Display comprehensive system information
- `cleanup-old-files.ps1` - Remove old files and free disk space

### Git Automation
- `git-branch-cleanup.ps1` - Clean up merged branches
- `git-sync-all.ps1` - Sync multiple repositories

## Prerequisites

- PowerShell 5.1+ (Windows) or PowerShell Core 7+ (cross-platform)
- Appropriate permissions for system operations

## Usage

```powershell
# Run a script
.\script-name.ps1

# Get help
Get-Help .\script-name.ps1 -Full

# Run with parameters
.\script-name.ps1 -Parameter Value
```

## Setting Execution Policy

If you encounter execution policy errors:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Contributing

When adding new scripts:
1. Follow PowerShell best practices
2. Include comment-based help
3. Add parameter validation
4. Handle errors appropriately
5. Update this README

## Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
