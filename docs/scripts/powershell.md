# PowerShell Scripts

PowerShell automation scripts for Windows and cross-platform use with PowerShell Core.

## Available Scripts

### Setup and Configuration

#### `setup-dev-environment.ps1`
Configures a new development machine with common tools and settings.

**Usage**:
```powershell
.\setup-dev-environment.ps1 [-InstallTools] [-ConfigureGit]
```

**Features**:
- Installs Chocolatey package manager
- Installs development tools (Git, VS Code, etc.)
- Configures Git settings
- Sets up PowerShell profile

#### `configure-git.ps1`
Configures Git with standard settings for ShruggieTech projects.

**Usage**:
```powershell
.\configure-git.ps1 -UserName "Your Name" -UserEmail "your.email@example.com"
```

### Utilities

#### `get-system-info.ps1`
Collects and displays comprehensive system information.

**Usage**:
```powershell
.\get-system-info.ps1 [-ExportToFile] [-Format JSON|CSV]
```

**Output**:
- OS version and build
- CPU and memory details
- Disk space information
- Network configuration

#### `cleanup-old-files.ps1`
Removes temporary files and cleans up specified directories.

**Usage**:
```powershell
.\cleanup-old-files.ps1 -Path "C:\Temp" -OlderThanDays 30
```

**Options**:
- `-Path`: Directory to clean
- `-OlderThanDays`: Age threshold for deletion
- `-WhatIf`: Preview changes without executing

### Git Automation

#### `git-branch-cleanup.ps1`
Removes merged and stale Git branches.

**Usage**:
```powershell
.\git-branch-cleanup.ps1 [-RemoveRemote] [-Force]
```

#### `git-sync-all.ps1`
Syncs multiple Git repositories in a directory.

**Usage**:
```powershell
.\git-sync-all.ps1 -RootPath "C:\Projects"
```

## Installation

### Requirements
- PowerShell 5.1+ (Windows)
- PowerShell Core 7+ (cross-platform)

### Setup
```powershell
# Clone the repository
git clone https://github.com/shruggietech/dev-handbook.git
cd dev-handbook/scripts/powershell

# Set execution policy (if needed)
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Common Parameters

Most scripts support these common parameters:

- `-Verbose`: Display detailed output
- `-WhatIf`: Preview changes without executing
- `-Confirm`: Prompt for confirmation
- `-ErrorAction`: Control error handling behavior

## Best Practices

### Running Scripts Safely
```powershell
# Preview changes first
.\script-name.ps1 -WhatIf

# Run with confirmation prompts
.\script-name.ps1 -Confirm

# Run with detailed logging
.\script-name.ps1 -Verbose
```

### Error Handling
All scripts use `$ErrorActionPreference = 'Stop'` by default to ensure errors are caught and handled properly.

### Logging
Scripts log activities to:
- Console (default)
- Log files (when `-LogPath` is specified)
- Windows Event Log (for system-level scripts)

## Environment Variables

Some scripts use environment variables for configuration:

```powershell
# Set environment variables
$env:SHRUGGIE_GITHUB_TOKEN = "your-token"
$env:SHRUGGIE_API_URL = "https://api.example.com"
```

For persistent settings, add them to your PowerShell profile:
```powershell
# Edit profile
notepad $PROFILE

# Add environment variables
$env:SHRUGGIE_GITHUB_TOKEN = "your-token"
```

## Troubleshooting

### Execution Policy Errors
If you see "cannot be loaded because running scripts is disabled":

```powershell
# Check current policy
Get-ExecutionPolicy

# Set policy for current user
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### Module Not Found
Install required modules:

```powershell
# Install from PowerShell Gallery
Install-Module -Name ModuleName -Scope CurrentUser
```

### Permission Denied
Run PowerShell as Administrator for system-level operations:

```powershell
# Right-click PowerShell and select "Run as Administrator"
```

## Contributing

When adding new PowerShell scripts:

1. Use approved verbs (`Get-`, `Set-`, `New-`, etc.)
2. Include comment-based help
3. Support common parameters
4. Handle errors gracefully
5. Add parameter validation
6. Write Pester tests

Example script template:

```powershell
<#
.SYNOPSIS
    Brief description of the script

.DESCRIPTION
    Detailed description of what the script does

.PARAMETER ParameterName
    Description of the parameter

.EXAMPLE
    .\script-name.ps1 -ParameterName "value"

.NOTES
    Author: Your Name
    Version: 1.0
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true)]
    [string]$ParameterName
)

# Script implementation
```

## Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [PowerShell Best Practices](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-development-guidelines)
