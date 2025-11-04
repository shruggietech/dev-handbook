# Prerequisites

Before using the ShruggieTech Dev Handbook resources, ensure you have the following tools and software installed on your system.

## General Requirements

### Git
Version control system for cloning repositories and managing code.

- **Windows**: Download from [git-scm.com](https://git-scm.com/)
- **macOS**: `brew install git` or use Xcode Command Line Tools
- **Linux**: `sudo apt install git` (Debian/Ubuntu) or `sudo yum install git` (RHEL/CentOS)

### Text Editor / IDE
Choose your preferred development environment:

- [Visual Studio Code](https://code.visualstudio.com/) (recommended)
- [Sublime Text](https://www.sublimetext.com/)
- [JetBrains IDEs](https://www.jetbrains.com/)
- [Vim](https://www.vim.org/) / [Neovim](https://neovim.io/)

## Platform-Specific Requirements

### For PowerShell Scripts

**Windows**:
- PowerShell 5.1 or later (included with Windows 10/11)
- PowerShell 7+ recommended for cross-platform support

**macOS/Linux**:
- [PowerShell Core 7+](https://github.com/PowerShell/PowerShell)

### For Bash Scripts

**macOS/Linux**:
- Bash 4.0 or later (usually pre-installed)

**Windows**:
- [Git Bash](https://git-scm.com/) (included with Git for Windows)
- [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/)

### For Python Scripts

**All Platforms**:
- Python 3.8 or later
- pip (Python package installer)

Download from [python.org](https://www.python.org/) or use a package manager:
- **Windows**: `winget install Python.Python.3.11`
- **macOS**: `brew install python`
- **Linux**: `sudo apt install python3 python3-pip`

## Optional Tools

### Node.js (for JavaScript templates)
- Download from [nodejs.org](https://nodejs.org/)
- Recommended: Use [nvm](https://github.com/nvm-sh/nvm) for version management

### Docker (for containerized workflows)
- Download from [docker.com](https://www.docker.com/)

### GitHub CLI
- Install from [cli.github.com](https://cli.github.com/)
- Useful for repository management and automation

## Verifying Installation

Run these commands to verify your setup:

```bash
# Git
git --version

# Python
python --version
pip --version

# Node.js (if applicable)
node --version
npm --version

# PowerShell (if applicable)
pwsh --version

# Bash (if applicable)
bash --version
```

## Next Steps

Once you have the prerequisites installed, proceed to the [Setup Guide](setup.md) to configure your environment.
