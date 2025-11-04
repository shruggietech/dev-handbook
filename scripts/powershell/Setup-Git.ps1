<#
.SYNOPSIS
    Configures Git identity and default settings for ShruggieTech projects.

.DESCRIPTION
    Sets the user's Git name, email, and preferred default branch.
    Run this once on a new workstation to initialize your Git environment.

.EXAMPLE
    .\Setup-Git.ps1 -Name "Jane Developer" -Email "jane@shruggietech.com"
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$Email
)

Write-Host "Configuring Git identity for $Name <$Email>..." -ForegroundColor Cyan

git config --global user.name "$Name"
git config --global user.email "$Email"
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global pull.rebase false

Write-Host "Git configuration complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Verification:"
git config --list --global | Select-String "user.name|user.email|init.defaultBranch"
