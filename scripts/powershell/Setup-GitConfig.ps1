<#
.SYNOPSIS
    Configure recommended global Git settings for safe and efficient workflows.
.DESCRIPTION
    This script applies a set of recommended global Git configurations that help
    prevent common pitfalls (like detached HEAD states during rebasing) and
    improve overall Git workflow. These settings are applied globally to your
    Git installation.
.EXAMPLE
    .\Setup-GitConfig.ps1
.EXAMPLE
    .\Setup-GitConfig.ps1 -Help
.LINK
    https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
#>
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='None',DefaultParameterSetName='Default')]
Param(
    [Parameter(Mandatory=$true,ParameterSetName='HelpText')]
    [Alias("h")]
    [Switch]$Help
)

# Internal self-awareness variables for use in verbosity and logging
$thisFunctionReference = "{0}" -f $MyInvocation.MyCommand
$thisSubFunction = "{0}" -f $MyInvocation.MyCommand
$thisFunction = if ($null -eq $thisFunction) { $thisSubFunction } else { -join("$thisFunction", ":", "$thisSubFunction") }

# Catch Help Text Requests
if ($Help) {
    Get-Help -Name $MyInvocation.MyCommand.Path -Full
    Exit 0
}

# Main Process Logic
Write-Host "Configuring recommended global Git settings..." -ForegroundColor Cyan
Write-Host ""

# Prevent accidental rebase during pull (use explicit merge strategy)
Write-Host "Configuring pull strategy..." -ForegroundColor Yellow
git config --global pull.rebase false

# Automatically stash changes before rebase to prevent conflicts
Write-Host "Enabling automatic stash during rebase..." -ForegroundColor Yellow
git config --global rebase.autoStash true

# Update dependent branches automatically during rebase (Git 2.38+)
Write-Host "Enabling automatic update of dependent branches..." -ForegroundColor Yellow
git config --global rebase.updateRefs true

# Show more helpful output during rebase conflicts
Write-Host "Improving rebase instruction format..." -ForegroundColor Yellow
git config --global rebase.instructionFormat "(%an <%ae>) %s"

# Use a more readable default branch name
Write-Host "Setting default branch name to 'main'..." -ForegroundColor Yellow
git config --global init.defaultBranch main

# Enable color output for better readability
Write-Host "Enabling colored output..." -ForegroundColor Yellow
git config --global color.ui auto

# Display current configuration
Write-Host ""
Write-Host "Git global configuration completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Current Git configuration:" -ForegroundColor Cyan
Write-Host "==========================" -ForegroundColor Cyan

# Retrieve and display the settings we just configured
$ConfigSettings = @(
    'pull.rebase',
    'rebase.autoStash',
    'rebase.updateRefs',
    'rebase.instructionFormat',
    'init.defaultBranch',
    'color.ui'
)

foreach ($Setting in $ConfigSettings) {
    $Value = git config --global --get $Setting
    if ($Value) {
        Write-Host "$Setting = $Value" -ForegroundColor White
    }
}

Write-Host ""
Write-Host "You can verify all global settings with: " -ForegroundColor Gray -NoNewline
Write-Host "git config --global --list" -ForegroundColor White

# Exit Gracefully
Exit 0
