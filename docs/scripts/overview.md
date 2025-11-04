# Scripts Overview

The ShruggieTech Dev Handbook includes a collection of automation scripts to streamline common development tasks. Scripts are organized by platform and language for easy access.

## Available Script Collections

### 🔷 PowerShell Scripts
Windows-focused automation with cross-platform support via PowerShell Core.

**Location**: `/scripts/powershell/`

**Common Use Cases**:
- Windows system administration
- Azure resource management
- IIS configuration
- Active Directory operations
- File and folder management

[View PowerShell Scripts Documentation](powershell.md)

### 🐚 Bash Scripts
Linux and macOS shell automation for Unix-based systems.

**Location**: `/scripts/bash/`

**Common Use Cases**:
- Linux system administration
- Build automation
- Deployment workflows
- Log analysis
- Backup operations

[View Bash Scripts Documentation](bash.md)

### 🐍 Python Scripts
Cross-platform utilities that work on Windows, macOS, and Linux.

**Location**: `/scripts/python/`

**Common Use Cases**:
- Data processing
- API integrations
- File operations
- Web scraping
- Testing automation

[View Python Scripts Documentation](python.md)

## How to Use Scripts

### General Guidelines

1. **Check Prerequisites** - Ensure you have the required runtime installed
2. **Review Documentation** - Read the script's header comments or README
3. **Set Permissions** - Make scripts executable (Unix systems)
4. **Test Safely** - Run scripts in a test environment first
5. **Customize** - Modify scripts to fit your specific needs

### Security Best Practices

- ✅ Review script contents before execution
- ✅ Use environment variables for sensitive data
- ✅ Never hardcode credentials in scripts
- ✅ Keep scripts in version control
- ✅ Use secure protocols (HTTPS, SSH)
- ❌ Don't run scripts from untrusted sources
- ❌ Don't commit `.env` files or secrets

## Script Organization

Each script collection follows a consistent structure:

```
scripts/[platform]/
├── README.md              # Documentation for all scripts
├── setup/                 # Installation and configuration
├── utilities/             # General-purpose tools
├── maintenance/           # System maintenance tasks
└── examples/              # Sample scripts and templates
```

## Contributing Scripts

We welcome contributions! When adding new scripts:

1. **Follow Conventions** - Match the style of existing scripts
2. **Add Documentation** - Include clear comments and usage instructions
3. **Test Thoroughly** - Verify scripts work as expected
4. **Handle Errors** - Include proper error handling
5. **Update README** - Document new scripts in the appropriate README

See [Contributing Guidelines](../contributing.md) for details.

## Quick Reference

| Task | PowerShell | Bash | Python |
|------|-----------|------|--------|
| Setup Environment | ✅ | ✅ | ✅ |
| File Operations | ✅ | ✅ | ✅ |
| Git Automation | ✅ | ✅ | ✅ |
| System Info | ✅ | ✅ | ✅ |
| Web Requests | ✅ | ✅ | ✅ |

## Need Help?

- Check the specific script documentation pages
- Review script comments and help text
- Submit an issue on GitHub
- Consult the [Prerequisites](../getting-started/prerequisites.md) guide
